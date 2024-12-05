# Data and code underlying the online perceived risk study

This study explores the dynamic nature of perceived risk in vehicle interactions. Using a novel simulation-based approach, time-continuous perceived risk data were obtained from over 140k ratings by 2,164 participants across various traffic scenarios. This package contains the collected perceived risk data, corresponding kinematic data of the simulation, code and software implementation in MATLAB, Python, SPSS, and Origin for data processing, statistical analysis, model calibration, perceived risk prediction, SHAP analysis and visualisation. 

## Directory Structure
- [Data](./Data): This folder contains subjective perceived risk data `SubjectiveRatings.mat` and corresponding kinematic data `KinematicData.mat` of simulations for analysis. Detailed documentation of the data can be found in [Data/README.md](./Data/README.md).
  
- [DataProcess](./DataProcess): This folder contains functions that generate different fields of  `SubjectiveRatings.mat` and `KinematicData.mat` in [Data/](./Data/). The structure of this folder is as follows. Detailed documentation of the functions can be found in [DataProcess/README.md](./DataProcess/README.md).
```
DataProcess/
│
├── KinematicData/
│   ├── DRAC_computation.m
│   ├── Uncertain_v_computation.m
│   ├── functionLibrary/
│   │   ├── Uncertain_v.m
│   │   └── d_dot_cal.m
├── SubjectiveRatings/
│   ├── AleatoricUncertaintyCal.m
│   ├── DataSelection_corr.m
│   ├── PerceivedRiskInterpolationForAllRatings.m
│   ├── PerceivedRiskInterpolationForPercentile.m
│   ├── RatingsPercentile.m
│   ├── ReorderRatingsForSPSS.m
│   ├── functionLibrary/
│   │   ├── chckxy.m
│   │   ├── pchipNew.m
│   └── SubjectiveRatings_raw.mat
```
- [Fig2a-c_ExtFig3a-c_g-i_m-o](./Fig2a-c_ExtFig3a-c_g-i_m-o): This folder contains functions that generate Fig. 2a-c, Extended Data Fig. 3a-c, g-i and m-o. The structure of this folder is as follows. Detailed documentation of the functions can be found in [Fig2a-c_ExtFig3a-c_g-i_m-o/README.md](./Fig2a-c_ExtFig3a-c_g-i_m-o/README.md).
```
Fig2a_ExtFig2a-c_g-i_m-o/
├── ClipAnalysis_HB.m
├── ClipAnalysis_LC.m
├── ClipAnalysis_MB.m
├── ClipAnalysis_SVM.m
├── SubjectiveRatings/
│   └── boxplotGroup,m
├── Significance_boxplot.opju
```
- [Fig2d-f_ExtFig3d-f_j-l_p-r](./Fig2d-f_ExtFig3d-f_j-l_p-r): This folder contains functions that generate Fig. 2d-f, Extended Data Fig. 3d-f, j-l and p-r. The structure of this folder is as follows. Detailed documentation of the functions can be found in [Fig2d-f_ExtFig3d-f_j-l_p-r/README.md](./Fig2d-f_ExtFig3d-f_j-l_p-r/README.md).
```
Fig2d-f_ExtFig3d-f_j-l_p-r/
├── HB_JS_divergence.m
├── LC_JS_divergence.m
├── MB_JS_divergence.m
├── SVM_JS_divergence.m
└── mvgkl.m
```
- [Fig3_ExtFig7](./Fig3ExtFig7): This folder contains an Origin Lab file `PerceivedRiskandPrediction.opju`. In project `1MB_PerceivedRisk`, `2HB_PerceivedRisk`, `3LC_PerceivedRisk`, and `4SVM_PerceivedRisk`, all plots and corresponding data can be found. 
- [Fig4abc_ExtFig10/](./Fig4abc_ExtFig10/): This folder contains necessary code and data to generate Fig. 4a-c and Extended Data Fig. 10. It contains MATLAB scripts for PCAD and DRF model application, calibration and result post-processing across four scenarios (**HB**, **LC**, **MB**, and **SVM**). The results are presented in Origin Lab files `PerceivedRiskandPrediction.opju` and `OverallError.opju`. The structure of this folder is as follows. Detailed documentation of the functions can be found in [Fig4abc_ExtFig10/README.md](./Fig4abc_ExtFig10/README.md).

```
Fig4abc_ExtFig10/
├── ModelCalibration_PCAD_DRF_HB.m
├── ModelCalibration_PCAD_DRF_LC.m
├── ModelCalibration_PCAD_DRF_MB.m
├── ModelCalibration_PCAD_DRF_SVM.m
├── ModelCalibration_PCAD_DRF_SVM.m
├── ResultingsScaling_EpistemicUncerdtaintyCal.m
├── PerceivedRiskandPrediction.opju
├── OverallError.opju
├── SMoS_Functions/
      └── DRF/
            ├── cost_function_DRF.m
            └── DRF_cal.m
      ├── PCAD/
            ├── BearingRate_prod.m
            ├── cost_function_PCAD.m
            ├── d_dot_cal
            ├── Imaginary_v.m
            └── PCAD_function.m
├── PredictionResults/
      ├── Prediction_HB.mat
      ├── Prediction_LC1.mat
      ├── Prediction_LC2.mat
      ├── Prediction_LC3.mat
      ├── Prediction_MB.mat
      └── Prediction_SVM.mat
├── CalibrationResults/
      └── DNNs/
      └── Prediction_SVM.mat
```
- [Table1/](./Table1/): This folder contains necessary data in SPSS for the statistical analysis. Detailed documentation of the files and data can be found in [Table1/README.md](./Table1/README.md).

- [ExtFig6/](./ExtFig6/): This folder contains a MATLAB script `ExtFig6.m` generating necessary data for Extended Data Fig.6 and an Origin Lab file `ExtFig6.opju` for the plotting.

- [ScenarioDesign/](./ScenarioDesign/): This folder contains a table `parameter_list.xlsx` listing all controlled parameters for the four scenarios.

- [HREC/](./HREC/): This folder contains the `Letter of approval` for this study issued by Human Research Ethics Committee (HREC) of TU Delft. 

