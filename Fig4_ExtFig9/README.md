# Function explanations in Fig4abc_ExtFig10
This folder contains necessary code and data to generate Fig. 4a-c and Extended Data Fig. 10. It contains MATLAB scripts for PCAD and DRF model application, calibration and result post-processing across four scenarios (**HB**, **LC**, **MB**, and **SVM**). The results are presented in Origin Lab files `PerceivedRiskandPrediction.opju` and `OverallError.opju`. The structure of this folder is as follows:
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

## [Fig4abc_ExtFig10](./Figabc_ExtFig10/)
### [ModelCalibration_PCAD_DRF_HB.m](./ModelCalibration_PCAD_DRF_HB.m)
This MATLAB script performs the calibration of **DRF** and **PCAD** in the **HB** scenario. The script is optimized for local execution, and for HPC (High-Performance Computing) where a `.sh` file needs to be included.

#### Key Features:
- Calibrates **DRF** and **PCAD** models in the HB scenario.
- Uses **parallel processing** for efficient execution, utilizing up to 12 workers.
- Employs **bootstrap resampling** and **random search** methods to find the best model parameters.

#### Inputs:
- **Kinematic Data**: Loaded from `KinematicData.mat`, which contains velocity, acceleration, and position data.
- **Subjective Ratings**: Loaded from `SubjectiveRatings.mat`, which contains risk perception data.

#### Outputs:
- The calibrated parameters for **DRF** and **PCAD** are saved as a `.mat` file (`CalibratedParameters_HB.mat`).
- The output includes the following structures:
  - **results_DRF**: Contains the calibrated DRF parameters and costs.
  - **results_PCAD**: Contains the calibrated PCAD parameters and costs.
  - **DRF**: Contains the computed DRF values for each event.
  - **PCAD**: Contains the computed PCAD values for each event.

#### Parallel Processing:
- The script checks for an existing parallel pool and either uses it or creates a new pool with the specified number of workers (`nworkers = 12`).
  
#### PCAD Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for PCAD**:
  - `sig_xs`: [0, 6] (Uncertainty in subject vehicle's x-coordinate)
  - `sig_ys`: [0, 6] (Uncertainty in subject vehicle's y-coordinate)
  - `sig_xn`: [0, 6] (Uncertainty in neighboring vehicle's x-coordinate)
  - `sig_yn`: [0, 6] (Uncertainty in neighboring vehicle's y-coordinate)
  - `tps`: [0, 1] (Time parameter for the subject vehicle)
  - `tpn`: [0, 1] (Time parameter for the neighboring vehicle)
  - `alpha`: [0, 2] (Weight parameter)

- A **random search** within the defined parameter ranges is performed for each bootstrap sample, and the cost function is minimized.

#### DRF Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for DRF**:
  - `tla`: [0, 10] (Time to lateral acceleration)
  - `m`: [0, 1e-3] (Mass parameter)
  - `c`: [0, 1] (Friction coefficient)
  - `s`: [0, 1] (Lateral speed coefficient)

- Similar to PCAD, a **random search** is performed, and the cost function is minimized for each bootstrap sample.

#### Example Workflow:
1. **Load Data**:
    - Kinematic and subjective rating data are loaded from `KinematicData.mat` and `SubjectiveRatings.mat`.
  
2. **Data Processing**:
    - Position, velocity, and acceleration data for subject and neighboring vehicles are extracted and preprocessed.

3. **Bootstrap and Parameter Search**:
    - For each bootstrap sample, random parameter values are generated within the defined ranges.
    - The cost function for both **PCAD** and **DRF** is evaluated using the resampled data.

4. **Model Calibration**:
    - The best parameters for each bootstrap sample are identified by minimizing the cost function.
    - Results are stored for later analysis.

5. **Save Results**:
    - The final calibrated parameters and model values are saved in a `.mat` file (`CalibratedParameters_HB.mat`).

#### Dependencies:
- The script uses the following functions for cost computation and model evaluation:
  - `cost_function_PCAD.m` for the PCAD cost function.
  - `cost_function_DRF.m` for the DRF cost function.
  - `PCAD_function.m` for PCAD model calculation.
  - `DRF_cal.m` for DRF model calculation.

#### Notes:
- The parallel processing and random search help speed up the calibration process significantly.
- The bootstrap approach ensures robust parameter estimation by resampling the data.
- The PCAD and DRF functions are computed for each event in the HB scenario (27 events in total).

#### Save Output:
The script saves the following results in `CalibratedParameters_HB.mat`:
- **results_DRF**: DRF calibration results (parameters and costs)
- **results_PCAD**: PCAD calibration results (parameters and costs)
- **DRF**: DRF values for each event and bootstrap sample
- **PCAD**: PCAD values for each event and bootstrap sample

### [ModelCalibration_PCAD_DRF_LC.m](./ModelCalibration_PCAD_DRF_LC.m)
This MATLAB script calibrates the **DRF** and **PCAD** models in the **LC** scenario. This version is optimized for local execution, and for High-Performance Computing (HPC) where a `.sh` file should be included.

#### Key Features:
- Calibrates **DRF** and **PCAD** models using bootstrap resampling and random search methods.
- The calibration is executed using **parallel processing** with up to 12 workers for efficiency.
- The script processes position, velocity, and acceleration data for both subject and neighboring vehicles from the **LC** scenario.

#### Inputs:
- **Kinematic Data**: Loaded from `KinematicData.mat`, which contains velocity, acceleration, and position data for the LC scenario.
- **Subjective Ratings**: Loaded from `SubjectiveRatings.mat`, which contains risk perception data.

#### Outputs:
- The calibrated parameters for **DRF** and **PCAD** are saved as a `.mat` file (`CalibratedParameters_LC.mat`).
- Output structures:
  - **results_DRF**: Calibrated DRF parameters and costs.
  - **results_PCAD**: Calibrated PCAD parameters and costs.
  - **DRF**: Computed DRF values for each event.
  - **PCAD**: Computed PCAD values for each event.

#### Parallel Processing:
- The script checks for an existing parallel pool. If none exists, it starts a new pool with the specified number of workers (`nworkers = 12`).

#### PCAD Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for PCAD**:
  - `sig_xs`: [0, 6] (Uncertainty in subject vehicle's x-coordinate)
  - `sig_ys`: [0, 6] (Uncertainty in subject vehicle's y-coordinate)
  - `sig_xn`: [0, 6] (Uncertainty in neighboring vehicle's x-coordinate)
  - `sig_yn`: [0, 6] (Uncertainty in neighboring vehicle's y-coordinate)
  - `tps`: [0, 1] (Time parameter for the subject vehicle)
  - `tpn`: [0, 1] (Time parameter for the neighboring vehicle)
  - `alpha`: [0, 2] (Weight parameter)

- **Bootstrap and Parameter Search**: A bootstrap sample is created, and for each sample, random parameter values are selected within the defined ranges. The cost function is minimized, and the best parameters are stored.

#### DRF Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for DRF**:
  - `tla`: [0, 10] (Time to lateral acceleration)
  - `m`: [0, 1e-3] (Mass parameter)
  - `c`: [0, 1] (Friction coefficient)
  - `s`: [0, 1] (Lateral speed coefficient)

- Similar to PCAD, a random search is performed within the parameter ranges, and the cost function is minimized.

#### Example Workflow:
1. **Load Data**: The kinematic data and subjective ratings are loaded from the specified files.
2. **Data Preprocessing**: The script processes position, velocity, and acceleration data for both the subject and neighboring vehicles.
3. **Bootstrap and Random Search**: Bootstrap samples are created, and a random search is conducted within the parameter ranges for both PCAD and DRF.
4. **Model Calibration**: The best parameters for each bootstrap sample are selected based on minimizing the cost function.
5. **Save Results**: The results of the calibration are stored in the output structures and saved in a `.mat` file (`CalibratedParameters_LC.mat`).

#### Dependencies:
- **cost_function_PCAD.m**: Evaluates the PCAD cost function.
- **cost_function_DRF.m**: Evaluates the DRF cost function.
- **PCAD_function.m**: Calculates the PCAD values.
- **DRF_cal.m**: Calculates the DRF values.

#### Save Output:
The script saves the following results in `CalibratedParameters_LC.mat`:
- **results_DRF**: DRF calibration results (parameters and costs).
- **results_PCAD**: PCAD calibration results (parameters and costs).
- **DRF**: DRF values for each event.
- **PCAD**: PCAD values for each event.

### [Modelcalibration_PCAD_DRF_MB.m](./Modelcalibration_PCAD_DRF_MB.m)
This MATLAB script performs the calibration of **DRF** and **PCAD** in the **MB** scenario. The script is intended for local execution, but it can be adapted for use on an HPC system by including a `.sh` file.

#### Key Features:
- Calibrates **DRF** and **PCAD** models using bootstrap resampling and random search.
- Uses **parallel processing** to speed up calibration, utilizing up to 12 workers.
- Processes kinematic data and subjective ratings to optimize the models.

#### Inputs:
- **Kinematic Data**: Loaded from `KinematicData.mat`, which contains velocity, acceleration, and position data for the MB scenario.
- **Subjective Ratings**: Loaded from `SubjectiveRatings.mat`, which contains perceived risk ratings.

#### Outputs:
- The calibrated parameters for **DRF** and **PCAD** are saved as a `.mat` file (`CalibratedParameters_MB.mat`).
- The output includes the following structures:
  - **results_DRF**: Contains the calibrated DRF parameters and costs.
  - **results_PCAD**: Contains the calibrated PCAD parameters and costs.
  - **DRF**: Contains the computed DRF values for each event.
  - **PCAD**: Contains the computed PCAD values for each event.

#### Parallel Processing:
- The script checks for an existing parallel pool. If none exists, it creates a new pool with 12 workers (`nworkers = 12`).

#### PCAD Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200 (balanced for accuracy and computation cost)
- **Parameter Ranges for PCAD**:
  - `sig_xs`: [0, 6] (Uncertainty in the subject vehicle's x-coordinate)
  - `sig_ys`: [0, 6] (Uncertainty in the subject vehicle's y-coordinate)
  - `sig_xn`: [0, 6] (Uncertainty in the neighboring vehicle's x-coordinate)
  - `sig_yn`: [0, 6] (Uncertainty in the neighboring vehicle's y-coordinate)
  - `tps`: [0, 1] (Time parameter for the subject vehicle)
  - `tpn`: [0, 1] (Time parameter for the neighboring vehicle)
  - `alpha`: [0, 2] (Weight parameter)

- **Bootstrap and Random Search**: For each bootstrap sample, a random search is performed within the defined parameter ranges to minimize the cost function, and the best parameters are stored.

#### DRF Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for DRF**:
  - `tla`: [0, 10] (Time to lateral acceleration)
  - `m`: [0, 1e-3] (Mass parameter)
  - `c`: [0, 1] (Friction coefficient)
  - `s`: [0, 1] (Lateral speed coefficient)

- Similar to PCAD, a random search is performed for each bootstrap sample, and the best parameters are selected by minimizing the cost function.

#### Example Workflow:
1. **Load Data**: Load kinematic data and subjective ratings from the specified files.
2. **Data Preprocessing**: Extract position, velocity, and acceleration data for both the subject and neighboring vehicles in the MB scenario.
3. **Bootstrap and Random Search**: Perform bootstrap resampling and random search to identify the best parameter sets for PCAD and DRF.
4. **Model Calibration**: Calibrate the PCAD and DRF models based on the best parameters for each bootstrap sample.
5. **Save Results**: Save the calibrated parameters and model values in a `.mat` file.

#### Dependencies:
- **cost_function_PCAD.m**: Evaluates the PCAD cost function.
- **cost_function_DRF.m**: Evaluates the DRF cost function.
- **PCAD_function.m**: Computes the PCAD values for each event.
- **DRF_cal.m**: Computes the DRF values for each event.

#### Save Output:
The script saves the following results in `CalibratedParameters_MB.mat`:
- **results_DRF**: DRF calibration results (parameters and costs).
- **results_PCAD**: PCAD calibration results (parameters and costs).
- **DRF**: DRF values for each event.
- **PCAD**: PCAD values for each event.

### [ModelCalibration_PCAD_DRF_SVM.m](./ModelCalibration_PCAD_DRF_SVM.m)
This MATLAB script calibrates the **DRF** and **PCAD** models in the **SVM** scenario. This version is designed for local execution, and for HPC (High-Performance Computing), a `.sh` file should be included.

#### Key Features:
- Calibrates **DRF** and **PCAD** models using bootstrap resampling and random search methods.
- Uses **parallel processing** for efficient execution with up to 12 workers.
- Processes kinematic data and subjective ratings to optimize the models for the **SVM** scenario.

#### Inputs:
- **Kinematic Data**: Loaded from `KinematicData.mat`, containing velocity, acceleration, and position data.
- **Subjective Ratings**: Loaded from `SubjectiveRatings.mat`, containing perceived risk ratings.

#### Outputs:
- The calibrated parameters for **DRF** and **PCAD** are saved in a `.mat` file (`CalibratedParameters_SVM.mat`).
- The following structures are saved:
  - **results_DRF**: Contains the calibrated DRF parameters and costs.
  - **results_PCAD**: Contains the calibrated PCAD parameters and costs.
  - **DRF**: Contains the computed DRF values for each event.
  - **PCAD**: Contains the computed PCAD values for each event.

#### Parallel Processing:
- The script checks for an existing parallel pool. If none exists, it starts a new pool with 12 workers (`nworkers = 12`).

#### PCAD Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for PCAD**:
  - `sig_xs`: [0, 6] (Uncertainty in the subject vehicle's x-coordinate)
  - `sig_ys`: [0, 6] (Uncertainty in the subject vehicle's y-coordinate)
  - `sig_xn`: [0, 6] (Uncertainty in the neighboring vehicle's x-coordinate)
  - `sig_yn`: [0, 6] (Uncertainty in the neighboring vehicle's y-coordinate)
  - `tps`: [0, 1] (Time parameter for the subject vehicle)
  - `tpn`: [0, 1] (Time parameter for the neighboring vehicle)
  - `alpha`: [0, 2] (Weight parameter)

- **Bootstrap and Random Search**: For each bootstrap sample, a random search is performed within the defined parameter ranges, and the best parameters are stored based on the minimized cost function.

#### DRF Calibration:
- **Number of Bootstrap Samples**: 100
- **Number of Iterations**: 200
- **Parameter Ranges for DRF**:
  - `tla`: [0, 10] (Time to lateral acceleration)
  - `m`: [0, 1e-3] (Mass parameter)
  - `c`: [0, 1] (Friction coefficient)
  - `s`: [0, 1] (Lateral speed coefficient)

- Similar to PCAD, a random search is performed for DRF, and the best parameters are selected based on the minimized cost function.

#### Example Workflow:
1. **Load Data**: Load kinematic data and subjective ratings from the respective files.
2. **Data Preprocessing**: Extract position, velocity, and acceleration data for both subject and neighboring vehicles.
3. **Bootstrap and Random Search**: Perform bootstrap resampling and random search to find the best parameter sets for PCAD and DRF.
4. **Model Calibration**: Calibrate the PCAD and DRF models using the best parameters for each bootstrap sample.
5. **Save Results**: Store the calibrated parameters and model values in a `.mat` file.

#### Dependencies:
- **cost_function_PCAD.m**: Evaluates the PCAD cost function.
- **cost_function_DRF.m**: Evaluates the DRF cost function.
- **PCAD_function.m**: Computes the PCAD values.
- **DRF_cal.m**: Computes the DRF values.

#### Save Output:
The script saves the following results in `CalibratedParameters_SVM.mat`:
- **results_DRF**: DRF calibration results (parameters and costs).
- **results_PCAD**: PCAD calibration results (parameters and costs).
- **DRF**: DRF values for each event.
- **PCAD**: PCAD values for each event.

### [ResultsScaling_EpistemicUncertaintyCal.m](./ResultsScaling_EpistemicUncertaintyCal.m)
This MATLAB script scales the outputs of **PCAD**, **DRF**, and **DNNs** models to a range of 0-10 and calculates epistemic uncertainty of the models for the **MB**, **HB**, **SVM**, and **LC** scenarios. It also compares model predictions against subjective ratings and calculates residual errors.

#### Key Features:
- Scales the output of **PCAD**, **DRF**, and **DNNs** models into the range of 0-10 for better interpretability.
- Computes **epistemic uncertainty** for each model using the variance in the model outputs over multiple iterations (bootstrap resampling).
- Compares the predictions of the models against actual subjective ratings and calculates **residual errors**.
- Generates visualizations of the scaled predictions and uncertainty intervals for each event.
- Boxplots of the residual errors are plotted for comparison across models.

#### Workflow:
1. **Load Data**: The script loads:
   - Calibrated PCAD and DRF parameters from `.mat` files (e.g., `CalibratedParameters_MB.mat`, `CalibratedParameters_HB.mat`, etc.).
   - Subjective ratings data (e.g., `SubjectiveRatings.mat`).
   - Neural network predictions from DNNs models for each scenario (e.g., `DNNs/MB.mat`, `DNNs/HB.mat`, etc.).
  
2. **Model Output Scaling**:
   - For each iteration, the script scales the outputs of the **PCAD** and **DRF** models into the range of 0-10 by dividing by the maximum value from each iteration's output.
   - The **DNNs** model predictions are already scaled and do not require further scaling.

3. **Plot Data Creation**:
   - For each event, the scaled model values are used to compute:
     - **Mean values** across iterations.
     - **Epistemic uncertainty** (variance from the mean across iterations).
     - **Prediction intervals** (upper and lower bounds based on uncertainty).

4. **Residual Error Calculation**:
   - For each event, the script calculates the absolute error between the scaled model predictions and the subjective risk ratings from the `SubjectiveRatings.mat` file.
   - Residual errors are stored for each model.

5. **Visualization**:
   - The script creates plots for the scaled predictions and uncertainties for **PCAD**, **DRF**, and **DNNs** for each event.
   - **Boxplots** are created to compare residual errors across the three models for each scenario.

6. **Saving the Results**:
   - The scaled predictions and uncertainty data for **PCAD**, **DRF**, and **DNNs** are saved in `.mat` files for later use, with filenames like `Prediction_MB.mat`, `Prediction_HB.mat`, etc.

#### Outputs:
- **Scaled Model Values**: Scaled outputs for PCAD, DRF, and DNNs models.
- **Epistemic Uncertainty**: Variance in model outputs across iterations.
- **Residual Errors**: Absolute differences between model predictions and subjective risk ratings.
- **Visualizations**: 
  - Time-series plots of model predictions with uncertainty intervals.
  - Boxplots comparing the residual errors for each model.

#### Example Process:

##### 1. Load Data:
```matlab
load('./CalibrationResults/PCAD_DRF/CalibratedParameters_MB.mat');
load('../Data/SubjectiveRatings.mat');
load('./CalibrationResults/DNNs/MB.mat');
```
##### 2.Scale the Model Outputs
```matlab
for ii = 1:iter
    PCAD_scaled(nn).value(ii,:) = PCAD(nn).value(ii, :) / maxValIter_PCAD * 10;
    DRF_scaled(nn).value(ii,:) = DRF(nn).value(ii, :) / maxValIter_DRF * 10;
end
```

##### 3. Calculate Epistemic Uncertainty:
```matlab
PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2) ./ iter)';
DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2) ./ iter)';
```

##### 4. Compare to Subjective Ratings
```matlab
PCAD_scaled(nn).error = abs(PCAD_scaled(nn).plotData(:,3) - HB_PR(nn).risk_p25_p75_mean');
```
##### 5. Visualisation
```matlab
figure;
for nn = 1:27
    subplot(5,6,nn);
    plot(PCAD_scaled(nn).plotData(:,1), max(PCAD_scaled(nn).plotData(:,3) - PCAD_scaled(nn).plotData(:,2), 0)); hold on;
    plot(PCAD_scaled(nn).plotData(:,1), PCAD_scaled(nn).plotData(:,3)); hold on;
    plot(PCAD_scaled(nn).plotData(:,1), min(PCAD_scaled(nn).plotData(:,3) + PCAD_scaled(nn).plotData(:,4), 10)); hold on;
    ylim([0 10]);
end
```
#### Scenarios Covered
- **MB Scenario**: Handles data scaling, prediction comparison, and residual error calculation for the MB scenario.
- **HB Scenario**: Similar to MB, but processes data specific to the HB scenario.
- **SVM Scenario**: Scale and evaluates the SVM scenario, handling 27 events.
- **LC Scenario**: Process data for the LC scenario, split into **LC_1**, **LC_2**, and **LC_3** with different event ranges.

#### Dependencies
- The script depends on the output from prior calibration steps for PCAD, DRF, and NN models.
- It also relies on subjective risk ratings for comparison.

#### Save Results
- Results are saved in the `PredictionResults/` folder with filenames like `Prediction_MB.mat`, `Prediction_HB.mat`, etc.

## [SMoSFunctions/](./SMoSFunctions/)  
This folder contains MATLAB scripts for `PCAD` and `DRF` models to compute perceived risk. For details, please check *He, X. (Creator), (Creator), Wang, M. (Creator) (17 Jul 2024). Data and code underlying the publication: A new computational perceived risk model for automated vehicles based on potential collision avoidance difficulty (PCAD). TU Delft - 4TU.ResearchData. [10.4121/3ad2db22-ea82-4436-8df5-ebbbdb4aeec6](https://doi.org/10.4121/3ad2db22-ea82-4436-8df5-ebbbdb4aeec6)*

## [CalibrationResults/](./CalibrationResults/)  
This folder contains the calibrated model parameters and prediction results (unscaled) of `DNNs` `PCAD` and `DRF`, which are called by function `ResultsScaling_EpistemicUncertaintyCal.m`. 

## [PredictionResults/](./PredictionResults/)
This folder contains the scaled prediction of perceived risk (0-10) from the three models `DNNs` `PCAD` and `DRF`. 

## [PerceivedRiskandPrediction.opju](,/PerceivedRiskandPrediction.opju)
This Origin Lab file contains model prediction results of the three models `DNNs` `PCAD` and `DRF` across four scenarios in project `1MB_Prediction`, `2HB_Prediction`, `3LC_Prediction` and `4SVM_Prediction`.
