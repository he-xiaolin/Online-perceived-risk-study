# Explanations for files for statistical analysis in Table 1
This folder contains necessary MATLAB scripts to reorganise the data for SPSS, `.sav` data files for SPSS analysis and `.spv` results files generated in the linear mixed model analysis. The folder structure is as follows. 

```
Table1/
├── DataProcessScriptsForSPSS/
      ├── HB_data_extraction.m
      ├── LC_data_extraction.m
      ├── MB_data_extraction.m
      ├── SVM_data_extraction.m
      ├── reorganized_HB_data.csv
      ├── reorganized_LC_data.csv
      ├── reorganized_MB_data.csv
      ├── reorganized_SVM_data.csv
      └── eta-squared calculation.xlsx
├── SPSS analysis/
      ├── Data/
         ├── HB_data_LMM.sav
         ├── LC_data_LMM.sav
         ├── MB_data_LMM.sav
         └── SVM_data_LMM.sav
      └── Results/
         ├── HB_LMM.spv
         ├── LC_LMM.spv
         ├── MB_LMM.spv
         └── SVM_LMM.spv
```
## [Table1/](./)
### [./DataProcessScriptsForSPSS/](./DataProcessScriptsForSPSS/)
This folder contains four files `MB_data_extraction.m`, `HB_data_extraction.m`, `LC_data_extraction.m`, and `SVM_data_extraction.m` to reorganise the data to the format that is suitable for a linear mixed model analysis in SPSS. These scripts generates data files `reorganised_MB_data_extraction.csv`, `reorganised_HB_data_extraction.csv`,  `reorganised_LC_data_extraction.csv` and `reorganised_SVM_data_extraction.csv`, which can be imported into SPSS for further analysis. `eta-squared calculation.xlsx` calculates the eta-squared for each of the variables. 

### [./SPSS_analysis/](./SPSS_analysis/)
#### [./SPSS_analysis/Data/](./SPSS_analysis/Data/)
This folder contains reorganised data files `HB_data_LMM.sav`, `MB_data_LMM.sav`, `LC_data_LMM.sav`, and `SVM_data_LMM.sav` for a linear mixed model analysis in SPSS. In **Analyze->Mixed Model->Linear Mixed Model**, add `ParticipantID` into **Subjects** box and continue. Move `PerceivedRiskRating` to **Dependent Variable**. Move all categorical variables into **Factor(s)** box and move all continuous variables into **Covariate(s)**. In **Fixed Effects**, move all variables in **Factors and Covariates** into **Model**. Check `Include intercept` and set `Sum of suqares:` as Type III and continue. In **Random Effects**, only move `ParticipantID` in **Subjects** box to **Combinations** and continue. Then start the analysis. The analysis will generate the corresponding `.spv` file. 

#### [./SPSS analysis/Results](./SPSS_analysis/Data/)
This folder contains the results of the linear mixed model analysis `MB_LMM.spv`, `HB_LMM.spv`, `LC_LMM.spv`, and `SVM_LMM.spv`. In the table of **Type III Test of Fixed Effects**, one can find the F value and p-value. See `eta-squared calculation.xlsx` for the details of eta-squared calculation.
