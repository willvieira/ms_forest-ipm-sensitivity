library(tidyverse)
library(cmdstanr)
library(posterior)
library(ggdist)
library(ggpubr)
library(ggrepel)
library(ggtext)

data_path <- readLines('_data.path')
pars_path <- file.path(data_path, 'output_sim_processed')
models <- c(
  'growth' = 'intcpt_plot_comp_clim',
  'mort' = 'intcpt_plot_comp_clim',
  'recruit' = 'intcpt_plot_comp_clim'
)

# Using parameters from the `forest-IPM` repo
spIds <- read_csv(
  file.path(
    data_path, 'species_id.csv'
  )
) |>
mutate(
  shade = factor(shade, levels = c('tolerant', 'intermediate', 'intolerant')),
  shade_sylvics = factor(shade_sylvics, levels = c('very-tolerant',
                                            'tolerant',
                                            'intermediate',
                                            'intolerant',
                                            'very-intolerant'
                                            )),
  succession = factor(succession, levels = c('pioneer',
                                              'intermediate',
                                              'climax'))
) |>
filter(sp_to_analyze) |>
rowwise() |>
mutate(
  genus = unlist(strsplit(species_name, ' '))[1],
  epithet = unlist(strsplit(species_name, ' '))[2],
  species_name = paste(substr(genus, 1, 1), epithet, sep = ' ')
)

map_dfr(
  spIds$species_id_old,
  ~ readRDS(
    paste0(
      pars_path, '/growth/', models['growth'], '/posterior_pop_', .x, '.RDS'
    )
  ) |>
  pivot_wider(names_from = par) |>
  bind_cols(species_id = .x)
) ->
pars_growth

map_dfr(
  spIds$species_id_old,
  ~ readRDS(
    paste0(
      pars_path, '/mort/', models['mort'], '/posterior_pop_', .x, '.RDS'
    )
  ) |>
  pivot_wider(names_from = par) |>
  bind_cols(species_id = .x)
) ->
pars_mort

map_dfr(
  spIds$species_id_old,
  ~ readRDS(
    paste0(
      pars_path, '/recruit/', models['recruit'], '/posterior_pop_', .x, '.RDS'
    )
  ) |>
  pivot_wider(names_from = par) |>
  bind_cols(species_id = .x)
) ->
pars_rec


treeData <- readRDS(file.path(data_path, 'treeData.RDS')) |>
  filter(species_id %in% spIds$species_id_old)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Intercept
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

parsGrowth_mean <- pars_growth |>
  group_by(species_id) |>
  reframe(
    Lmax = mean(Lmax),
    r = mean(r)
  ) |>
  left_join(
    spIds,
    by = c('species_id' = 'species_id_old')
  ) 

pars_growth |>
  left_join(
    spIds,
    by = c('species_id' = 'species_id_old')
  ) |>
  ggplot() +
  aes(max_size/10, Lmax/10, group = species_id) +
  # aes(color = shade_sylvics) +
  stat_pointinterval(alpha = 0.4) +
  geom_abline(slope = 1, intercept = 0, alpha = 0.3) +
  geom_text_repel(
    data = parsGrowth_mean,
    aes(x = max_size/10, y = Lmax/10, label = species_name),
    alpha = 0.8,
    size = 2.6,
    fontface = 'italic',
    max.overlaps = 12
  ) +
  theme_classic() +
  labs(
    x = 'Maximum observed dbh (cm)',
    y = expression('Maximum predicted dbh ('~zeta[infinity]~')'),
    subtitle = 'Growth'
  ) ->
p1



parsMort_mean <- pars_mort |>
  group_by(species_id) |>
  reframe(psi = mean(psi)) |>
  left_join(
    spIds,
    by = c('species_id' = 'species_id_old')
  ) 

pars_mort |>
  left_join(
    spIds,
    by = c('species_id' = 'species_id_old')
  ) |>
  ggplot() +
  aes(max_age, exp(psi), group = species_id) +
  # aes(color = shade_sylvics) +
  stat_pointinterval(alpha = 0.4) +
  geom_abline(slope = 1, intercept = 0, alpha = 0.3) +
  geom_text_repel(
    data = parsMort_mean,
    aes(x = max_age, y = exp(psi), label = species_name),
    alpha = 0.8,
    size = 2.6,
    fontface = 'italic',
    max.overlaps = 12
  ) +
  theme_classic() +
  labs(
    x = 'Maximum observed age (years)',
    y = 'Expected longevity (L)',
    subtitle = 'Survival'
  ) ->
p2

png(
  filename = file.path('manuscript', 'figs', 'crossGrowthSurv.png'),
  width = 8, height = 3.7, units = 'in', res = 300
)
ggarrange(p1, p2, ncol = 2)
dev.off()

# correlation R2
summary(lm(Lmax ~ max_size, parsGrowth_mean))
summary(lm(exp(psi) ~ max_age, parsMort_mean))



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Intercept - Growth vs Survival vs Recruitment
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


pars_growth |>
  select(species_id, iter, r) |>
  left_join(
    pars_mort |>
      select(species_id, iter, psi)
  ) |>
  left_join(
    pars_rec |>
      select(species_id, iter, mPop_log)
  ) |>
  group_by(species_id) |>
  reframe(
    r = mean(r),
    psi = mean(psi),
    mPop_log = mean(mPop_log)
  ) |>
  left_join(spIds, by = c('species_id' = 'species_id_old')) ->
pars_mean

pars_growth |>
  select(species_id, iter, r) |>
  left_join(
    pars_mort |>
      select(species_id, iter, psi)
  ) |>
  left_join(
    pars_rec |>
      select(species_id, iter, mPop_log)
  ) |>
  left_join(spIds, by = c('species_id' = 'species_id_old')) |>
  ggplot() +
  aes(r,  psi) +
  aes(group = species_id) +
  ggdensity::geom_hdr(
    color = NA,
    method = 'mvnorm',
    probs = 0.9
  ) +
  geom_point(data = pars_mean) +
  geom_text_repel(
    data = pars_mean,
    aes(x = r, y = psi, label = species_name),
    alpha = 0.8,
    size = 2.6,
    fontface = 'italic',
    max.overlaps = 12
  ) +
  theme_classic() +
  theme(legend.position = 'none') +
  labs(
    x = expression(Gamma),
    y = expression(psi)
  ) ->
p1


pars_growth |>
  select(species_id, iter, r) |>
  left_join(
    pars_mort |>
      select(species_id, iter, psi)
  ) |>
  left_join(
    pars_rec |>
      select(species_id, iter, mPop_log)
  ) |>
  left_join(spIds, by = c('species_id' = 'species_id_old')) |>
  ggplot() +
  aes(r,  mPop_log) +
  aes(group = species_id) +
  ggdensity::geom_hdr(
    color = NA,
    method = 'mvnorm',
    probs = 0.9
  ) +
  geom_point(data = pars_mean) +
  geom_text_repel(
    data = pars_mean,
    aes(x = r, y = mPop_log, label = species_name),
    alpha = 0.8,
    size = 2.6,
    fontface = 'italic',
    max.overlaps = 12
  ) +
  theme_classic() +
  theme(legend.position = 'none') +
  labs(
    x = expression(Gamma),
    y = expression(phi)
  ) ->
p2

png(
  filename = file.path('manuscript', 'figs', 'intercept_corr.png'),
  width = 9, height = 4.25, units = 'in', res = 300
)
print(ggarrange(p1, p2, nrow = 1))
dev.off()



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Competition
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pars_growth |>
  group_by(species_id) |>
  reframe(
    Beta = mean(Beta),
    theta = mean(theta)
  ) |>
  mutate(
    Con = Beta,
    Het = Beta * theta
  ) |>
  pivot_longer(cols = c(Con, Het)) |>
  bind_cols(vr = 'Growth') |>
  bind_rows(
    pars_mort |>
      group_by(species_id) |>
      reframe(
        Beta = mean(Beta),
        theta = mean(theta)
      ) |>
      mutate(
        Con = Beta,
        Het = Beta * theta
      ) |>
      pivot_longer(cols = c(Con, Het)) |>
      bind_cols(vr = 'Survival')
  ) |>
  left_join(
    spIds,
    by = c('species_id' = 'species_id_old')
  ) |>
  mutate(
    name = case_match(
      name,
      'Con' ~ 'Conspecific',
      'Het' ~ 'Heterospecific'
    )
  ) |>
  ggplot() +
  aes(shade_sylvics, value) +
  aes(color = name, fill = name) +
  facet_wrap(~vr) +
  geom_boxplot(fill = 'transparent', outlier.color = 'transparent') +
  geom_point(
    position = position_jitterdodge(jitter.width = .2),
    shape = 21,
    color = 'grey',
    alpha = 0.8,
    size = 1.6
  ) +
  scale_fill_manual(values = c('#ef8a62', '#67a9cf')) +
  scale_color_manual(values = c('#ef8a62', '#67a9cf')) +
  labs(
    x = NULL,
    y = expression('Density dependence effect ('~beta~')'),
    fill = NULL, color = NULL
  ) +
  theme_classic() +
  theme(
    legend.position = 'bottom',
    strip.background = element_blank(),
    strip.text = element_text(size = rel(1), hjust = 0)
  ) +
  ylim(-0.076, 0.02) +
  geom_hline(yintercept = 0, linetype = 2, alpha = 0.4) ->
p


png(
  filename = file.path('manuscript', 'figs', 'crossComp.png'),
  width = 8, height = 4.25, units = 'in', res = 300
)
print(p)
dev.off()



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Competition - conspecific density-dependence vs growth
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pars_growth |>
  group_by(species_id) |>
  reframe(
    Beta = mean(Beta),
    theta = mean(theta)
  ) |>
  mutate(
    Con = Beta,
    Het = Beta * theta
  ) |>
  pivot_longer(cols = c(Con, Het)) |>
  bind_cols(vr = 'Growth') |>
  bind_rows(
    pars_mort |>
      group_by(species_id) |>
      reframe(
        Beta = mean(Beta),
        theta = mean(theta)
      ) |>
      mutate(
        Con = Beta,
        Het = Beta * theta
      ) |>
      pivot_longer(cols = c(Con, Het)) |>
      bind_cols(vr = 'Survival')
  ) |>
  left_join(
    spIds,
    by = c('species_id' = 'species_id_old')
  ) |>
  mutate(
    name = case_match(
      name,
      'Con' ~ 'Conspecific',
      'Het' ~ 'Heterospecific'
    )
  ) ->
plot_dt

plot_dt |>
  group_by(species_name, vr, name) |>
  reframe(value = mean(value)) |>
  left_join(spIds) ->
pars_mean

plot_dt |>
  ggplot() +
  aes(growth_rate, value) +
  aes(color = name, fill = name) +
  facet_wrap(~vr) +
  geom_boxplot(fill = 'transparent', outlier.color = 'transparent') +
  geom_point(
    position = position_jitterdodge(jitter.width = .2),
    shape = 21,
    color = 'grey',
    alpha = 0.8,
    size = 1.6
  ) +
  # geom_text_repel(
  #   data = pars_mean |> filter(vr == 'Survival' & value < -0.05),
  #   aes(x = growth_rate, y = value, label = species_name),
  #   alpha = 0.8,
  #   size = 2.6,
  #   fontface = 'italic',
  #   max.overlaps = 12
  # ) +
  scale_fill_manual(values = c('#ef8a62', '#67a9cf')) +
  scale_color_manual(values = c('#ef8a62', '#67a9cf')) +
  labs(
    x = NULL,
    y = expression('Density dependence effect ('~beta~')'),
    fill = NULL, color = NULL
  ) +
  theme_classic() +
  theme(
    legend.position = 'bottom',
    strip.background = element_blank(),
    strip.text = element_text(size = rel(1), hjust = 0)
  ) +
  geom_hline(yintercept = 0, linetype = 2, alpha = 0.4) ->
p


png(
  filename = file.path('manuscript', 'figs', 'comp_CNDD_vs_growth.png'),
  width = 9, height = 4.25, units = 'in', res = 300
)
print(p)
dev.off()





#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Climate - optimal MAT vs species MAT midpoint 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

treeData |>
  group_by(species_id) |>
  reframe(
    mid_temp = (max(bio_01_mean_scl, na.rm = TRUE)+min(bio_01_mean_scl, na.rm = TRUE))/2,
    mid_prec = (max(bio_12_mean_scl, na.rm = TRUE)+min(bio_12_mean_scl, na.rm = TRUE))/2
  ) ->
sp_mid

# get niche mean of each species to make point color in function of how climate is important

c('growth', 'mort', 'rec') |>
  set_names() |>
  map_dfr(
    ~get(paste0('pars_', .x)) |>
      select(species_id, iter, tau_temp),
    .id = 'vr'
  ) |>
  group_by(vr, species_id) |>
  reframe(tau_temp = mean(tau_temp))  |>
  group_by(vr) |>
  # scale between 0 and 1 for alpha
  mutate(
    tau_temp_scl = (tau_temp - min(tau_temp))/(max(tau_temp) - min(tau_temp))
  ) |>
  ungroup() ->
tau_temp

c('growth', 'mort', 'rec') |>
  set_names() |>
  map_dfr(
    ~get(paste0('pars_', .x)) |>
      select(species_id, iter, optimal_temp),
    .id = 'vr'
  ) |>
  left_join(tau_temp) |>
  mutate(
    vr = case_match(
      vr,
      'growth' ~ 'Growth',
      'mort' ~ 'Survival',
      'rec' ~ 'Recruitment'
    )
  ) |>
  left_join(sp_mid) ->
plot_dt

plot_dt |>
  group_by(species_id, vr) |>
  reframe(
    optimal_temp = mean(optimal_temp),
    tau_temp_scl = mean(tau_temp_scl),
    mid_temp = mean(mid_temp)
  ) |>
  left_join(spIds, by = c('species_id' = 'species_id_old')) ->
plot_dt_name

plot_dt |>
  ggplot() +
  aes(mid_temp, optimal_temp) +
  aes(alpha = tau_temp_scl) +
  facet_wrap(~vr) +
  stat_pointinterval() +
  geom_text_repel(
    data = plot_dt_name |> filter(tau_temp_scl >= 0.5),
    aes(x = mid_temp, y = optimal_temp, label = species_name),
    size = 2.6,
    fontface = 'italic',
    color = '#ef8a62'
  ) +
  geom_abline(slope = 1, intercept = 0) +
  labs(
    x = 'Mean annual temperature midpoint (scaled)',
    y = expression('Optimal mean annual temperature ('~xi~')'),
    alpha = 'Niche breadth'
  ) +
  theme_classic() +
  theme(
    legend.position = 'bottom',
    strip.background = element_blank(),
    strip.text = element_text(size = rel(1), hjust = 0)
  ) ->
p

png(
  filename = file.path('manuscript', 'figs', 'temp_optimal_rangeLocation.png'),
  width = 9, height = 4.25, units = 'in', res = 300
)
print(p)
dev.off()



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Sensitivity cold, CENTER, border
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

out <- readRDS(file.path(data_path, 'simulation_data', 'covariates_perturbation.RDS'))

# function to determine if a plot is at lower, center, or upper border
# given how much of the tail we consider border (prob arg) [0-0.5]
which_border <- function(temp, prob = 0.1, naRm = TRUE) {
  temp_range = quantile(temp, probs = c(prob, 1 - prob), na.rm = naRm)
  # output vector with 'center' class
  out_pos = rep('Center', length(temp))
  # lower border
  out_pos[temp < temp_range[1]] = 'Cold'
  out_pos[temp > temp_range[2]] = 'Hot'
  
  return(out_pos)
}

# class of range position (cold, center, hot)
treeData |>
  group_by(species_id, plot_id) |>
  # get a single obs per plot to remove abundance effect
  reframe(bio_01_mean = mean(bio_01_mean)) |>
  group_by(species_id) |>
  mutate(
    border_cl = which_border(bio_01_mean, prob = 0.1)
  ) |>
  select(species_id, plot_id, border_cl) |>
  mutate(border_cl = factor(border_cl, levels = c('Cold', 'Center', 'Hot'))) ->
plotBorder_class

out |>
  # three species that had the lowest AME (low sensitivity to covariates)
  # filter(!species_id %in% c('NAQUEPRI', '19290QUEALB', '27821NYSSYL')) |>
  # filter(species_id == '18032ABIBAL') |>
  mutate(
    clim = log(par.temp + par.prec),
    comp = log(par.BA_con + par.BA_het),
    ccr = comp - clim
  ) |>
  left_join(plotBorder_class) |>
  select(species_id, border_cl, rep, clim, comp) |>
  group_by(species_id, border_cl) |>
  reframe(
    Climate = mean(clim),
    Competition = mean(comp)
  ) |>
  # filter(border_cl != 'Center') |>
  pivot_longer(
    cols = c(Climate, Competition),
    names_to = 'covariable'
  ) |>
  pivot_wider(names_from = border_cl, values_from = value) |>
  mutate(
    d_cold = Cold - Center,
    d_hot = Hot - Center,
    d_d = d_cold + d_hot
  ) |>
  pivot_longer(cols = c(Cold, Hot, Center), names_to = 'border_cl') |>
  left_join(    
    treeData |>
      left_join(plotBorder_class) |>
      group_by(species_id, border_cl) |>
      reframe(
        range_pos = median(bio_01_mean, na.rm = TRUE)
      ) |>
      mutate(range_pos = range_pos + rnorm(n(), 0, 0.001))
  ) |>
  ggplot() +
  aes(range_pos, value) +
  geom_line(aes(color = d_d, group = species_id)) +
  facet_wrap(~covariable) +
  scale_color_gradient2() +
  scale_fill_gradient2() +
  theme_classic() +
  labs(
    x = 'Mean annual temperature (°C)',
    y = 'ln(Sensitivity)',
    color = "Curvature index<br>(<span style='color:#6863A9;'>concave</span> ↔ <span style='color:#9B5C54;'>convex</span>)"
  ) +
  theme(legend.title = element_markdown()) ->
p

png(
  filename = file.path('manuscript', 'figs', 'sensitivity_withCenter.png'),
  width = 9, height = 4.25, units = 'in', res = 300
)
print(p)
dev.off()
