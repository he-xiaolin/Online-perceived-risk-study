# Function explanations in DataProcess

This folder contains MATLAB scripts and raw perceived risk data `SubjectiveRatings_raw.mat` for processing, computing and generating differnet different fields in `SubjectiveRatings.mat` in [../Data/](../Data/). The structure is as follows.
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
## [KinematicData/](./KinematicData/)
### [DRAC_computation.m](./KinematicData/DRAC_computation.m)
This MATLAB script calculates the **Deceleration rate to avoid a crash (DRAC)** of the subject to the neighbouring vehicles across four different scenarios: **HB**, **MB**, **SVM**, and **LC**. The DRAC is computed for both the **real** (`DRAC_R`) and **uncertain** (`DRAC_I`) components using kinematic data such as velocity, acceleration, and position. 

#### Key Features:
- In the **SVM** scenario, the script also computes DRAC for a **second neighbouring vehicle** positioned behind the subject vehicle.
- The script processes data for 27 events in the **HB**, **MB**, and **SVM** scenarios, and 24 events in the **LC** scenario.

#### Inputs:
- The script loads kinematic data from the file `KinematicData.mat`, which contains the necessary velocity, acceleration, and position data for each scenario.

#### Outputs:
- The script updates the DRAC components (`DRAC_R`, `DRAC_I`, `DRAC_Rx`, `DRAC_Ry`, `DRAC_Ix`, `DRAC_Iy`) for each scenario and stores the results in the corresponding structure (**HB**, **MB**, **SVM**, **LC**).

#### Dependencies:
- The function `d_dot_cal.m` (located in the [functionLibrary/](functionLibrary/) folder) is used to calculate the **rate of change of distance** (d_dot).

#### Notes:
- The DRAC calculations take into account both the **real** and **uncertain** components of the velocity and position data, providing insights into how the vehicles adjust their speed and acceleration in response to each other.

### [Uncertain_v_computation.m](./KinematicData/Uncertain_v_computation.m)
This MATLAB script calculates the **uncertain velocity** of the subject and neighbouring vehicles across four different scenarios: **HB**, **MB**, **SVM**, and **LC**. The uncertain velocity is computed using kinematic data such as position and velocity, with defined uncertainties in the x and y directions for both the subject and neighbouring vehicles.

#### Key Features:
- In the **SVM** scenario, the script also computes uncertain velocity for a **second neighbouring vehicle** positioned behind the subject vehicle.
- The script processes data for 27 events in the **HB**, **MB**, and **SVM** scenarios, and 24 events in the **LC** scenario.

#### Inputs:
- The script loads kinematic data from the file `KinematicData.mat`, which contains the necessary position and velocity data for each scenario.
- The function **`Uncertain_v`** in [functionLibrary](functionLibrary/) is called to calculate uncertain velocities for each time step using defined uncertainty parameters.

#### Outputs:
- The script stores the calculated uncertain velocity components (`v_In_x`, `v_In_y`, `v_Is_x`, `v_Is_y`) for the subject and neighbouring vehicles in each scenario. For the **SVM** scenario, additional uncertain velocities for the second neighbouring vehicle (`v_In2_x`, `v_In2_y`, `v_Is2_x`, `v_Is2_y`) are also stored.

#### Dependencies:
- The function `Uncertain_v.m` (located in the [functionLibrary/](functionLibrary/) folder) is used to calculate the **uncertain velocities** based on the positions and defined uncertainties for both the subject and neighbouring vehicles.

#### Notes:
- The script defines fixed parameters for the x and y directions of both the subject and neighbouring vehicles:
  - **`sigxs`**: Uncertainty in the subject vehicle's x-coordinate.
  - **`sigys`**: Uncertainty in the subject vehicle's y-coordinate.
  - **`sigxn`**: Uncertainty in the neighbouring vehicle's x-coordinate.
  - **`sigyn`**: Uncertainty in the neighbouring vehicle's y-coordinate.
  
  These values are used to compute the uncertain velocity at each time step.

### [./KinematicData/functionLibrary/](./functionLibrary/)
#### [d_dot_cal.m](./functionLibrary/d_dot_cal.m)
This MATLAB function calculates the **rate of change of the distance (d_dot)** between a subject vehicle and a neighbouring vehicle, given their respective positions and velocities. This is an essential component for computing the **Deceleration rate to avoid a crash (DRAC)**.

##### Inputs:
- **`s_x`, `s_y`**: x and y coordinates of the **subject vehicle**'s position.
- **`s_vx`, `s_vy`**: x and y components of the **subject vehicle**'s velocity.
- **`n_x`, `n_y`**: x and y coordinates of the **neighbouring vehicle**'s position.
- **`n_vx`, `n_vy`**: x and y components of the **neighbouring vehicle**'s velocity.

##### Outputs:
- **`d_dot`**: The rate of change of the distance between the subject and neighbouring vehicles, calculated as the dot product of the position and velocity difference vectors.

##### Function Logic:
1. The function first defines the position vectors for the subject vehicle (`pi`) and neighbouring vehicle (`pj`).
2. It then defines the velocity vectors for the subject vehicle (`vi`) and neighbouring vehicle (`vj`).
3. The distance `d` between the two vehicles is computed using the Euclidean distance formula.
4. Finally, the function calculates `d_dot`, the rate of change of distance, by computing the dot product of the position and velocity difference vectors and dividing it by the distance.

##### Example Usage:
This function is called within larger scripts (such as **DRAC_computation.m**) to calculate the **rate of change of distance** between vehicles in different traffic scenarios.

```matlab
% Example call to d_dot_cal
d_dot = d_dot_cal(s_x, s_vx, s_y, s_vy, n_x, n_vx, n_y, n_vy);
```

#### [Uncertain_v.m](./KinematicData/functionLibrary/Uncertain_v.m)
This MATLAB function calculates the **uncertain velocity vectors** for both the **subject vehicle** and the **neighbouring vehicle**. The uncertain velocity is computed based on their relative positions, with predefined parameters for each vehicle's x and y directions.

##### Inputs:
- **`x_s`, `y_s`**: x and y coordinates of the **subject vehicle**'s position.
- **`x_n`, `y_n`**: x and y coordinates of the **neighbouring vehicle**'s position.
- **`sigxs`, `sigys`**: Uncertainty parameters for the **subject vehicle**'s x and y coordinates.
- **`sigxn`, `sigyn`**: Uncertainty parameters for the **neighbouring vehicle**'s x and y coordinates.

##### Outputs:
- **`v_In`**: Uncertain velocity vector for the **neighbouring vehicle**.
- **`v_Is`**: Uncertain velocity vector for the **subject vehicle**.

##### Function Logic:
1. **Defining Position Vectors**: The positions of the subject and neighbouring vehicles are defined as 3D vectors, with the z-coordinate set to zero.

2. **Calculating Uncertain Velocity for Neighbouring Vehicle (`v_In`)**:
   - The function defines a **probability density function (PDF)** for the neighbouring vehicle's uncertain velocity, using the uncertainty parameters for the x and y directions.
   - It then computes the expected value (`v_In_len`) of the uncertain velocity, representing the magnitude of the velocity vector.
   - The direction of the uncertain velocity is computed using the relative position of the subject and neighbouring vehicles.

3. **Calculating Uncertain Velocity for Subject Vehicle (`v_Is`)**:
   - Similarly, a PDF is defined for the subject vehicle's uncertain velocity, using the corresponding uncertainty parameters for x and y.
   - The expected value (`v_Is_len`) of the subject vehicle's uncertain velocity is calculated, with the velocity vector pointing from the subject to the neighbouring vehicle.

##### Example Usage:
This function is used within larger scripts (such as **Uncertain_v_computation.m**) to calculate uncertain velocities in various traffic scenarios.

##### Notes:
- The function calculates uncertain velocity vectors in 2D space (x and y coordinates), assuming the z-coordinate is zero.
- The uncertainties are applied using probability density functions for both the subject and neighbouring vehicles, ensuring that the calculated velocity vector adheres to the defined uncertainty bounds for each direction (x and y).
- This function plays a key role in understanding how uncertainties in position influence vehicle interactions and predictions in simulations.

## [SubjectiveRatings/](./SubjectiveRatings/)
### [AleatoricUncertaintyCal.m](./SubjectiveRatings/AleatoricUncertaintyCal.m)
This MATLAB script calculates the **aleatoric uncertainty** for the perceived risk ratings across four different scenarios: **MB**, **HB**, **SVM**, and **LC**. The aleatoric uncertainty is estimated using bootstrapping techniques for each moment in time, based on the collected risk data from the `SubjectiveRatings.mat` file.

#### Key Features:
- **Bootstrapping** is performed with 5,000 samples for each moment in time (typically 301 moments), to estimate the standard deviation of the risk values for each participant in each scenario.
- The **aleatoric uncertainty** is calculated as the **mean standard deviation** across all bootstrap samples, providing an estimate of the variability in perceived risk for each moment.

#### Inputs:
- The script loads subjective risk data from `SubjectiveRatings.mat`. The data includes risk ratings collected for four scenarios: **MB**, **HB**, **SVM**, and **LC**.
  - **MB_PR**, **HB_PR**, **SVM_PR**, and **LC_PR**: Each contains perceived risk ratings (`risk`) for a set of participants.

#### Outputs:
- The script computes and updates the **aleatoric uncertainty (AU)** for each scenario (MB, HB, SVM, LC) and stores the results in the corresponding structures (`MB_PR`, `HB_PR`, `SVM_PR`, and `LC_PR`).

#### Function Logic:
1. **Loading the Data**: 
   - The data is loaded from `SubjectiveRatings.mat`, which contains the perceived risk ratings for each participant in each scenario.
   
2. **Bootstrapping Process**:
   - For each moment (typically 301 moments of data), the script performs **bootstrap sampling** (random sampling with replacement) 5,000 times.
   - For each bootstrap sample, the standard deviation is calculated.

3. **Aleatoric Uncertainty Calculation**:
   - After bootstrapping, the script computes the **mean standard deviation** of the bootstrap samples, which serves as the **aleatoric uncertainty (AU)** for that moment.

4. **Saving the Results**:
   - The script updates the aleatoric uncertainty values in the **MB_PR**, **HB_PR**, **SVM_PR**, and **LC_PR** structures, and can optionally save the updated data to `SubjectiveRatings.mat`.

#### Example Usage:
This function is called for each scenario (**MB**, **HB**, **LC**, and **SVM**) to estimate the aleatoric uncertainty of the perceived risk data over time.

```matlab
% Example usage:
% For MB scenario
dir = '../../Data/SubjectiveRatings.mat';
load(dir);
for nn = 1:27
    matrixData = [MB_PR(nn).risk]; 
    numBootstrapSamples = 5000;
    bootstrapResults = zeros(numBootstrapSamples, size(matrixData, 2));
    for moment = 1:size(matrixData, 2)
        for b = 1:numBootstrapSamples
            bootstrapSample = matrixData(randi(size(matrixData, 1), size(matrixData, 1), 1), moment);
            bootstrapResults(b, moment) = std(bootstrapSample);
        end
    end
    MB_PR(nn).AU = mean(bootstrapResults, 1);
end
```

### [DataSelection_corr.m](./SubjectiveRatings/DataSelection_corr.m)
This MATLAB script removes perceived risk rating series for an event that shows a **weak correlation** with the average rating series for that event (correlation coefficient `r < 0.3`). The function processes each scenario (**MB**, **HB**, **SVM**, and **LC**) and eliminates participant ratings that do not meet the correlation threshold or contain `NaN` values. 

Additionally, this function generates the first two fields (`event_ratings` and `idx`) for each scenario in the `SubjectiveRatings.mat` file.

#### Key Features:
- **Selection based on correlation**: Only ratings that have a correlation coefficient greater than or equal to `0.3` with the event's average rating series are kept. Ratings with weak correlation (`r < 0.3`) or missing values (`NaN`) are removed.
- This function processes the data for **2164 participants** whose ratings are originally stored in the `SubjectiveRatings_raw.mat` file and updates the `SubjectiveRatings.mat` file for each scenario.

#### Inputs:
- **`SubjectiveRatings_raw.mat`**: The raw perceived risk ratings of 2164 participants for four different scenarios (**MB**, **HB**, **SVM**, and **LC**).

#### Outputs:
- **`SubjectiveRatings.mat`**: Updated subjective ratings after removing participants with weak correlations or missing values. The fields `event_ratings` and `idx` are updated for each scenario.

#### Function Logic:
1. **Loading the Data**:
   - The script loads the original, unfiltered subjective risk ratings from `SubjectiveRatings_raw.mat`.
   
2. **For Each Scenario (MB, HB, LC, SVM)**:
   - The script computes the **correlation coefficient** between the rating series of each participant and the **average rating series** of the event.
   - Participants whose correlation coefficient is less than `0.3` or whose correlation values are `NaN` are identified.
   - These participants' ratings are **removed** from both the `event_ratings` and `idx` fields.

#### Example Usage:
This function is used to clean and filter the subjective risk ratings based on the correlation between each participant's ratings and the average ratings for a given event.

```matlab
% Example usage for MB scenario
ratings_temp = MB_PR(i).event_ratings; % Load event ratings
ratings_mean = mean(ratings_temp);     % Compute the average rating series
corcoeff = corr(ratings_temp', ratings_mean'); % Calculate correlation
idx_eliminated = find(corcoeff < 0.3); % Find participants with r < 0.3
idx_NaN = find(isnan(corcoeff));       % Find participants with NaN correlation
MB_PR(i).event_ratings([idx_eliminated; idx_NaN], :) = []; % Remove weak ratings
MB_PR(i).idx([idx_eliminated; idx_NaN], :) = [];           % Remove corresponding indices
```
### [PerceivedRiskInterpolationForAllRatings.m](./SubjectiveRatings/PerceivedRiskInterpolationForAllRatings.m)
This MATLAB script **interpolates perceived risk ratings** from the field `event_ratings` into a continuous form and stores the results in the `risk` field for each recording. The interpolation is performed across multiple rows of data (participants) with 301 or 361 time moments, depending on the scenario.

#### Key Features:
- **Interpolation of subjective risk ratings**: The function interpolates the discrete `event_ratings` values into a continuous `risk` field using **Piecewise Cubic Hermite Interpolation**.
- The interpolation is performed for all participants across four different scenarios: **MB**, **HB**, **SVM**, and **LC**.

#### Inputs:
- **`SubjectiveRatings.mat`**: The file contains the subjective risk ratings for each participant in different scenarios. The field `event_ratings` holds discrete perceived risk values that are interpolated into continuous form.

#### Outputs:
- **`SubjectiveRatings.mat`**: The script updates this file by adding the **continuous perceived risk values** to the `risk` field for each participant in each scenario.

#### Function Logic:
1. **Loading the Data**:  
   The script loads the perceived risk data from `SubjectiveRatings.mat` for four scenarios: **MB**, **HB**, **SVM**, and **LC**.

2. **Interpolating the Ratings**:  
   For each participant and event:
   - The function prepares the ratings for interpolation by repeating certain discrete ratings to ensure a smooth interpolation across the specified time points.
   - The **Piecewise Cubic Hermite Interpolation (PCHIP)** is performed using the custom function `pchipNew` to create a continuous risk profile across the time array (`Time`).
   - The interpolated values are stored in the `risk` field.
   - Boundary conditions are applied: if the time is before the first rating or after the last rating, the first or last rating is used, respectively.

3. **Saving the Results**:  
   The script updates the `SubjectiveRatings.mat` file by adding the `risk` field to the data for each participant in the respective scenarios.

#### Example Usage:
This function interpolates discrete perceived risk ratings into continuous values for analysis across all moments in time.

#### Notes:
- **Interpolation method**: The script uses the **Piecewise Cubic Hermite Interpolation (PCHIP)** to ensure that the interpolated values maintain the shape of the original rating series without overshooting.
- The interpolation is performed over 301 or 361 time moments, depending on the scenario.
- Boundary conditions ensure that any time points outside the range of available ratings are assigned the first or last rating, avoiding extrapolation.
- The function processes data for 27 events in the **MB**, **HB**, and **SVM** scenarios, and 24 events in the **LC** scenario.


### [PerceivedRiskInterpolationForPercentiles.m](./SubjectiveRatings/PerceivedRiskInterpolationForPercentiles.m)
This MATLAB script **interpolates continuous perceived risk** by connecting the 5th, 25th, 50th, 75th, and 95th percentiles of perceived risk ratings. The interpolation is performed for each scenario based on the `ratingTiming` field, and the resulting continuous perceived risk values are stored in the fields `risk_p5`, `risk_p25`, `risk_p50`, `risk_p75`, and `risk_p95` for each percentile.

#### Key Features:
- **Percentile-based interpolation**: The function interpolates the percentile-based perceived risk ratings (5th, 25th, 50th, 75th, and 95th) into continuous risk profiles using **Piecewise Cubic Hermite Interpolation**.
- The interpolation is performed for all participants across four different scenarios: **MB**, **HB**, **SVM**, and **LC**.

#### Inputs:
- **`SubjectiveRatings.mat`**: The file contains percentile-based perceived risk ratings (`ratings_p5`, `ratings_p25`, `ratings_p50`, `ratings_p75`, and `ratings_p95`) for each participant in different scenarios. The `ratingTiming` field indicates the discrete time points at which the ratings were provided.

#### Outputs:
- **`SubjectiveRatings.mat`**: The script updates this file by adding the continuous perceived risk values for the 5th, 25th, 50th, 75th, and 95th percentiles to the respective fields (`risk_p5`, `risk_p25`, `risk_p50`, `risk_p75`, `risk_p95`) for each participant in each scenario.

#### Function Logic:
1. **Loading the Data**:  
   The script loads the percentile-based perceived risk data from `SubjectiveRatings.mat` for four scenarios: **MB**, **HB**, **SVM**, and **LC**.

2. **Interpolating the Percentiles**:  
   For each participant and percentile:
   - The function creates an extended list of percentile values by repeating certain discrete ratings to ensure smooth interpolation across the specified time points.
   - The **Piecewise Cubic Hermite Interpolation (PCHIP)** is applied using the custom function `pchipNew` to generate continuous perceived risk values across the time array (`Time`).
   - Boundary conditions are applied: if the time is before the first rating or after the last rating, the first or last rating is used, respectively.

3. **Saving the Results**:  
   The script updates the `SubjectiveRatings.mat` file by adding the continuous percentile-based risk fields (`risk_p5`, `risk_p25`, `risk_p50`, `risk_p75`, `risk_p95`) for each participant in the respective scenarios.

#### Example Usage:
The function interpolates percentile-based perceived risk ratings into continuous values for analysis across all moments in time.

#### Notes:
- **Interpolation method**: The script uses **Piecewise Cubic Hermite Interpolation (PCHIP)** to ensure that the interpolated values maintain the shape of the original rating series without overshooting.
- Boundary conditions ensure that any time points outside the range of available ratings are assigned the first or last rating, avoiding extrapolation.
- The function processes data for 27 events in the **MB**, **HB**, and **SVM** scenarios, and 24 events in the **LC** scenario.

### [RatingsPercentile.m](./SubjectiveRatings/RatingsPercentile.m)
This MATLAB script **calculates the 5th, 25th, 50th, 75th, and 95th percentiles** of perceived risk ratings for each event in four scenarios: **MB**, **HB**, **SVM**, and **LC**. It also computes the mean perceived risk between the 25th and 75th percentiles, storing these values in the respective fields (`ratings_p5`, `ratings_p25`, `ratings_p50`, `ratings_p75`, `ratings_p95`, and `ratings_p25_p75_mean`) for each scenario.

#### Key Features:
- **Percentile calculations**: The function calculates the 5th, 25th, 50th, 75th, and 95th percentiles of perceived risk ratings for all participants across four different scenarios.
- **Mean between 25th and 75th percentiles**: It also computes the mean perceived risk between the 25th and 75th percentiles for each event.

#### Inputs:
- **`SubjectiveRatings.mat`**: The file contains the subjective perceived risk ratings (`event_ratings`) for each participant in different scenarios.

#### Outputs:
- **`SubjectiveRatings.mat`**: The script updates this file by adding percentile-based risk values for each scenario. Specifically, it adds the fields `ratings_p5`, `ratings_p25`, `ratings_p50`, `ratings_p75`, `ratings_p95`, and `ratings_p25_p75_mean` for each participant.

#### Function Logic:
1. **Loading the Data**:  
   The script loads the perceived risk data from `SubjectiveRatings.mat` for the four scenarios: **MB**, **HB**, **SVM**, and **LC**.

2. **Calculating Percentiles**:  
   For each participant and event:
   - The script calculates the **5th**, **25th**, **50th**, **75th**, and **95th** percentiles of the perceived risk ratings using the `prctile` function.
   - It also computes the **mean** of ratings between the 25th and 75th percentiles using the `mean` function.

3. **Plotting the Results**:  
   After calculating the percentiles, the script generates plots for each event in the scenarios **MB**, **HB**, **SVM**, and **LC** to visualize the percentile-based risk ratings.

4. **Saving the Results**:  
   The script saves the updated percentile values to `SubjectiveRatings.mat` for future analysis.

#### Notes:
- **Percentile Calculation**: The script uses the MATLAB function `prctile` to compute the specified percentiles, providing a comprehensive view of the perceived risk distribution for each participant.
- **Plotting**: The script generates plots to visualize the different percentiles for each event in each scenario.
- **Scenarios**: The script processes data for 27 events in the **MB**, **HB**, and **SVM** scenarios, and 24 events in the **LC** scenario.
- **Saved Data**: The script updates the `SubjectiveRatings.mat` file with new percentile-based fields.

### [ReorderRatingsForSPSS.m](./SubjectiveRatings/ReorderRatingsForSPSS.m)
This MATLAB script **reorders subjective ratings by clips for SPSS analysis**, meaning that the clip number is the largest category. The variables `XX_Ratings_Clip` (where `XX` stands for the scenario) are generated as **1x5 or 1x6 cell arrays**. Each cell contains the ratings for a specific clip. These arrays can be copied and pasted into SPSS for further statistical analysis.

#### Key Features:
- **Reordering by clips**: The script organizes ratings by clip numbers, creating one cell per clip, for each event in four different scenarios: **MB**, **HB**, **SVM**, and **LC**.
- **Handling missing data**: The script accounts for events with missing or incomplete data by padding with NaN values to ensure consistency in matrix dimensions.

#### Inputs:
- **`SubjectiveRatings.mat`**: The file contains subjective ratings (`event_ratings`) for each participant in various scenarios.

#### Outputs:
- **`XX_Ratings_Clip` variables**: For each scenario, the script generates a 1x5 or 1x6 cell array where each cell corresponds to a specific clip. The generated arrays are:
  - **LC_Ratings_Clip** (1x6 cell array)
  - **SVM_Ratings_Clip** (1x5 cell array)
  - **HB_Ratings_Clip** (1x5 cell array)
  - **MB_Ratings_Clip** (1x5 cell array)
- Each cell can then be exported to SPSS for further analysis.

#### Function Logic:
1. **Loading the Data**:  
   The script loads the `SubjectiveRatings.mat` file, which contains the subjective perceived risk ratings for the four scenarios: **LC**, **SVM**, **HB**, and **MB**.

2. **Processing Each Scenario**:
   - The script iterates through each event for each scenario.
   - For each event, it extracts the ratings corresponding to different clips (5 or 6 clips depending on the scenario).
   - Ratings are re-ordered by clip, and missing data is handled by padding the arrays with `NaN` values to ensure all arrays have the same length.
   
3. **Generating Cell Arrays**:  
   - For each scenario, the script generates a 1x5 or 1x6 cell array where each cell contains the ratings for a specific clip. The cells are populated with ratings from each event, padded where necessary.

4. **Exporting Data**:  
   - After reordering the ratings, the cell arrays can be copied and pasted into SPSS for further analysis. The arrays `LC_Ratings_Clip`, `SVM_Ratings_Clip`, `HB_Ratings_Clip`, and `MB_Ratings_Clip` hold the reordered ratings for each respective scenario.

#### Example Workflow:

```matlab
% Extract and process the LC scenario
LC_Ratings_Clip_Cell=cell(1,6);
for i=1:6
    LC_Ratings_Clip_Cell{i}=cell(1,24);
end

% Iterate through events in the LC scenario
for i=1:24
    event=LC_PR(i).event_ratings;
    idx=find(sum(event,2)); % Find non-zero rows (non-empty ratings)
    if isempty(idx)
        continue;
    else
        for j=1:length(idx)
            ClipRating(end+1,1:6)=event(idx(j),:)';
        end
        for k=1:6
            LC_Ratings_Clip_Cell{k}{i}=ClipRating(:,k);
        end
    end
end

% Final matrix reordering for SPSS
LC_Ratings_Clip=cell(1,6);
for i=1:6
    for j=1:24
        clip_rating_temp=LC_Ratings_Clip_Cell{1,i}{1,j};
        clip_rating_temp(end+1:len0)=NaN; % Pad with NaN for missing data
        LC_Ratings_Clip{1,i}(:,end+1)=clip_rating_temp;
    end
end
```
### [./SubjectiveRatings/functionLibrary/](,/functionLibrary/)
#### [chckxy.m](./functionLibrary/chckxy.m)

This function **`chckxy.m`** is used to validate and adjust the input for spline, piecewise cubic Hermite interpolating polynomial (PCHIP), and modified Akima interpolation (MAKIMA). The function ensures that the data sites (`X`) and corresponding data values (`Y`) are consistent and correctly formatted for interpolation. *Copyright 1984-2021 The MathWorks, Inc.*

#### Key Features:
- **Input Validation**: The function checks if the data points `X` and `Y` are correctly formatted, ensuring that:
  - `X` is a strictly increasing row vector (reordered if necessary).
  - There is no repetition of data sites in `X`.
  - No data sites or values contain NaN values (removes them if necessary).
- **Data Reshaping**: Adjusts the shape of `Y` to match the dimensions required by PCHIP and MAKIMA interpolators.
- **End Slopes**: If there are more data values than data sites, the function interprets the extra values as end slopes, which are used for splines.

#### Inputs:
- **`X`**: A vector of data sites.
- **`Y`**: Corresponding data values, which can be a matrix if there are multiple values for each data site.

#### Outputs:
- **`X`**: The cleaned and reordered vector of data sites.
- **`Y`**: The adjusted matrix of data values corresponding to `X`.
- **`sizey`**: The original dimensions of `Y`.
- **`endslopes`** (optional): If provided, this output contains the slopes at the endpoints if the number of data values exceeds the number of data sites.

#### Function Logic:
1. **Initial Checks**: The function first ensures that both `X` and `Y` are floating-point numbers and that `X` is a real vector with at least two elements.
2. **Handling NaN Values**: Any NaN values in `X` or `Y` are removed, with a warning issued if necessary.
3. **Sorting Data Sites**: If `X` is not already in strictly increasing order, the function sorts it and reorders `Y` accordingly.
4. **Reshaping Data**: `Y` is reshaped to ensure it has the correct dimensions, with `Y(:,j)` representing the data value corresponding to the data site `X(j)`.
5. **End Slopes**: If the number of data values is greater than the number of data sites, the first and last data values are extracted as end slopes.
6. **NaN Handling in `Y`**: If there are any remaining NaN values in `Y`, they are removed along with the corresponding entries in `X`.

#### Example Usage:
```matlab
[x, y, sizey, endslopes] = chckxy(X, Y);
```

#### [pchipNew.m](./functionLibrary/pchipNew.m)

This function **`pchipNew.m`** implements a modified version of the Piecewise Cubic Hermite Interpolating Polynomial (PCHIP) algorithm. It ensures that the interpolation is monotonic and smooth between the given data points, while also calculating slopes that adapt based on the data's characteristics.

#### Key Features:
- **Input Adjustment**: It first adjusts the input data using `chckxy.m` to ensure that the data sites (`x`) and values (`y`) are consistent.
- **Slope Calculation**: Computes the slopes at each data site using a modified algorithm that ensures the interpolated curve is monotonic where needed.
- **Real and Complex Data Handling**: The function handles both real and complex data, calculating slopes separately for the real and imaginary components when necessary.
- **Custom Slopes**: The function uses a custom routine, `modifiedPchipSlopes`, to compute slopes that help control the shape of the interpolated curve.

#### Inputs:
- **`x`**: A vector of data sites.
- **`y`**: Corresponding data values. This can be real or complex data.
- **`xq`** (optional): Query points at which the interpolated values are computed. If provided, the function evaluates the interpolant at these points.

#### Outputs:
- **`yq`**: The values of the piecewise cubic Hermite interpolant at the query points `xq`. If `xq` is not provided, the function returns the coefficients of the interpolant.

#### Function Logic:
1. **Data Check**: The function first adjusts the input data using `chckxy.m` to ensure that `x` and `y` are consistent, without repeated values or NaNs.
2. **Slope Calculation**: 
   - Differences (`h`) between consecutive data points are calculated.
   - Slopes (`delta`) between consecutive data points are computed using these differences.
   - The function computes the slopes at each data point using `modifiedPchipSlopes`, ensuring that the interpolated curve behaves smoothly.
   - For complex data, slopes are computed separately for the real and imaginary parts.
3. **Interpolation**: A piecewise cubic Hermite interpolant is constructed for the input data using these slopes, and if `xq` is provided, the function evaluates the interpolant at the query points.
4. **Modified Slopes**: The `modifiedPchipSlopes` function ensures that the slopes adapt based on the data, producing zero slopes where necessary to maintain monotonicity.

#### Helper Function: `modifiedPchipSlopes`
- **Purpose**: Calculates the slopes at each data point using a modification of the PCHIP algorithm. It ensures that the interpolant is monotonic and prevents overshooting by adjusting the slopes between data points.
- **Logic**:
  - The slopes at the endpoints are explicitly set to zero.
  - For the remaining points, the slopes are computed based on the difference between consecutive data points (`h`) and their corresponding delta values.
  - If the signs of consecutive slopes are the same, a weighted average of the slopes is computed; otherwise, the slope is set to zero to ensure monotonicity.

#### Example Usage:
```matlab
% Interpolate at query points xq
yq = pchipNew(x, y, xq);
```
#### Notes:
- **Monotonicity**: This function ensures that the interpolated values maintain the monotonicity of the data, making it suitable for data that should not exhibit overhooting between points.
- **Complex Data Handling**: The fucntion handles both real and complex data, ensuring appropriate slope calculations for each component of the curve.

### [SubjectiveRatings_raw.mat](./SubjectiveRatings/SubjectiveRatings_raw.mat)
This data file **`SubjectiveRatings_raw.mat`** contains the raw perceived risk ratings for four traffic scenarios: **HB**, **MB**, **LC**, and **SVM**. It is structured into four key struct arrays (`HB_PR`, `MB_PR`, `LC_PR`, `SVM_PR`), each representing a specific scenario, and contains the unprocessed, unfiltered ratings from participants.

#### Structure:
- **HB_PR**: 1x27 struct array
- **MB_PR**: 1x27 struct array
- **LC_PR**: 1x24 struct array
- **SVM_PR**: 1x27 struct array

Each of these arrays includes the following fields for each event:
- **event_ratings**: A matrix of dimensions `n x 5` (or `n x 6` for LC), where `n` is the number of participants who provided ratings for that event. The columns represent the subjective perceived risk ratings at different moments during the traffic interaction.
  - For **LC** (Lane Change scenario), the matrix has 6 columns to reflect six rating points.
  - For the **HB**, **MB**, and **SVM** scenarios, the matrix has 5 columns to reflect five rating points.
  
- **idx**: A column vector of dimensions `n x 1` indicating the participant number associated with the corresponding rows in `event_ratings`. This provides a mapping of ratings to specific participants.

#### Field Descriptions:
- **`event_ratings`**: 
  - This contains the raw, unprocessed perceived risk ratings provided by participants for each traffic event. These ratings are provided in a time-discrete format, without any filtering or selection.
  - For the **LC** scenario, there are 6 distinct rating points per event, while for the **HB**, **MB**, and **SVM** scenarios, there are 5 rating points per event.

- **`idx`**: 
  - This field links each row in the `event_ratings` matrix to a specific participant by providing their participant number (`n x 1` vector). It allows for further analysis or filtering based on participant-specific data.

#### Example:
In each scenario (e.g., **HB_PR**):
```matlab
HB_PR(nn).event_ratings    % n x 5 matrix of perceived risk ratings for event nn
HB_PR(nn).idx              % n x 1 vector of participant numbers for event nn
```

