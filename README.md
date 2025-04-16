# SpectraCommAsmbly: Community assembly using spectral data 
*Examing scale dependence of community assembly processes in Québec's northern temperate forest using imaging spectroscopy data.*

This repository is meant to support the manuscript: 
"Testing the scale dependence of community assembly processes using imaging spectroscopy" by Crofts et al. in prep. 

This study is apart of the larger Canadian Airborne Biodiversity Observatory (http://caboscience.org/) initiative.

# Components
The repository contains nine R scripts.
01. Define potential plots (01_Define_plots)
02. Define minimum number of spectral points (02_Define_min_spec_points)
03. Extract imaging spectroscopy data (03_Extract_HSI)
04. Calculate spectral composition (04_Calc_spec_comp)
05. Extract environmental predictors (05_Extract_envr)
06. Fit RDA models (06_RDA_models)
07. Fit MRM models (07_MRM_models)
08. Examine variance in composition and environment across scales (08_Data_variance_across_scales)
09. Examine importance of environmental predictors (09_Envr_importance)

# How to use
This repository is meant to be a reasonably well-documented record of the analyses carried out in the manuscript detailed above. 

# Associated data products
At the time of publication, plot-level data will be made publically available via Dryad repository. The plot-level data was generated using R scripts 1-5 and can be used to replicate analyses conducted in R scripts 6-9.
