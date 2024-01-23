library(tidyverse)
library(cmdstanr)
library(posterior)
library(ggdist)
library(ggpubr)
library(ggrepel)


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
