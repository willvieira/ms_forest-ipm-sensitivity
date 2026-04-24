# Introduction

Mechanistic and process-based models [@Evans2016] have been proposed to improve predictions of species distribution in response to climate change.
Among these, demographic range models predict species distributions from individual performance governed by growth, survival, and recruitment rates [@Pagel2012].
This framework assumes that population growth rate ($\lambda$), determined by demographic rates, varies across environmental gradients, with species range limits occurring where $\lambda$ is positive [@maguire1973niche;@Holt2009;@pang2024niche].
By approaching species distributions from a demographic perspective, we can better capture the complexity of forest dynamics arising from environmental variation and species interactions [@Schurr2012;@Svenning2014].
Several studies have attempted to predict tree species distributions from demographic performance.
The simplest implementations rely on environment-dependent demographic rates to estimate $\lambda$ [e.g. @Merow2014;@Csergo2017].
However, competition is a fundamental determinant of demographic rates [@Luo2011;@Clark2011;@Zhang2015] and population performance [@Scherrer2020;@LeSquin2021] in forest ecosystems.
Incorporating competition is therefore particularly important given the projected risk of community reshuffling under global change [@Alexander2016].
This more complete, realized expression of the niche [@Hutchinson1957] may help explain why North American forest trees often fail to occupy their full climatically suitable ranges [@BoucherLalonde2012;@Talluto2017].

An increasing body of evidence challenges theoretical expectations by reporting weak correlations between tree demographic performance and species distributions [@McGill2012;@Thuiller2014;@Csergo2017;@bohner2020;@LeSquin2021;@Midolo2021;@Guyennon2023].
The methodological approaches used to quantify demographic performance are however rarely challenged, difficult to compare and suffer some limitations.
Some analyses infer performance from a single proxy, such as radial growth [e.g. @McGill2012;@bohner2020].
Even when demographic rates are combined within population models, key components such as recruitment are often excluded due to data limitations [@Kunstler2021;@LeSquin2021].
Furthermore, density-dependence is sometimes ignored altogether [@Csergo2017; @Ohse2023], and when included, studies rarely distinguish between conspecific and heterospecific competition [@bohner2020;@LeSquin2021].
Finally, despite increasing recognition of the importance of propagating model and data uncertainty [@MilnerGulland2017a;@malchow2024calibration], most studies evaluate performance under average environmental conditions and rely on pointwise estimates, thereby overlooking the substantial variability inherent to demographic processes.

Rather than asking whether demographic performance correlates with species distributions, a more fruitful question may be how climate and competition jointly shape demographic performance.
Despite substantial progress, we still lack a comprehensive partitioning of the sensitivity of forest dynamics to local and regional drivers [@Ohse2023].
For instance, @Clark2011 found that annual growth was more sensitive to competition, whereas fecundity responded more strongly to climate.
In contrast, @CopenhaverParry2016 reported growth to be more sensitive to climate than to competition.
Although these studies provide important insights into how forest trees may respond to climate change and management, they focus on individual demographic components rather than their integrated effects on population growth.
This limitation is particularly important if sensitivity to climate and competition varies across life-history stages [@Russell2012;@Ettinger2013].
Moreover, the sensitivity of $\lambda$ to climate and competition may depend on a species' position within its range. 
For instance, climate may exert stronger control under abiotic stress, whereas competition may dominate under more benign conditions [@Louthan2015].
Nevertheless, such range-dependent evaluations of demographic sensitivity remain largely unexplored for forest trees [@Ohse2023].

Here, we evaluate how climate and competition jointly shape the demography and population growth rate of the 31 most abundant forest tree species across eastern North America (Figure @fig:concept_fig).
Leveraging the full latitudinal extent of forest inventories (26–53°) across the United States and Canada, we capture the broad geographic ranges of these species.
We model growth, survival, and recruitment as functions of temperature, precipitation, and conspecific and heterospecific basal area (as proxies for competition) using Bayesian hierarchical models, allowing explicit representation of uncertainty.
We then integrate these climate- and competition-dependent vital rates into size-structured Integral Projection Models (IPMs) to estimate population growth rate ($\lambda$).

Our primary goal is to quantify how sensitive $\lambda$ is to climate and competition across species' ranges.
Using perturbation analysis [@Caswell2000], we decompose the contribution of each covariate to variation in $\lambda$ under the specific environmental and competitive conditions experienced across plot-years.
This approach allows us to evaluate the overall sensitivity of $\lambda$ to each covariate while explicitly accounting for the variability experienced by species across their ranges.
For instance, even if a species is highly sensitive to temperature, its average population response may remain weak if most populations occur under near-optimal conditions.
Finally, building on previous evidence that North American trees have shown limited cold-edge expansion and hot-edge contraction under climate change [@Talluto2017], we test whether sensitivity to climate and competition varies across species' geographic ranges.
By quantifying the relative effects of climate and competition on population growth rate, our framework provides a mechanistic basis for understanding how forest trees may respond to climate change, management, and conservation actions.

![Conceptual framework to assess how the sensitivity of population growth rate to climate and competition varies across species' geographic ranges. Using repeated measurements of individual trees from forest inventories spanning the eastern United States and Québec, Canada, we fitted species-specific growth, survival, and recruitment models parameterized as functions of individual size, competition, and plot-level climate covariates. These demographic models form the components of a size-structured Integral Projection Model (IPM), from which population growth rate ($\lambda$) is estimated for each species $i$ at each plot location $j$. We then apply perturbation analysis to quantify the sensitivity of $\lambda$ to climate and competition under the local environmental and stand composition conditions of each plot. Cold and hot range limits were identified using the 10th and 90th percentiles of mean annual temperature across each species' distribution. By averaging sensitivities across plots within each range edge, we assess how the sensitivity of population growth rate differs between cold and hot distributional limits.](manuscript/figs/concept_fig.png){#fig:concept_fig width=100%}

# Methods

We developed species-specific, Integral Projection Models (IPM) parameterized with climate- and competition-dependent demographic rates (described in the following section).
Deriving population growth rate (λ) from the IPM, we used perturbation analysis to assess the sensitivity of λ to competition and climate conditions (Caswell 2000).
The sensitivity of each species is reported at the cold and hot limits of their range.

## Forest inventory and climate data

We used two open forest inventory datasets from eastern North America: the Forest Inventory and Analysis (FIA) dataset in the United States [@OConnell2007] and the Forest Inventory of Québec [@Naturelles2016].
At the plot level, we focused on plots sampled at least twice and excluded those that had undergone harvesting in order to concentrate solely on natural forest dynamics.
Specifically for the FIA dataset, we selected surveys conducted using the modern standardized methodology implemented since 1999.
After applying these filters, the final dataset encompassed nearly 26,000 plots spanning a latitudinal range from 26° to 53° (Figure S7).
Each plot was measured between 1970 and 2021, with observation frequencies ranging from 2 to 7 measurements and an average of 3 measurements per plot.
The time intervals between measurements varied from 1 to 40 years, with a median interval of 7 years (Figure S7).

These datasets provide individual-level information on diameter at breast height (DBH) and survival status (alive or dead) for more than 200 species.
From this pool, we selected the 31 most abundant species (Table S1), comprising 9 conifer species and 22 hardwood species.
We ensured broad coverage across the shade tolerance gradient, including three very intolerant species, nine intolerant species, eight intermediate species, eight tolerant species, and five very tolerant species [@burns1990silvics].

We obtained 19 bioclimatic variables at a spatial resolution of 10 km² (300 arcsec), covering the period from 1970 to 2018.
These climate variables were modeled using the ANUSPLIN interpolation method [@McKenney2011].
Using the geographic coordinates of each plot, we extracted mean annual temperature (MAT) and mean annual precipitation (MAP).
When plots did not fall within a valid climate pixel, values were interpolated using the eight neighboring cells.
Because measurements occurred across multiple years within census intervals, we calculated both the mean and standard deviation of MAT and MAP across the years included in each time interval.

## Model

We developed an Integral Projection Model (IPM) for 31 tree species, with separated sub-models for each demographic rate.
An IPM is a mathematical framework used to represent the dynamics of structured populations and communities.
Unlike traditional matrix population models, IPMs represent individual traits as continuous variables in discrete time [@Easterling2000].
This formulation enables a detailed representation of trait transitions between time steps, which is particularly relevant for trees due to the considerable variability in demographic rates [@kohyama1992;@Clark2011;@LeSquin2021].
Specifically, the IPM predicts the transition of a distribution of individual traits from time $t$ to time $t + \Delta t$, where $\Delta t$ represents the number of years between observations:

$$
n(z', t + \Delta t) = \int_{L}^{U} \, K(z', z, \theta)\, n(z, t)\, \mathrm{d}z
$${#eq:ipm}

The continuous trait $z$ represents DBH, bounded between lower ($L$) and upper ($U$) limits, and $n(z, t)$ describes the DBH distribution at time $t$.
Transitions from $n(z, t)$ to $n(z', t + \Delta t)$ are governed by the kernel $K$ and species-specific parameters $\theta$.
The kernel $K$, a continuous analogue of the projection matrix in structured population models, is composed of three demographic components:

$$
K(z', z, \theta) = [Growth(z', z, \theta) \times Survival(z, \theta)] + Recruitment(z, \theta)
$${#eq:kernel}

The growth function describes changes in DBH, the survival function determines the probability of remaining alive over the next interval, and the recruitment function describes the influx of new individuals.
These three models are estimated independently and do not share parameters.
Below, we first describe the baseline versions of these models, followed by the inclusion of climate and competition covariates.

### Demographic rates

**Growth** - The DBH of an individual at time $t + \Delta t$ after growing from time $t$ follows the distribution:

$$
dbh_{i,t + \Delta t} \sim N(\mu_{i, t+\Delta t}, \sigma)
$${#eq:VBlik}

We used the von Bertalanffy growth equation to describe annual DBH growth for individual $i$ [@von1957quantitative].
The expected size at time $t + \Delta t$, given initial size $dbh_{i,t}$, is:

$$
\mu_{i, t+\Delta t} = dbh_{i,t} e^{-\Gamma \Delta t} + \zeta_{\infty} (1 - e^{-\Gamma \Delta t})
$$ {#eq:VBmodel}

Here, $\Delta t$ represents the time interval between measurements, $\Gamma$ is a dimensionless growth-rate parameter, and $\zeta_{\infty}$ represents the asymptotic size at which growth approaches zero.
This formulation assumes that growth declines exponentially with size, converging to zero as size approaches $\zeta_{\infty}$.
This assumption is particularly valuable in the context of an IPM, as it prevents eviction beyond the bounds of the IPM domain $[L,U]$.

**Survival** - A mortality event ($M$) for individual $i$ during the interval between $t$ and $t+\Delta t$ is modeled as:

$$
M_i \sim Bernoulli(p_i)
$${#eq:survL}

Here, $M_i$ denotes survival status and $p_i$ represents mortality probability.
Mortality probability is derived from the annual survival rate ($\psi$):

$$
p_i = 1 - \psi^{\Delta t}
$${#eq:survP}

Thus, survival probability increases with longevity parameter $\psi$, while longer intervals $\Delta t$ increase mortality risk exponentially.

**Recruitment** - We combined U.S. and Québec inventory data to capture a broader climatic range.
However, these inventories differ in protocols for recording seedlings and saplings, including size thresholds.
We therefore defined recruitment as the ingrowth of individuals into the adult population (DBH ≥ 12.7 cm).

Recruitment rate ($I$) integrates fecundity, dispersal, growth, and survival up to the threshold size.
Because ingrowth depends on census interval length, we defined two parameters: $\phi$, the annual ingrowth rate per square meter, and $\rho$, the annual survival probability of recruits:

$$
I \sim Poisson(~\phi \times A \times\frac{1 - \rho^{\Delta t}}{1 - \rho}~)
$${#eq:rec}

Here, $A$ represents plot area (m²).
Individuals are assumed to enter annually at rate $\phi$, while their survival ($\rho$) until the subsequent measurement declines with time.
Note that $\rho$ in Equation @eq:rec is not associated with Equation @eq:survP determining the survival of the adults.
Instead, $\rho$ is estimated from the data of individuals arriving in the population.
Once individuals are recruited into the population, their initial size $z_I$ is modeled as:

$$
z_{I} \sim TNormal(\Omega + \beta \Delta t,~\sigma, ~ \alpha, ~ \beta)
$${#eq:recSize}

This truncated normal distribution has lower bound $\alpha=12.7$ cm and no upper bound.

### Covariates

**Random effects** - Plot-level random effects were included in all demographic components to account for shared environmental variation among individuals within plots.

$$
\begin{split}
&\alpha_j \sim N(0, \sigma) \\[2pt]
&I_j = \overline{I} + \alpha_j
\end{split}
$${#eq:randomEffect}

Here, $I$ represents parameters $\Gamma$, $\psi$, or $\phi$ depending on the demographic component, and $\sigma$ the variance among all plots.

**Competition** - We assumed that competition for light is the primary competitive factor driving forest dynamics [@Pacala1996a].
We therefore considered that each individual was affected only by larger neighbors.
We quantified competition for light for a focal individual in a given plot by summing the basal area of all individuals larger than the focal one, herein BAL.
We further split BAL into the total density of conspecific and heterospecific individuals.

Competition effects were modeled on parameters $\Gamma$, $\psi$, and $\rho$:

$$
I + \beta (BAL_{cons} + \theta \times BAL_{het})
$${#eq:compEffect}

Parameter $\theta$ controls the relative strength of heterospecific competition.
Values $\theta < 1$ indicate stronger conspecific competition, $\theta > 1$ indicates stronger heterospecific effects, and when $theta = 1$, there is no distinction between them.
Note that $\beta$ is also unbounded, allowing it to converge towards negative (indicating competition) or positive (indicating facilitation) values.
For recruitment survival ($\rho$), $\theta$ was fixed at 1 due to convergence issues.
Recruitment rate $\phi$ also included conspecific density-dependence, where it decreases with $BAL_{cons}$ as a positive effect of seed source up to reach the optimal density of recruitment, $\delta$, and then decreases with more conspecific density due to competition at a rate proportional to $\sigma$:

$$
\phi + \left(\frac{BAL_{cons} - \delta}{\sigma}\right)^2
$${#eq:compingrowth}

**Climate** - We used MAT and MAP as climate predictors because of their widespread use in species distribution modeling and demonstrated relevance to model demography of these species [@LeSquin2021].
Each demographic parameter followed a unimodal climate response determined by an optimal climate condition ($\xi$) and a climate breadth parameter ($\sigma$):

$$
I + \left(\frac{MAT - \xi_{MAT}}{\sigma_{MAT}}\right)^2 + \left(\frac{MAP - \xi_{MAP}}{\sigma_{MAP}}\right)^2
$${#eq:compEffect}

The climate breadth parameter ($\sigma$) influences the strength of the specific climate variable's effect on each demographic component.
This unimodal function is flexible, assuming various shapes, such as bell, quasi-linear, or flat shapes.
However, this flexibility introduces the possibility of parameter degeneracy or redundancy, where different combinations of parameter values yield similar outcomes.
To address this issue, we constrained the optimal climate condition parameter ($\xi$) within the observed climate range for the species, assuming that the optimal climate condition falls within our observed data range.

### Model fit and validation

We fitted growth, survival, and recruitment models separately for each species using Hamiltonian Monte Carlo (HMC) implemented in Stan [version 2.30.1 @stan2022stan] through the `cmdstanr` R interface [version 0.5.3 @cmdstanr].
Each model used four chains with 2000 warm-up iterations and 2000 sampling iterations, yielding 8000 posterior samples.
To reduce storage, only the final 1000 samples from each chain were retained, resulting in 4000 posterior samples.
Models were constructed incrementally, beginning with intercept-only models and progressively adding random effects, competition, and climate covariates.
Our goal was not maximal predictive accuracy but mechanistic inference [@Tredennick2021].
We focused on assessing the relative effects of climate and competition while controlling for other influential factors.
Therefore, our modeling approach is guided by biological mechanisms, which tend to provide more robust extrapolation [@Briscoe2019] rather than being solely dictated by specific statistical metrics.
Nevertheless, we verified that increasing model complexity did not reduce predictive performance using mean squared error (MSE), pseudo-$R^2$ [@Gelman2019], and Leave-One-Out Cross-Validation (LOO-CV).
Additional diagnostics are provided in Supplementary Material 1.

The IPM kernel $K$ was constructed following Equation @eq:kernel and discretized using the midpoint rule [@Ellner2016].
Kernel discretization used 0.1 cm size bins, consistent with previous recommendations for trees [@zuidema2010integral].
The asymptotic population growth rate ($\lambda$) was computed as the leading eigenvalue of the discretized kernel matrix under specified climate and competition conditions.

All model code is available in the [`TreesDemography`](https://github.com/willvieira/TreesDemography) repository.
The IPM implementation is packaged in [`forestIPM`](https://github.com/willvieira/forestIPM), and sensitivity analysis code is available in the `simulations/covariates_perturbation` directory.

## Perturbation analysis

Sensitivity was defined as the partial derivative of $\lambda$ with respect to a covariate $X$, representing either competition (conspecific or heterospecific density-dependence) or climate (temperature or precipitation).
We quantified sensitivity by slightly increasing each covariate value $X_j$ to $X_j^{'}$ and computing the resulting change in $\lambda$ using a finite-difference approximation (right-hand side of Equation @eq:sens):

$$
\frac{\partial \lambda_{ij}}{\partial X_j} \bigg\rvert_{K_{ij}} \approx \frac{\Delta \lambda_{ij}}{\Delta X_j} = \frac{|f(X_j^{'}) - f(X_j)|}{X_j^{'} - X_j}
$${#eq:sens}

Sensitivity was evaluated separately for each species $i$ and plot-year $j$, conditional on the local climate and competition conditions as well as the corresponding kernel parameters $K_{ij}$.
We set the perturbation magnitude to a 1% increase on the normalized scale of each covariate.
For instance, a 1% increase corresponds to approximately 0.3°C for mean annual temperature (MAT) and 26 mm for mean annual precipitation (MAP).
Because competition metrics were computed at the individual level, perturbations were applied to each individual prior to calculating plot-level basal area, where a 1% increase corresponds approximately to an increase of 1.2 cm in DBH.
As we were interested in the magnitude of the response, absolute differences were used, resulting in sensitivity values ranging from 0 to $\infty$, where lower values indicate weaker sensitivity of $\lambda$ to the given covariate.
Specifically, sensitivity ($S$) to competition or climate for species $i$ at plot-year $j$ was defined as:

$$
\begin{split}
&S_{comp, ij} = \frac{\partial \lambda_{ij}}{\partial BA_{cons, i}} + \frac{\partial \lambda_{ij}}{\partial BA_{het, i}} \\[2pt]
&S_{clim, ij} = \frac{\partial \lambda_{ij}}{\partial MAT_{i}} + \frac{\partial \lambda_{ij}}{\partial MAP_{i}} \\[2pt]
\end{split}
$${#eq:CCR}

When averaging $S_{X,i}$ across plot-years $j$, this metric represents the sensitivity of $\lambda_i$ to covariate $X$, conditional on the observed probability distribution of that covariate.
This yields a measure of **realized sensitivity**, integrating both demographic responses and the environmental variability experienced across the species' range.
To evaluate range-dependent sensitivity, plots were categorized into cold, center, or hot conditions along the MAT gradient for each species.
Plots were classified as cold (or hot) if their average MAT fell below the 10th percentile (or above the 90th percentile) of the species-specific MAT distribution, with intermediate plots classified as center plots.
Sensitivity within each range position was calculated as the average sensitivity across plots belonging to that category.
Because this classification is based on observed MAT distributions, range categories are conditional on the environmental conditions experienced by each species.

# Results

## Model validation

All species-specific demographic components demonstrated good convergence ($\hat{R} < 1.05$) with few to no divergent iterations.
Model comparison using LOO-CV consistently favored the full model, featuring plot-level random effects, competition, and climate covariates, over other competing models for all three demographic rates (Supplementary Material 1).
The magnitude of LOO-CV differences indicated that the growth model benefited most from the inclusion of covariates, followed by recruitment and survival.
We further evaluated biological realism by comparing model-derived parameters with known species trait groups, including growth rate class, maximum observed size, maximum observed age, shade tolerance, and seed mass [@burns1990silvics;@diaz2022].

The growth model intercept included two parameters: one determining asymptotic size ($\zeta_{\infty}$) and another describing annual growth rate ($\Gamma$).
Predicted asymptotic size, which can be interpreted as the maximum predicted size of the species, correlated well with maximum observed species size reported in the literature ($R^2 = 0.31$, Figure @fig:crossGrowthSurv).
Similarly, $\Gamma$ values aligned with established fast-, moderate-, and slow-growing trait classes (Figure S8).
In the survival model, expected longevity ($L$) was derived from annual survival probability ($\psi$) using the relationship $L = e^{\psi}$.
Estimated longevity showed strong agreement with maximum observed age from the literature ($R^2 = 0.59$, Figure @fig:crossGrowthSurv).
For recruitment, the log of annual ingrowth rate ($\phi$) declined linearly with seed mass (Figure S9), consistent with the seed mass–growth rate trade-off [@Reich1998].
Additionally, the annual survival probability of ingrowth ($\rho$) decreased with increasing shade intolerance (Figure S10).

![Correlation between predicted asymptotic size ($\zeta_{\infty}$) with maximum observed size (left) and predicted longevity ($L$) with maximum observed age for the 31 forest species. Maximum observed size and age are obtained from @burns1990silvics. The gray line is the identity curve.](manuscript/figs/crossGrowthSurv.png){#fig:crossGrowthSurv width=100% short-caption="Correlation between predicted asymptotic size ($\zeta_{\infty}$) with maximum observed size (left) and predicted longevity ($L$) with maximum observed age for the 31 forest species."}

Both conspecific and heterospecific competition effects in growth and survival models increased with shade intolerance (Figure @fig:crossComp).
Across nearly all species, conspecific competition effects were stronger than heterospecific effects.
Only two species in the growth model and three in the survival model showed stronger heterospecific than conspecific competition.
Notably, *Fagus grandifolia* and *Thuja occidentalis* exhibited positive density-dependence in survival.
In the recruitment model, total stand density effects increased with shade intolerance (Figure S11).

![Posterior distribution for the conspecific (red) and heterospecific (blue) density-dependence for each class of shade tolerance [@burns1990silvics]. The more negative the $\beta$, the stronger the competition effect.](manuscript/figs/crossComp.png){#fig:crossComp width=100% short-caption="Posterior distribution for the conspecific (red) and heterospecific (blue) density-dependence for each class of shade tolerance [@burns1990silvics]."}

The distribution of optimal MAT ($\xi_{MAT}$) and MAP ($\xi_{MAP}$) indicated that optimal conditions for growth, survival, and recruitment were rarely located at the center of species' ranges (Figures S12 and S13).
Many species exhibited demographic compensation, with opposing responses among demographic rates to environmental variation [@Villellas2015].
Climate breadth ($\sigma$) determined how narrowly or broadly performance varied across MAT and MAP.
Across species, climate breadth increased with geographic range size, indicating that widely distributed species tended to have broader niche breadths (Figure S14).
An exception was survival breadth along MAT, which showed only a weak relationship.

## $\lambda$ sensitivity to climate and competition

We conducted perturbation analyses to quantify the relative contribution of each covariate to variation in population growth rate ($\lambda$). Figure @fig:mean_sens summarizes the sensitivity of $\lambda$ to conspecific competition, heterospecific competition, temperature, and precipitation, averaged across all plot-year observations. Across species, $\lambda$ was most sensitive to temperature, followed by conspecific and heterospecific competition, whereas sensitivity to precipitation was negligible. This overall pattern was consistent among species.

![Log sensitivity of species population growth rate to conspecific competition, heterospecific competition, mean annual temperature, and mean annual precipitation across all plot-year observations. The smaller the values, the lower the sensitivity to a covariate.](https://willvieira.github.io/book_forest-demography-IPM/marginal_lambda_files/figure-html/fig-ame-1.png){#fig:mean_sens width=100% short-caption="Log sensitivity of species population growth rate to conspecific competition, heterospecific competition, mean annual temperature, and mean annual precipitation across all plot-year observations."}

To evaluate range-dependent responses, plots were divided into cold and hot regions based on species-specific MAT distributions (Figure @fig:cold_vs_hot).
Most species occurring in colder climates exhibited decreasing climate sensitivity from the cold to the hot limit of their range.
In contrast, species centered in warmer climates generally showed greater climate sensitivity at the hot limit than at the cold limit.
Sensitivity to competition was typically higher at the cold limit than at the hot limit across most species, regardless of overall distribution.
This elevated sensitivity to competition at the cold limit was particularly pronounced among boreal species.

![Differences in the sensitivity of species population growth rate to climate (left) and competition between the cold and hot range limits. Each species is represented by a connected line linking their cold (circle) and hot (triangle) range positions, colored according to the difference between the cold and hot sensitivities. Range positions were defined using the median mean annual temperature across all plots belonging to each thermal class. Note that uncertainty in each sensitivity point estimation has been omitted for clarity.](https://willvieira.github.io/book_forest-demography-IPM/marginal_lambda_files/figure-html/fig-hot_vs_cold-1.png){#fig:cold_vs_hot width=100% short-caption="Differences in species population growth rate sensitivity to climate (left) and competition between the cold and hot range limits."}

Including sensitivity estimates from the central portion of species ranges further clarified patterns across thermal gradients (Figure S15).
Most species displayed approximately linear changes in sensitivity to both climate and competition from cold to hot range limits.
For climate sensitivity, three of the four species exhibiting concave relationships, where sensitivity was highest at both range edges, were among those with the largest geographic ranges.
In contrast, four species displayed convex relationships in competition sensitivity, with peak sensitivity occurring near the range center.
These species also showed the highest overall competition sensitivity and were predominantly distributed in colder climates.

Finally, we evaluated how the relative importance of climate versus competition varied across species' thermal positions (Figure @fig:comp_clim_ratio).
For most species, $\lambda$ remained more sensitive to climate than to competition across cold, center, and hot range positions.
The relative importance of climate increased toward both cold and hot limits along the MAT gradient.
This observation indicates that populations near thermal extremes are more strongly climate-sensitive than those near the center of their ranges.Notably, the mechanisms underlying this increase differed between range limits (Figure S16).
At the cold limit, sensitivities to both climate and competition increased, but the proportional increase was greater for climate.
In contrast, at the hot limit, the increasing dominance of climate sensitivity primarily resulted from declining sensitivity to competition.

![Ratio of population growth rate ($\lambda$) sensitivity to competition relative to climate across species' thermal ranges. Negative values indicate greater sensitivity to climate than to competition. Range positions were defined using the median mean annual temperature across all plots belonging to each thermal class. The larger and small bars represent the 20 and 70th quantile probabilities, respectively.](manuscript/figs/comp_clim_ratio2.png){#fig:comp_clim_ratio width=100%}

# Discussion

We developed an Integral Projection Model for 31 tree species in order to evaluate the sensitivity of $\lambda$ to climate and competition.
Our framework advances previous analyses of tree species performance by (i) explicitly incorporating climate and competition effects into the recruitment model, (ii) distinguishing between conspecific and heterospecific competition, while (iii) propagating uncertainty across all levels of the modeling hierarchy.
In addition, the modular structure of our workflow allows straightforward expansion to include the more than 200 species available in the dataset, as well as additional environmental covariates affecting demographic rates.

Our results reeal that incorporating climate and competition covariates consistently improves the predictive performance of all demographic components relative to models containing only random effects.
Nevertheless, local plot-level conditions captured by random effects remained the strongest predictors of demographic variation.
Therefore, we evaluated species sensitivity to climate and competition while explicitly accounting for this plot-level variability.
Across species and their geographic ranges, $\\lambda$ was most sensitive to temperature and to conspecific basal area of larger individuals.
Importantly, these sensitivities varied across species' range positions, with climate exerting relatively stronger influence than competition at both cold and hot range limits.
Together, these findings contribute to a more mechanistic understanding of how tree species may respond to novel environmental conditions associated with climate change, offering insights relevant to forest management and conservation.

***Fit of demographic components***

Our model demonstrated strong biological consistency by reproducing well-established relationships among demographic traits.
Growth and survival intercepts were positively correlated with maximum observed size and longevity, respectively [@burns1990silvics], while the recruitment intercept showed clear alignment with seed mass [@diaz2022].
The model also reproduced the fast–slow life-history continuum [@SalgueroGomez2016], revealing a negative relationship between growth and survival rates and a positive relationship between growth and recruitment rates (Figure S17).
Competition effects were consistent with ecological expectations.
The model captured the negative relationship between density-dependence and shade tolerance, as well as the general pattern of stronger responses to conspecific competition than to heterospecific competition.
This asymmetry is considered fundamental for species coexistence and biodiversity maintenance [@Chesson2000a].
Additionally, conspecific density-dependence was stronger for fast-growing species than for slow-growing ones (Figure S18), consistent with observations from tropical forests [@Zhu2018].
Validation of climate-related parameters remains challenging due to limited empirical estimates of species-specific climatic optima.
Nevertheless, our results are aligned with previous findings documenting demographic compensation among forest trees [@bohner2020;@Yang2022].
Moreover, the estimated climatic breadth of species correlated with geographic range size (Figure S14), suggesting that the model captures ecologically meaningful variation beyond explicitly modeled predictors.

Most of the variation in $\\lambda$ was associated with local plot conditions captured by random effects, consistent with previous studies [@Vanderwel2016a;@LeSquin2021;@itter2024making].
This result indicates that demographic variability is influenced by drivers not explicitly included in our models.
At local scales, for instance, soil nitrogen availability [@Ibanez2018] and mixed mycorrhizal associations [@Luo2023] can enhance tree growth rates.
At broader spatial scales, disturbance regimes such as wildfire and insect outbreaks strongly shape forest dynamics and structure [@Franklin2002], causing synchronized mortality events and altering species composition across landscapes.
Similarly, structured spatial variation in mortality among Pinus species across the United States has been linked primarily to local disturbance regimes rather than broad climatic gradients [@bauman2025mosaic].
Although our analysis focused on climate and competition, other covariates may exert stronger influences on demographic variation.
For instance, tree growth models incorporating extreme climatic events often show improved predictive performance relative to those using mean climatic conditions [@Sangines2017].
Likewise, drought extremes, rather than mean precipitation, have been identified as strong predictors of fecundity following temperature effects [@Clark2011].

***$\lambda$ sensitivity to climate and competition***

We found across all species that the sensitivity of $\lambda$ was highest for temperature, followed by conspecific competition.
Previous studies assessing the relative importance of climate and competition on tree performance have reported mixed results.
Some studies emphasize stronger competition effects on growth [@GomezAparicio2011; @LeSquin2021], whereas others report stronger climate effects [@CopenhaverParry2016].
In addition, the relative importance of climate and competition often differs among demographic components, with growth typically more sensitive to competition and fecundity more sensitive to climate [@Clark2011].
For instance, several dominant tree species in Poland exhibited high climate sensitivity, with declining fecundity under warming temperatures [@foest2025forest].

These contrasting findings may arise because many studies assess demographic components separately rather than evaluating their integrated effects on population growth rate.
This is particularly critical since $\\lambda$ does not respond equally to all demographic processes.
Our additional analyses revealed that $\\lambda$ was most sensitive to recruitment, followed by survival, with a comparatively smaller contribution from growth (Supplementary Material 3).
Because recruitment tends to be more sensitive to temperature [@Clark2011;@foest2025forest], the high elasticity of $\\lambda$ to recruitment may explain the dominant role of climate sensitivity observed in our results.

Sensitivity to climate and competition varied across species' geographic ranges.
Because demographic responses to climate are nonlinear, lower sensitivity values generally indicate conditions near climatic optima, whereas higher values indicate deviation from optimal conditions.
Overall, climate sensitivity, driven primarily by MAT, was greatest at both cold and hot range limits.
This result suggests that species originating from colder environments perform optimally toward warmer portions of their ranges, whereas species from warmer environments perform optimally toward cooler conditions.
Notably, the demographic mechanisms underlying increased climate sensitivity differed between range limits.
Recruitment and growth processes primarily drove sensitivity at cold range limits, whereas survival and recruitment dominated at hot range limits, particularly under high competition conditions (Figure S22).
Previous studies have documented climate-constrained growth at cold range limits for both North American [@Ettinger2013] and European trees [@Kunstler2021].
Similarly, reduced survival at hot range limits has been observed in European forests [@Kunstler2021], although this observation has not been consistently detected in eastern North America [@Purves2009].

Sensitivity of $\\lambda$ to competition increased approximately linearly toward colder climates for most species.
Due to nonlinear relationships between demographic performance and competition, sensitivity declines as stand density increases, following a negative exponential pattern.
Consequently, the observed reduction in competition sensitivity toward hot range limits likely reflects higher overall stand density in those regions.
Biotic interactions are often considered particularly important at hot range limits [@Paquette2021].
However, when focusing exclusively on growth responses, previous studies have reported relatively constant competition effects across climatic gradients in both North American [@Ettinger2013] and European forests [@Kunstler2011a].

***Limitations and future perspectives***

Structured population models such as IPMs are essential for capturing ontogenetic variation in population dynamics.
While our growth model explicitly incorporates individual size, survival and recruitment models were specified without direct size dependence.
Attempts to include size-dependent mortality using the widely assumed U-shaped function [@Lines2010] did not improve model performance relative to simpler random-effects formulations (Figure S6).
Although mortality often increases with size [@Luo2011;@Hember2017], its significance appears to manifest only when interacting with climate and competition [@LeSquin2021].
The challenge in estimating size-dependent survival likely stems from limited observations of small individuals (dbh < 12.7 cm) and the rarity of large individuals, even in extensive forest inventories [@Canham2017].
Despite the absence of explicit size dependence in survival, indirect size effects are partially captured through asymmetric competition, where smaller individuals experience stronger competitive pressure.
Another limitation shared with many forest-inventory-based models [@Kunstler2021;@LeSquin2021;@Guyennon2023] is the focus on adult trees, even though fecundity can be influenced by climate [@Clark2021], and the dynamics of recruitment may not necessarily align with those of adults [@SerraDiaz2016;@Wason2017; but see @Canham2016].

The modular design of our framework enables straightforward integration of additional species and environmental predictors. 
For instance, additional covariates such as water balance or evapotranspiration could be incorporated to assess drought-induced mortality [@Peng2011].
Furthermore, exploring the interactions among climate, competition, and individual size may further improve predictions of demographic rates [@Peng2011;@Ford2017;@Rollinson2016;@LeSquin2021].

A promising but computationally intensive extension would involve jointly fitting growth, survival, and recruitment models to explicitly capture their interdependence [@pang2024niche].
Such an approach would allow the incorporation of ecological constraints, such as life-history trade-offs, by sharing information across demographic processes with abundant data (e.g. growth) and those with scarce data (e.g. recruitment).
Future work should also focus on interpreting the ecological drivers underlying variation captured by random effects.
While our framework accounts for individual and plot-level uncertainty, additional attention to temporal variability in climate and competition will be essential.
Incorporating temporal stochasticity will improve predictions of species performance under changing environmental conditions and enhance understanding of population responses across space and time [@Holt2022].

# References
