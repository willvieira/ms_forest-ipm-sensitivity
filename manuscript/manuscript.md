# Introduction

The urge to unravel species distribution processes has increased with the current global crisis, where 15 to 37% of species are expected to face extinction due to climate change [@thomas2004].
This urgency is particularly pertinent for long-lived sessile species like trees, whose range distribution is likely to fail to follow climate change [@Zhu2012;@Sittaro2017].
In an effort to enhance traditional correlative species distribution models [e.g. @Guisan2000], theory decomposes species distribution into smaller components to develop a more mechanistic, process-based approach [@Evans2016].
One such approach is demographic range models, which predicts a species' distribution based on individual performance determined by growth, survival, and recruitment demographic rates [@Pagel2012].
This approach operates under the hypothesis that population growth rate ($\lambda$), determined by demographic rates, varies across the environment, with the species range limit defined by conditions where $\lambda$ is non-negative [@maguire1973niche;@Holt2009].
By approaching species distribution from a demographic perspective, we can account for the complexity of forest dynamics arising from multiple features such as environment and species interaction [Schurr2012;@Svenning2014].

Several studies have attempted to predict species distribution based on demographic performance.
The fundamental version of these models uses environment-dependent demographic rates to predict $\lambda$ [e.g. @Merow2014;@Csergo2017].
However, factors like competition undeniably influence both demographic rates [@@Luo2011;@Clark2011;@Zhang2015] and population performance [@Scherrer2020;@lesquin2021] in forest trees.
This realized version of the niche [@Hutchinson1957] may explain why North American forest trees often do not occur within their climatically suitable range [@Boucher-Lalonde2012;@Talluto2017].

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
Employing perturbation analysis, we quantify the relative contribution of each covariate to changes in $\lambda$ [@Caswell2001].
Precisely, we assess the species sensitivity of an observed $\lambda$ for each plot-year combination based on their specific climate and competition conditions.
This approach enables an evaluation of the overall sensitivity of $\lambda$ to a covariate while considering the inherent variability of the covariate experienced by the species.
For instance, a species may exhibit high sensitivity to temperature, but if most of its distribution is observed under optimal temperature conditions, the average sensitivity of the species will be low.
Additionally, as sensitivity is computed at the plot level, we categorize each species plot into cold, center, or hot locations across the temperature axis to understand how sensitivity to climate and competition changes across the range distribution.
Our integrative approach allows us to assess the relative effects of climate and competition from demographic rates up to the population growth rate while accounting for model uncertainties, revealing essential insights into understanding the response of forest trees to climate change, management practices, and conservation efforts.

# Methods

## Inventory and climate data

## Model

### Vital rate Intercepts

Growth, survival, and recruitment

### Covariates

Random effects, competition, climate

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