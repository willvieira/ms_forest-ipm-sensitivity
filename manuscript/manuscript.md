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
Additionally, as sensitivity is computed at the plot level, we categorize each species plot into cold, center, or hot locations across the temperature axis to understand how sensitivity to climate and competition changes across the range distribution.
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
This selection comprises 9 conifer species and 21 hardwood species.
We ensured an even distribution of species across the continuous shade tolerance trait, with 3 species classified as very intolerant, 9 as intolerant, 8 as intermediate, 8 as tolerant, and 5 as very tolerant [@burns1990silvics].

We computed the plot-level density using the DBH of each individual as a competition metric.
Specifically, we quantified asymmetric competition for light for a focal individual by summing the total basal area of all individuals larger than the focal one, herein BAL.
We further split BAL into the total density arising from conspecific and heterospecific individuals.
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
Specifically, the IPM consists a set of functions predicting the transition of a distribution of individual traits from time $t$ to time $t+1$:

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

**Recruitment** - To obtain a broader range of climatic conditions, we combined data from both the U.S. and Quebec forest inventories.
However, these inventories have inconsistent protocols in recording seedlings, saplings, and juveniles.
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

**competition** - We used BAL (asymetric competition) instead of BA (symetric competition) assuming that competition for light is the primary competitive factor driving forest dynamics.
Therefore, each of the growth ($\Gamma$), longevity ($\psi$), and recruitment survival ($\rho$) parameters changes exponentially with BAL.
Take $I$ as one of the three parameters, th effect of BAL on $I$ is driven by two parameters describing the conspecific ($\beta$) and heterospecific ($\theta$) competition:

$$
  I + \times (BAL_{cons} + \theta \times BAL_{het})
$$

When $\theta < 1$, conspecific competition is stronger than heterospecific competition.
Conversely, heterospecific competition prevails when $\theta > 1$, and when $\theta = 1$, there is no distinction between conspecific and heterospecific competition.
Note that both $\beta$ is unbounded parameters that either converge towards negative (indicating competition) or positive (indicating facilitation) values.
Note that $\beta$ is also unbounded allowing it to converge towards negative (indicating competition) or positive (indicating facilitation) values.
Furthermore, we fixed $\theta = 1$ for the recruitment ($I = \rho$) due to model convergence issues.

**climate** - We selected mean annual temperature (MAT) and mean annual precipitation (MAP) bioclimatic variables as they are widely used in species distribution modeling.
Each demographic model $I$, representing either $\Gamma$ for growth, $\psi$ for longevity, or $\phi$ for ingrowth, varies as a bell-shaped curve determined by an optimal climate condition ($\xi$) and a climate breadth parameter ($\sigma$):

$$
  I + \left(\frac{MAT - \xi_{MAT}}{\sigma_{MAT}}\right)^2 + \left(\frac{MAP - \xi_{MAP}}{\sigma_{MAP}}\right)^2
$${#eq:compEffect}

The climate breadth parameter ($\sigma$) influences the strength of the specific climate variable's effect on each demographic model.
This unimodal function is flexible, assuming various shapes to better accommodate the data, such as quasi-linear or a flat shape.
However, this flexibility introduces the possibility of parameter degeneracy or redundancy, where different combinations of parameter values yield similar outcomes.
To address this issue, we constrained the optimal climate condition parameter ($\xi$) within the observed climate range for the species, assuming that the optimal climate condition falls within our observed data range.

### Model fit and validation

### Integral Projection Model

## Perturbation analysis

# Results

## Model validation

- Intercept

- Covariates

## Sensitivity

- Overall sensitivity across species

- Sensitivity to climate and competition across the geographical position

- Difference in sensitivity to climate and competition between cold and hot border for each species

# Discussion

- Our model showed overall good fit for demographic rates across the 31 forest species. Overall, species are more sensitive to climate rather than competition across their range distribution. The sensitivity to climate and competition changed across the species range. Furthermore, sensitivity showed different patterns depending on the location position of the species across the temperature range. These results are important to undertand the future reponse to climate change, perturbation, and forest management.

- Discuss the higher sensitivity of $\lambda$ to climate compared to competition

- Discuss the ratio  
- 
- 
- why sensitivity to climate and competition is higher at the cold range compared to the hot range

- 