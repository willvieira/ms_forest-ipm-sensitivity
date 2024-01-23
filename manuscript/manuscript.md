# Introduction

The urge to unravel species distribution processes has increased with the current global crisis, where 15 to 37% of species are expected to face extinction due to climate change [@thomas2004].
This urgency is particularly pertinent for long-lived sessile species like trees, whose range distribution is likely to fail to follow climate change [@Zhu2012;@Sittaro2017].
In an effort to enhance traditional correlative species distribution models [e.g. @Guisan2000], theory decomposes species distribution into smaller components to develop a more mechanistic, process-based approach [@Evans2016].
One such approach is demographic range models, which predicts a species' distribution based on individual performance determined by growth, survival, and recruitment demographic rates [@Pagel2012].
This approach operates under the hypothesis that population growth rate ($\lambda$), determined by demographic rates, varies across the environment, with the species range limit defined by conditions where $\lambda$ is non-negative [@maguire1973niche;@Holt2009].
By approaching species distribution from a demographic perspective, we can account for the complexity of forest dynamics arising from multiple features such as environment and species interaction [Schurr2012;@Svenning2014].

Several studies have attempted to predict species distribution based on demographic performance.
The fundamental version of these models uses environment-dependent demographic rates to predict $\lambda$ [e.g. @Merow2014;@Csergo2017].
However, factors like competition undeniably influence both demographic rates [@Luo2011;@Clark2011;@Zhang2015] and population performance [@Scherrer2020;@LeSquin2021] in forest trees.
This realized version of the niche [@Hutchinson1957] may explain why North American forest trees often do not occur within their climatically suitable range [@BoucherLalonde2012;@Talluto2017].

Despite theoretical predictions, an increasing body of evidence indicates weak correlations between the demographic performance of trees and their distribution [@McGill2012;@Thuiller2014;@Csergo2017;@bohner2020;@LeSquin2021;@Midolo2021;@Guyennon2023].
This mismatch is often attributed to the oversight of processes beyond climate and competition.
For instance, habitat availability coupled with dispersal limitations can restrict a species' distribution even in locations where performance is positive [@Pulliam2000].
However, the precision of methods used to quantify demographic performance is rarely challenged, perhaps in part because each attempt employs a different approach.
Some studies assess performance based solely on one of the growth, survival, or recruitment rates [@McGill2012;@bohner2020].
When demographic rates are integrated into population models, specific components, such as recruitment, are often overlooked due to data limitations [@Kunstler2021;@LeSquin2021].
Moreover, some studies do not account for density-dependence [@Csergo2017;@Ohse2023], and when they do, they rarely differentiate between conspecific and heterospecific competition [@bohner2020;@LeSquin2021; but see @Guyennon2023].

Rather than asking whether demographic performance correlates with distribution, a more fruitful question may be how climate and competition influence demographic performance.
Indeed, we still miss a comprehensive understanding of the sensitivity of forest dynamics to its drivers [@Ohse2023].
For instance, @Clark2011 found that individual growth is more sensitive to competition, while fecundity is more sensitive to climate.
In contrast, @CopenhaverParry2016 found that growth was more sensitive to climate than competition.
These studies provide crucial insights into how forest trees will respond to climate change and forest management, supporting conservation planning.
However, they only assess the importance of climate and competition on single demographic models, lacking a complete picture of population dynamics.
Furthermore, it is expected that the sensitivity of $\lambda$ to each of these components to be dependent on the species range position, such as climate being relatively more important in abiotic stressful conditions and competition being more critical when climate is benign [@Louthan2015].
Nevertheless, such information is still lacking for trees [@Ohse2023].

Here, we evaluate how climate and competition affect the demography and population growth rate of the 31 most abundant forest tree species across Eastern North America.
We leverage the complete (26 - 53°) latitudinal coverage of forest inventories across the US and Canada to capture the biogeographical range distribution of these species.
Specifically, we model each of the growth, survival, and recruitment vital rates as a function of mean annual temperature and precipitation, as well as conspecific and heterospecific basal area density, serving as a proxy for competition for light.
We use flexible non-linear hierarchical Bayesian models to capture the multiple effect forms of climate and competition while accounting for model uncertainty at different organizational scales.
These demographic rate models are then incorporated into an Integral Projection Model (IPM) to quantify the $\lambda$ of each species under climate and competition effects.

Our primary goal is to use the fitted IPM to compute the sensitivity of each species' $\lambda$ to climate and competition across its range distribution.
Employing perturbation analysis, we quantify the relative contribution of each covariate to changes in $\lambda$ [@Caswell2000].
Precisely, we assess the species sensitivity of an observed $\lambda$ for each plot-year combination based on their specific climate and competition conditions.
This approach enables an evaluation of the overall sensitivity of $\lambda$ to a covariate while considering the inherent variability of the covariate experienced by the species.
For instance, a species may exhibit high sensitivity to temperature, but if most of its distribution is observed under optimal temperature conditions, the average sensitivity of the species will be low.
Additionally, by computing sensitivity at the plot level, we categorize each species plot into cold, center, or hot locations across the temperature axis to understand how sensitivity to climate and competition changes across the range distribution.
Specifically, we ask whether sensitivity to climate and competition changes between each species' cold and hot ranges.
Finally, we explore if the relative sensitivity between climate and competition changes across the species range distribution.
Our integrative approach allows us to assess the relative effects of climate and competition from demographic rates up to the population growth rate while accounting for model uncertainties, revealing essential insights into understanding the response of forest trees to climate change, management practices, and conservation efforts.

# Methods

## Forest inventory and climate data

We used two open inventory datasets from eastern North America: the Forest Inventory and Analysis (FIA) dataset in the United States [@OConnell2007] and the Forest Inventory of Québec [@Naturelles2016].
At the plot level, we focused on plots sampled at least twice, excluding those that had undergone harvesting to concentrate solely on natural dynamics.
Specifically, we selected surveys conducted for the FIA dataset using the modern standardized methodology implemented since 1999.
After applying these filters, our final dataset encompassed nearly 26,000 plots spanning a latitude range from 26° to 53° (Figure S1).
Each plot within the dataset was measured between 1970 and 2021, with observation frequencies ranging from 2 to 7 times and an average of 3 measurements per plot.
The time intervals between measurements varied from 1 to 40 years, with a median interval of 7 years (Figure S1).

These datasets provide individual-level information on the diameter at breast height (DBH) and the status (dead or alive) of more than 200 species.
From this pool, we selected the 31 most abundant species (Table S1).
This selection comprises nine conifer species and 21 hardwood species.
We ensured an even distribution of species across the continuous shade tolerance trait, with three species classified as very intolerant, nine as intolerant, eight as intermediate, eight as tolerant, and five as very tolerant [@burns1990silvics].

We computed the plot-level density using the DBH of each individual as a competition metric.
Specifically, we quantified asymmetric competition for light for a focal individual by summing the total basal area of all individuals larger than the focal one, herein BAL.
We further split BAL into the total density of conspecific and heterospecific individuals.
For the climate variable, we obtained the 19 bioclimatic variables with a 10 $km^2$ (300 arcsec) resolution grid, covering the period from 1970 to 2018.
These climate variables were modeled using the ANUSPLIN interpolation method [@McKenney2011].
We used the plot's longitude and latitude coordinates to extract the mean annual temperature (MAT) and mean annual precipitation (MAP).
To incorporate the climate covariates in the dataset, we used each plot's latitude and longitude coordinates to extract the mean annual temperature (MAT) and mean annual precipitation (MAP).
In cases where plots did not fall within a valid pixel of the climate variable grid, we interpolated the climate condition using the eight neighboring cells.
Due to the transitional nature of the dataset, we considered both the average and standard deviation of MAT and MAP over the years within each time interval.

## Model

We determine the dynamics of the 31 forest species using an Integral Projection Model (IPM).
The IPM is a category of mathematical tools used to improve our understanding of population dynamics.
It distinguishes itself from traditional population models by assuming the population is structured based on a continuous trait [@Easterling2000].
This is especially relevant for trees due to the considerable variability in demographic rates depending on individual size [@kohyama1992].
Specifically, the IPM consists of a set of functions predicting the transition of a distribution of individual traits from time $t$ to time $t+1$:

$$
n(z', t + 1) = \int_{L}^{U} \, k(z', z, \theta)\, n(z, t)\, \mathrm{d}z
$${#eq:ipm}

In this context, the continuous trait $z$ at time $t$ represents the DBH, and $n(z, t)$ characterizes the continuous DBH distribution for a population.
The probability of the population distribution size from $n(z, t)$ to $n(z', t+1)$ is governed by the kernel $K$ and the species-specific parameters $\theta$.
The kernel $K$ is composed of three sub-models:

$$
k(z', z, \theta) = [Growth(z', z, \theta) \times Survival(z, \theta)] + Recruitment(z, \theta)
$${#eq:kernel}

The growth function describes how individual trees increase in size, while the survival function determines the probability of staying alive throughout their lifespan.
The recruitment model describes the number of individuals ingressing the population, identified by their size surpassing the 12.7 cm threshold.
Below, we describe the basic (intercept) version of these models, followed by the inclusion of each climate and competition covariate.

### Demographic rates

**Growth** - To characterize the annual growth rate in DBH of an individual $i$, we chose the von Bertalanffy growth equation [@von1957quantitative].
Predicting the size at time $t+\Delta t$ from the initial size $z_{i, t}$ of an individual at time $t$ is given by:

$$
  z_{i, t+\Delta t} = z_{i,t}  \times e^{-\Gamma \Delta t} + \zeta_{\infty} (1- e^{-\Gamma \Delta t})
$$ {#eq:VBmodel}

Where $\Delta t$ is the time interval between the initial and final size measurements and $\Gamma$ represents a dimensionless growth rate coefficient.
$\zeta_{\infty}$ denotes the asymptotic size, which is the location at which growth approximates to zero.
The rationale behind this model is that the growth rate exponentially decreases with size, converging to zero as size approaches $\zeta_{\infty}$.
This assumption is particularly valuable in the context of the IPM, as it prevents eviction — where individuals are projected beyond the limits of the size distribution ($[L, U]$) defined by the Kernel.
The final likelihood growth model accounting for individual variability is defined as follows: 

\begin{align}
&dbh_{i,t + \Delta t} \sim \mathcal{N}(\mu, \sigma) \\
&\mu = dbh_{i,t} \times e^{-\Gamma \Delta t} + \zeta_{\infty} (1- e^{-\Gamma \Delta t})
\end{align}

**Survival** - The chance of a mortality event ($M$) for an individual $i$ within the time interval between $t$ and $t+\Delta t$ is modeled as a Bernoulli distribution:

$$
M_i \sim \mathcal{Bernoulli}(p_i)
$${#eq:survL}

Here, $M_i$ represents the individual's status (alive/dead) and $p_i$ the mortality probability of the individual $i$.
The mortality probability is calculated based on the annual survival rate ($\psi$) and the time interval between census ($\Delta t$):

$$
p_i = 1 - \psi^{\Delta t}
$${#eq:survP}

The model assumes that the survival probability ($1 - p_i$) increases with the longevity parameter $\psi$, but is compensated exponentially with the increase in time $\Delta t$.

**Recruitment** - We combined data from the U.S. and Quebec forest inventories to obtain a broader range of climatic conditions.
However, these inventories have inconsistent protocols for recording seedlings, saplings, and juveniles.
Therefore, we quantified the recruitment rate ($I$) as the ingrowth of new individuals into the adult population, defined as those with a DBH exceeding 12.7 cm.
The quantity $I$ encompasses the processes of fecundity, dispersal, growth, and survival up to reaching the size threshold.
Similar to growth and survival, the count of ingrowth individuals ($I$) reaching the 12.7 cm size threshold depends on the time interval between measurements.
Therefore, we introduce two parameters to control the potential number of recruited individuals.
We introduce two parameters to control the potential number of recruited individuals: $\phi$, determining the annual ingrowth rate per square meter, and $\rho$, denoting the annual survival probability of each ingrowth individual:

$$
  I \sim \mathcal{Poisson}(~\phi \times A \times \frac{1 - p^{\Delta t}}{1-p}~)
$${#eq:rec}

Where $A$ represents the area of the plot in square meters.
The model assumes that new individuals enter the population annually at a rate of $\phi$, and their likelihood of surviving until the subsequent measurement ($\rho$) declines over time.
Once an individual is recruited into the population, a submodel determines its initial size $z_I$, increasing linearly with time:

$$
  z_{I} \sim \mathcal{TNormal}(\Omega + \beta \Delta t,~\sigma, ~ \alpha, ~ \beta)
$${#eq:recSize}

The $\mathcal{TNormal}$ is a truncated distribution with lower and upper limits determined by the $\alpha$ and $\beta$ parameters, respectively.
We set $\alpha$ to 12.7 cm, aligning it with the ingrowth threshold, while $\beta$ is set to infinity to allow for an unbounded upper limit.

### Covariates

**Random effects** - We introduced plot-level random effects in each demographic model to account for shared variance between individuals within the same plot.
For a demographic model with an average intercept $\overline{I}$, an offset value ($\alpha$) is drawn for each plot $j$ from a normal distribution with a mean of zero and variance $\sigma$:

\begin{align}
  &\alpha_{j} \sim \mathcal{N}(0, \sigma) \\
  &I_j = \overline{I} + \alpha_j
\end{align}

Where $\sigma$ represents the variance among all plots $j$ and $I$ can take one of three forms: $\Gamma$ for growth, $\psi$ for survival, and $\phi$ for the recruitment model.

**Competition** - We used BAL (asymmetric competition) instead of BA (symmetric competition), assuming that competition for light is the primary competitive factor driving forest dynamics.
Therefore, each of the growth ($\Gamma$), longevity ($\psi$), and recruitment survival ($\rho$) parameters changes exponentially with BAL.
Take $I$ as one of the three parameters, the effect of BAL on $I$ is driven by two parameters describing the conspecific ($\beta$) and heterospecific ($\theta$) competition:

$$
  I + \beta (BAL_{cons} + \theta \times BAL_{het})
$$

When $\theta < 1$, conspecific competition is stronger than heterospecific competition.
Conversely, heterospecific competition prevails when $\theta > 1$, and when $\theta = 1$, there is no distinction between conspecific and heterospecific competition.
Note that $\beta$ is also unbounded, allowing it to converge towards negative (indicating competition) or positive (indicating facilitation) values.
Furthermore, we fixed $\theta = 1$ for the recruitment ($I = \rho$) due to model convergence issues.
The recruitment model also accounts for the conspecific density-dependence effect on the annual ingrowth rate ($\phi$).
Specifically, $\phi$ increases with $BAL_{cons}$ as a positive effect of seed source up to reach the optimal density of recruitment, $\delta$, where it then decreases with more conspecific density due to competition at a rate proportional to $\sigma$:

$$
  \phi + \left(\frac{BAL_{cons} - \delta}{\sigma}\right)^2
$${#eq:compingrowth}

**Climate** - We selected mean annual temperature (MAT) and mean annual precipitation (MAP) bioclimatic variables as they are widely used in species distribution modeling.
Each demographic model $I$, representing either $\Gamma$ for growth, $\psi$ for longevity, or $\phi$ for ingrowth, varies as a bell-shaped curve determined by an optimal climate condition ($\xi$) and a climate breadth parameter ($\sigma$):

$$
  I + \left(\frac{MAT - \xi_{MAT}}{\sigma_{MAT}}\right)^2 + \left(\frac{MAP - \xi_{MAP}}{\sigma_{MAP}}\right)^2
$${#eq:compEffect}

The climate breadth parameter ($\sigma$) influences the strength of the specific climate variable's effect on each demographic model.
This unimodal function is flexible, assuming various shapes, such as bell, quasi-linear, or flat shapes.
However, this flexibility introduces the possibility of parameter degeneracy or redundancy, where different combinations of parameter values yield similar outcomes.
To address this issue, we constrained the optimal climate condition parameter ($\xi$) within the observed climate range for the species, assuming that the optimal climate condition falls within our observed data range.

### Model fit and validation

We fitted each of the growth, survival, and recruitment models separately for each species, using the Hamiltonian Monte Carlo (HMC) algorithm via the Stan software [version 2.30.1 @stan2022stan] and the `cmdstandr` R package [version 0.5.3 @cmdstanr].
We build and fit each demographic model incrementally, from a simple intercept, and gradually incorporate plot random effects, competition, and climate covariates.
We recall that our goal is not to have the most complex model to achieve the highest predictive metric but to make inferences [@Tredennick2021].
We focus on assessing the relative effects of climate and competition while controlling for other influential factors.
Therefore, our modeling approach is guided by biological mechanisms, which tend to provide more robust extrapolation [@Briscoe2019] rather than being solely dictated by specific statistical metrics.
Nevertheless, we check if increasing model complexity with new covariates does not result in worse performance using complementary metrics such as mean squared error (MSE), pseudo $R^2$, and Leave-One-Out Cross-Validation (LOO-CV).
Detailed discussions regarding model fit, diagnostics, and model comparison can be found in supplementary material 1.

With the fitted demographic models, we constructed the Kernel $K$ of the IPM following Equation @eq:kernel.
We employed the mid-point rule to perform the discrete-form integration of the continuous $K$ [@Ellner2016].
This involved discretizing $K$ using bins of 0.1 cm, which are considered appropriate for obtaining unbiased estimates [@zuidema2010integral].
Finally, we computed the asymptotic population growth rate ($\lambda$) using the leading eigenvalue of the discretized matrix $K$.

## Perturbation analysis

We use perturbation analysis to assess the sensitivity of $\lambda$ to competition and climate conditions [@Caswell2000].
We define sensitivity as the partial derivative of $\lambda$ with respect to a covariate $X$, which can take the form of either conspecific or heterospecific density-dependence competition, or temperature or precipitation climate conditions.
In practice, we quantify sensitivity by slightly increasing each covariate value $X_i$ to $X_i'$ and computing the change in $\lambda$ following the right-hand part of Equation @eq:sens:

$$
	\frac{\partial \lambda_i}{\partial X_i} \approx \frac{\Delta \lambda_i}{\Delta X_i} = \frac{|f(X_i') - f(X_i)|}{X_i' - X_i}
$${#eq:sens}

We perform this process for each species across all plot-year observations $i$ to gauge the sensitivity of $\lambda$ that is proportional to the conditions experienced by the species.
We set the perturbation size to a 1% increase in the normalized scale for each covariate.
For instance, a 1% increase translates to a rise of 0.3°C for Mean Annual Temperature (MAT) and 26 mm for Mean Annual Precipitation (MAP).
Because the competition metric is computed at the individual level, the perturbation was applied at each individual, where a 1% increase corresponds to a rise of 1.2 cm in dbh.
As we were interested in the absolute difference, the resulting sensitivity value ranges between 0 and infinity, with lower values indicating a lower sensitivity of $\lambda$ to the specific covariate.

We further computed the log ratio between competition and climate ($CCR$) sensitivities to discern their relative effects as follows:

\begin{align}
&S_{comp, i} = \frac{\partial \lambda_i}{\partial BA_{cons, i}} + \frac{\partial \lambda_i}{\partial BA_{het, i}}\\
&S_{clim, i} = \frac{\partial \lambda_i}{\partial MAT_{i}} + \frac{\partial \lambda_i}{\partial MAP_{i}}\\
&CCR_i = \text{ln} \frac{S_{comp, i}}{S_{clim, i}}
\end{align}

Here, $S$ represents the total sensitivity to competition or climate.
Negative $CCR$ values indicate higher sensitivity of $\lambda$ to climate, while positive values suggest the opposite.
The code used to perform this analysis is hosted at the [`forest-IPM`](https://github.com/willvieira/forest-IPM/tree/master/simulations/covariates_perturbation) GitHub repository.

# Results

## Model validation

All species-specific demographic models demonstrated convergence with $\hat{R} <1.05$ and low to no divergent iterations.
In comparing the simple intercept model with the more complete versions, the LOO-CV consistently favored the complete model for all three demographic rates, featuring plot random effects, competition, and climate covariates, over other competing models.
The absolute values of LOO-CV suggested that the growth model gained the most information from including covariates, followed by recruitment and survival models.
To further validate our approach, we compared known trait groups from the literature, leveraging the mechanistic equations characterizing each demographic model.
Specifically, we used traits of growth rate classes, maximum observed size, maximum observed age, shade tolerance, and seed mass [@burns1990silvics;@diaz2022].

The growth model intercept comprises two parameters, one determining the asymptotic size ($\zeta_{\infty}$) and the annual growth rate $\Gamma$.
The $\zeta_{\infty}$ can be interpreted as the maximum predicted size of the species, which correlates well across all 31 species with the maximum observed size in the literature ($R^2 = 0.31$, Figure @fig:crossGrowthSurv).
Similarly, $\Gamma$ among the species exhibited a distribution aligning with the fast, moderate, and slow-growing traits (Figure SX).
In the survival model, the expected longevity ($L$) can be derived from the annual survival rate ( $\psi$) following the equality $L = e^{\psi}$, showing a high correlation with the maximum observed age in the literature ($R^2 = 0.59$, Figure @fig:crossGrowthSurv).
In the recruitment model, the log of the annual ingrowth rate ($\phi$) reduced linearly with seed mass, capturing the seed mass-growth rate tradeoff [@Reich1998].
Additionally, the annual survival probability of ingrowth ($\rho$) decreased with intolerance to shade (Figure SX).

![Correlation between predicted asymptotic size ($\zeta_{\infty}$) with maximum observed size (left) and predicted longevity ($L$) with maximum observed age for the 31 forest species. Maximum observed size and age are obtained from @burns1990silvics. The gray line is the identity curve.](manuscript/figs/crossGrowthSurv.png){#fig:crossGrowthSurv width=100%}

For competition effects, both conspecific and heterospecific competition effects for the growth and survival models increased with intolerance to shade (Figure @fig:crossComp).
The stronger competition effect of conspecific over heterospecific was consistent for almost all species in both growth and survival models.
Only two species for growth and three for survival among the 31 presented heterospecific competition stronger than conspecific.
Moreover, *Fagus grandifolia* and *Thuja occidentalis* exhibited positive density dependence for the survival model.
For recruitment, the effect of total stand density increased with shade intolerance among the species (Figure SX).

![Posterior distribution for the conspecific (red) and heterospecific (blue) density dependence for each class of shade tolerance [@burns1990silvics]. The more negative the $\beta$, the stronger the competition effect.](manuscript/figs/crossComp.png){#fig:crossComp width=100%}

The distribution of optimal MAT ($\xi_{MAT}$) and MAP ($\xi_{MAP}$) for the 31 species revealed that the optimal climates for growth, survival, and recruitment were rarely located at the center of the species ranges (Figure SX and SX).
Furthermore, most species exhibited some degree of demographic compensation, that is, the opposing responses to the environment between demographic rates [@Villellas2015].
Lastly, the climate breadth ($\sigma$) determined how flat or narrow the performance of species was across MAT and MAP.
We found among all species that niche breadth increased with range size, demonstrating that species with more range occupancy had larger niche breadths.
The exception was the niche breadth of survival over MAT, showing a weak, flat correlation.

## $\lambda$ sensitivity to climate and competition

We used perturbation analysis to assess the relative contribution of each covariate to changes in $\lambda$.
Figure @fig:mean_sens describes the average sensitivity of each species' population growth rate to conspecific and heterospecific competition, temperature, and precipitation.
Across all species, $\lambda$ exhibited higher sensitivity to temperature, followed by conspecific and heterospecific competition, while sensitivity to mean annual precipitation was practically zero.
This pattern of sensitivity to the covariates remained consistent across all species.

![Log sensitivity of species population growth rate to conspecific competition, heterospecific competition, mean annual temperature, and mean annual precipitation across all plot-year observations. The smaller the values, the lower the sensitivity to a covariate.](https://willvieira.github.io/book_forest-demography-IPM/marginal_lambda_files/figure-html/fig-ame-1.png){#fig:mean_sens width=100%}

We split the species plot into different regions to ask whether sensitivity to climate and competition changes between each species' cold and hot ranges.
In Figure @fig:cold_vs_hot, we analyzed how each species' sensitivity to climate ($S_{clim, i}$) and competition ($S_{comp, i}$) changed from the cold to the hot border.
We evaluate the sensitivity of each species' border location according to the average Mean Annual Temperature (MAT) among all plots of the species' border group.
For climate, species distributed toward colder temperature ranges often exhibited a decrease in sensitivity from the cold to the hot border.
Conversely, most species in the hot range distribution demonstrated increased sensitivity to climate at the hot border compared to the cold.
Regarding competition, most species presented a decreased sensitivity from the cold to the hot border.
Additionally, the decrease in sensitivity to competition from the cold to the hot border was more pronounced for species in colder temperatures.

![Differences in species population growth rate sensitivity to climate (left) and competition between the cold and hot range limits. Each species is represented by a connected line linking their cold (circle) and hot (triangle) range positions, colored according to the difference between the cold and hot sensitivities. Note that uncertainty in each sensitivity point estimation has been omitted for clarity.](https://willvieira.github.io/book_forest-demography-IPM/marginal_lambda_files/figure-html/fig-hot_vs_cold-1.png){#fig:cold_vs_hot width=100%}

In Figure @fig:temp_vs_comp, we explore how the relative sensitivity between climate and competition changes across the species' range distribution.
$\lambda$ was more sensitive to climate than competition for almost all species across the cold, center, and hot ranges ($ln(CCR)$ below zero).
Across the MAT range distribution, the relative effect of climate to competition increased toward both the cold and hot borders of the range.
This indicates that species located at the extremes of the MAT range distribution are even more sensitive to climate than species at the center.
Interestingly, the reason for this increase is not the same for the cold and hot ranges.
In the cold range, the sensitivity of $\lambda$ increased for both climate and competition but was proportionally larger for climate.
Conversely, in the hot range, the relative sensitivity to climate increased due to a significant decrease in sensitivity to competition.

![Bottom panels describe the sensitivity of species population growth rate to competition (green) and climate (yellow) across the cold, center, and hot temperature ranges. The top panels show the log ratio between competition and climate sensitivities, where negative values mean climate sensitivity is relatively higher than competition. We defined each species' temperature range position as the median Mean Annual Temperature across all observed plots for each cold, center, and hot range class. In the bottom panel, species points are grouped by a Multivariate Normal Density function with 75% probability, while in the top panel, the lines represent the 25, 50, and 75% quantile probabilities.](https://willvieira.github.io/book_forest-demography-IPM/marginal_lambda_files/figure-html/fig-sensBorder_temp-1.png){#fig:temp_vs_comp width=100%}


# Discussion

- Our model showed overall good fit for demographic rates across the 31 forest species. Overall, species are more sensitive to climate rather than competition across their range distribution. The sensitivity to climate and competition changed across the species range. Furthermore, sensitivity showed different patterns depending on the location position of the species across the temperature range. These results are important to undertand the future reponse to climate change, perturbation, and forest management.

- Discuss the higher sensitivity of $\lambda$ to climate compared to competition

- Discuss the ratio  
- 
- 
- why sensitivity to climate and competition is higher at the cold range compared to the hot range

- 