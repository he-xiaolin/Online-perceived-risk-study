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
- [Fig2](./Fig2): This folder contains functions that generate Fig. 2a-c, Extended Data Fig. 3a-c, g-i and m-o. The structure of this folder is as follows. Detailed documentation of the functions can be found in [Fig2/README.md](./Fig2/README.md).
```
Fig2/
├── ClipAnalysis_HB.m
├── ClipAnalysis_LC.m
├── ClipAnalysis_MB.m
├── ClipAnalysis_SVM.m
├── SubjectiveRatings/
│   └── boxplotGroup,m
├── Significance_boxplot.opju
```
- [Fig3_ExtFig5](./Fig3ExtFig5): This folder contains an Origin Lab file `PerceivedRiskandPrediction.opju`. In project `1MB_PerceivedRisk`, `2HB_PerceivedRisk`, `3LC_PerceivedRisk`, and `4SVM_PerceivedRisk`, all plots and corresponding data can be found. 
- [Fig4_ExtFig9/](./Fig4abc_ExtFig9/): This folder contains necessary code and data to generate Fig. 4a-c and Extended Data Fig. 10. It contains MATLAB scripts for PCAD and DRF model application, calibration and result post-processing across four scenarios (**HB**, **LC**, **MB**, and **SVM**). The results are presented in Origin Lab files `PerceivedRiskandPrediction.opju` and `OverallError.opju`. The structure of this folder is as follows. Detailed documentation of the functions can be found in [Fig4_ExtFig9/README.md](./Fig4_ExtFig9/README.md).

```
Fig4_ExtFig9/
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
- [Fig5](./Fig5): This folder contains the Python code to generate `Fig5a.pdf` and `Fig5b.pdf`.
```
Fig5/
├── DNNs/
├── Fig5a.pdf
└── Fig5b.pdf
```
- [Table1/](./Table1/): This folder contains necessary data in SPSS for the statistical analysis. Detailed documentation of the files and data can be found in [Table1/README.md](./Table1/README.md).

- [ExtFig4/](./ExtFig6/): This folder contains a MATLAB script `ExtFig4.m` generating necessary data for Extended Data Fig.4 and an Origin Lab file `ExtFig4.opju` for the plotting.

- [ScenarioDesign/](./ScenarioDesign/): This folder contains a table `parameter_list.xlsx` listing all controlled parameters for the four scenarios.

- [HREC/](./HREC/): This folder contains the `Letter of approval` for this study issued by Human Research Ethics Committee (HREC) of TU Delft. 

