# Data explanations

This folder contains subjective perceived risk data `SubjectiveRatings.mat` and corresponding kinematic data `KinematicData.mat` of simulations for analysis, and Excel workbook per scenario (`HB.xlsx`, `LC.xlsx`, `MB.xlsx`, `SVM.xlsx`) in the `SubjectiveRatings_clip/` folder. 
## Data Structure of the .mat Files
- `SubjectiveRatings.mat` contains four structure variables `MB_PR`, `HB_PR`, `SVM_PR`, and `LC_PR` (1 x 27 or 24 struct) for four scenarios *MB*, *HB*, *LC*, and *SVM*. Each of them contains the following fields:

    | Field Name               | Description                                                                                   |
    |--------------------------|-----------------------------------------------------------------------------------------------|
    | `event_ratings`           | The discrete subjective perceived risk ratings after selection. (n x 5 or 6)                  |
    | `idx`                     | The participant number associated with the discrete perceived risk ratings. (n x 1)           |
    | `ratings_p5`              | The discrete perceived risk ratings at the 5th percentile. (1 x 5 or 6)                       |
    | `ratings_p25`             | The discrete perceived risk ratings at the 25th percentile. (1 x 5 or 6)                      |
    | `ratings_p50`             | The discrete perceived risk ratings at the 50th percentile (median). (1 x 5 or 6)             |
    | `ratings_p75`             | The discrete perceived risk ratings at the 75th percentile. (1 x 5 or 6)                      |
    | `ratings_p95`             | The discrete perceived risk ratings at the 95th percentile. (1 x 5 or 6)                      |
    | `ratings_p25_p75_mean`    | The mean of discrete perceived risk ratings between the 25th and 75th percentiles. (1 x 5 or 6)|
    | `ratingTiming`            | Timing of when the ratings were made. (1 x 8 or 9)                                            |
    | `Time`                    | Timing array for 30 s or 36 s at 10Hz. (1 x 301 or 1 x 361)                                   |
    | `risk_p5`                 | Continuous perceived risk at the 5th percentile. (1 x 301 or 1 x 361)                         |
    | `risk_p25`                | Continuous perceived risk at the 25th percentile. (1 x 301 or 1 x 361)                        |
    | `risk_p50`                | Continuous perceived risk at the 50th percentile (median).                                     |
    | `risk_p75`                | Continuous perceived risk at the 75th percentile. (1 x 301 or 1 x 361)                        |
    | `risk_p95`                | Continuous perceived risk at the 95th percentile. (1 x 301 or 1 x 361)                        |
    | `risk_p25_p75_mean`       | Continuous perceived risk at the mean between the 25th and 75th percentiles.                  |
    | `risk`                    | Continuous perceived risk for all participants. (n x 301 or 361)                              |
    | `IQR`                     | Interquartile range for the continuous perceived risk. (5 x 301 or 361 with rows: Q1-1.5IQR, Q1, median, Q3, Q3+1.5IQR) |
    | `AU`                      | Aleatoric uncertainty of the continuous perceived risk. (1 x 301 or 361)                      |
    
- `KinematicData.mat` contains the corresponding kinematic data of the events for the four scenarios `MB`, `HB`, `LC`, and `SVM` (1 x 27 or 24 struct). It contains the following fields: 

    | Field Name  | Description*                                                                                         |
    |-------------|-----------------------------------------------------------------------------------------------------|
    | `x_s`       | The x-coordinate of the subject vehicle. (1 x 301 or 361)                                            |
    | `x_n`       | The x-coordinate of the neighboring vehicle. (1 x 301 or 361)                                        |
    | `vx_s`      | The velocity in the x-direction of the subject vehicle. (1 x 301 or 361)                             |
    | `vx_n`      | The velocity in the x-direction of the neighboring vehicle. (1 x 301 or 361)                         |
    | `ax_s`      | The acceleration in the x-direction of the subject vehicle. (1 x 301 or 361)                         |
    | `ax_n`      | The acceleration in the x-direction of the neighboring vehicle. (1 x 301 or 361)                     |
    | `y_s`       | The y-coordinate of the subject vehicle. (1 x 301 or 361)                                            |
    | `y_n`       | The y-coordinate of the neighboring vehicle. (1 x 301 or 361)                                        |
    | `vy_s`      | The velocity in the y-direction of the subject vehicle. (1 x 301 or 361)                             |
    | `vy_n`      | The velocity in the y-direction of the neighboring vehicle. (1 x 301 or 361)                         |
    | `ay_s`      | The acceleration in the y-direction of the subject vehicle. (1 x 301 or 361)                         |
    | `ay_n`      | The acceleration in the y-direction of the neighboring vehicle. (1 x 301 or 361)                     |
    | `delta_x`   | The difference in x-coordinate between the subject and neighboring vehicles (x_n - x_s). (n x 301 or 361)        |
    | `delta_y`   | The difference in y-coordinate between the subject and neighboring vehicles (y_n - y_s). (n x 301 or 361)        |
    | `Time`      | Timing array for 30 s or 36 s at 10Hz. (1 x 301 or 1 x 361)                                          |
    | `v_In_x`    | The x-component of the uncertain velocity of the neighbouring vehicle. (1 x 301 or 361)  |
    | `v_In_y`    | The y-component of the uncertain velocity of the neighbouring vehicle. (1 x 301 or 361)  |
    | `v_Is_x`    | The x-component of the uncertain velocity of the subject vehicle. (1 x 301 or 361)            |
    | `v_Is_y`    | The y-component of the uncertain velocity of the subject vehicle. (1 x 301 or 361)            |
    | `DRAC_Rx`   | Acceleration rate to avoid a collision in the x-direction (caused by the real velocity). (1 x 301 or 361)         |
    | `DRAC_Ix`   | Acceleration rate to avoid a collision in the x-directio (caused by the uncertain velocity). (1 x 301 or 361)       |
    | `DRAC_Ry`   | Acceleration rate to avoid a collsiion in the y-direction (caused by the real velocity). (1 x 301 or 361)          |
    | `DRAC_Iy`   | Acceleration rate to avoid a collision in the y-direction (caused by the uncertain velocity). (1 x 301 or 361)      |
    | `DRAC_R`    | Overall acceleration rate to avoid a collision (caused by the real velocity). (1 x 301 or 361)                  |
    | `DRAC_I`    | Overall acceleration rate to avoid a collision (caused by the uncertain velocity). (1 x 301 or 361)     |
    | `delta_vx`  | Velocity difference in the x-direction between the subject and neighbouring vehicles. (1 x 301 or 361)|
    | `delta_vy`  | Velocity difference in the y-direction between the subject and neighbouring vehicles. (1 x 301 or 361)|
    | `delta_ax`  | Acceleration difference in the x-direction between the subject and neighbouring vehicles. (1 x 301 or 361)|
    | `delta_ay`  | Acceleration difference in the y-direction between the subject and neighbouring vehicles. (1 x 301 or 361)|
    
    *Forward and left are the positive directions.
    
    Structure `SVM` contains extra fields for the neighouring vehicle behind as follows
  
  | Field Name  | Description                                                                                         |
  |-------------|-----------------------------------------------------------------------------------------------------|
  | `x_n2`      | The x-coordinate of the second neighbouring vehicle (vehicle behind). (1 x 301 or 361)                |
  | `vx_n2`     | The velocity in the x-direction of the second neighbouring vehicle. (1 x 301 or 361)                  |
  | `ax_n2`     | The acceleration in the x-direction of the second neighbouring vehicle. (1 x 301 or 361)              |
  | `y_n2`      | The y-coordinate of the second neighbouring vehicle. (1 x 301 or 361)                                 |
  | `vy_n2`     | The velocity in the y-direction of the second neighbouring vehicle. (1 x 301 or 361)                  |
  | `ay_n2`     | The acceleration in the y-direction of the second neighbouring vehicle. (1 x 301 or 361)              |
  | `delta_x2`  | The difference in the x-coordinate between the subject vehicle and the second neighbouring vehicle (x_n2 - x_s). (1 x 301 or 361) |
  | `delta_y2`  | The difference in the y-coordinate between the subject vehicle and the second neighbouring vehicle (y_n2 - y_s). (1 x 301 or 361) |
  | `v_In2_x`   | The x-component of the uncertain velocity of the second neighbouring vehicle. (1 x 301 or 361)        |
  | `v_In2_y`   | The y-component of the uncertain velocity of the second neighbouring vehicle. (1 x 301 or 361)        |
  | `DRAC_Rx2`  | Acceleration rate to avoid a collision in the x-direction caused by the real velocity of the second neighbouring vehicle. (1 x 301 or 361) |
  | `DRAC_Ix2`  | Acceleration rate to avoid a collision in the x-direction caused by the uncertain velocity of the second neighbouring vehicle. (1 x 301 or 361) |
  | `DRAC_Ry2`  | Acceleration rate to avoid a collision in the y-direction caused by the real velocity of the second neighbouring vehicle. (1 x 301 or 361) |
  | `DRAC_Iy2`  | Acceleration rate to avoid a collision in the y-direction caused by the uncertain velocity of the second neighbouring vehicle. (1 x 301 or 361) |
  | `DRAC_R2`   | Overall acceleration rate to avoid a collision caused by the real velocity of the second neighbouring vehicle. (1 x 301 or 361) |
  | `DRAC_I2`   | Overall acceleration rate to avoid a collision caused by the uncertain velocity of the second neighbouring vehicle. (1 x 301 or 361) |
  | `delta_vx2` | Velocity difference in the x-direction between the subject and second neighbouring vehicles. (1 x 301 or 361) |
  | `delta_vy2` | Velocity difference in the y-direction between the subject and second neighbouring vehicles. (1 x 301 or 361) |
  | `delta_ax2` | Acceleration difference in the x-direction between the subject and second neighbouring vehicles. (1 x 301 or 361) |
  | `delta_ay2` | Acceleration difference in the y-direction between the subject and second neighbouring vehicles. (1 x 301 or 361) |
  | `v_Is2_x`   | The x-component of the uncertain velocity of the subject vehicle related to the second neighbouring vehicle. (1 x 301 or 361) |
  | `v_Is2_y`   | The y-component of the uncertain velocity of the subject vehicle related to the second neighbouring vehicle. (1 x 301 or 361) |



## Data Structure of the Raw Excel Files

Each workbook is laid out as follows:

1. **One sheet per feature**  
   - For HB/MB/SVM: three sheets named  
     - `BI` (Brake Intensity)  
     - `distance` (Following Distance)  
     - `speed` (Approach Speed)  
   - For LC: three sheets named  
     - `Distance` (Lateral Distance)  
     - `Driving style` (Driving Style)  
     - `Lateral behaviour` (Lane-change Behaviour)
2. **Columns = clip × condition**  
   - Each sheet contains **N × M** columns, where:  
     - **N** = number of clips in that scenario (5 for HB/MB/SVM, 6 for LC)  
     - **M** = number of experimental levels for that feature  
       – e.g. HB-`BI` has 3 deceleration levels → 3 columns per clip  
       – LC-`Distance` has 2 distance levels → 2 columns per clip  
       – LC-`Lateral behaviour` has 4 behaviour types → 4 columns per clip  
3. **Column grouping by clip**  
   - The first M columns correspond to **Clip 1**, the next M to **Clip 2**, …  
   - In the screenshot above you can see the first block of columns (red border) is Clip 1, the next (blue) Clip 2, etc.
4. **Unequal column heights**  
   - Each column holds only the non-missing ratings for that clip/condition.  
   - Since some participants skipped or had invalid data for certain clips, columns may be shorter or longer.
5. **parameter_list.xlsx**  
   - This master sheet lists for each feature the exact number of levels (M) and their labels.  
   - Our converter script reads `parameter_list.xlsx` to build the correct loops for “clip × condition” when splitting into per-clip CSVs.
