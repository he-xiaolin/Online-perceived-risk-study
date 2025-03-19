# Function explanations in Fig2a-c_ExtFig3a-c_g-i_m-o
This folder contains necessary code and data to generate Fig. 2a and Extended Data Fig. 2a-c, g-i and m-o. It contains MATLAB scripts for analysing the influence of controlled parameters on perceived risk ratings across different scenarios (**HB**, **LC**, **MB**, and **SVM**). The results are presented in a series of grouped boxplots to show the statistical significance of various parameters. Additionally, the folder contains an Origin project file for visualising the significance of these comparisons.
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
## [ClipAnalysis_HB.m](./ClipAnalysis_HB.m)
This MATLAB script performs an analysis of perceived risk ratings in the **HB** scenario regarding different controlled parameters **cruising speed**, **braking intensity**, and **distance**. The script generates boxplots to visualise the influence of these parameters on perceived risk across multiple clips.
### Key Analyses:

1. **Speed Analysis (80, 100, 120 km/h)**:
   - This section analyses the impact of different cruising speed of **80**, **100**, and **120 km/h** on perceived risk ratings. The perceived risk ratings for each group and clip are compared and visualised using boxplots.

   - **Code Breakdown**:
     - `v_80`, `v_100`, and `v_120`: Arrays storing perceived risk ratings for events grouped by vehicle cruising speed.
     - The `boxplotGroup` function is used to create boxplots for each speed group, comparing the perceived risk ratings across different clips.

2. **Braking Intensity Analysis (-2, -5, -8 m/s²)**:
   - This section analyses the impact of different braking intensities of **-2**, **-5**, and **-8 m/s²** on perceived risk ratings. The perceived risk ratings for each group and clip are compared and visualised using boxplots.

   - **Code Breakdown**:
     - `BI_2`, `BI_5`, and `BI_8`: Arrays storing perceived risk ratings for braking intensities of **-2**, **-5**, and **-8 m/s²**.
     - The `boxplotGroup` function is used to create boxplots for each braking intensity group, comparing the perceived risk ratings across different clips.

3. **Distance Analysis (5, 15, 25 m)**:
   - This section analyses the impact of vehicle-to-vehicle distance (**5**, **15**, and **25 m**) on perceived risk ratings. The perceived risk ratings for each group and clip are compared and visualised using boxplots.

   - **Code Breakdown**:
     - `d_5`, `d_15`, and `d_25`: Arrays storing perceived risk ratings for distances of **5**, **15**, and **25 m**.
     - The `boxplotGroup` function is used to create boxplots for each distance group, comparing the perceived risk ratings across different clips.

### Helper Functions:
- **boxplotGroup**: Used to generate grouped boxplots for the various control parameters, providing a compact and informative visualization of the data.
- **Data Handling**: The script preallocates matrices to hold the ratings data, ensures alignment between different groups, and handles missing data points by filling them with `NaN` values where necessary.

### Outputs:
- The script generates multiple figures showing boxplots of perceived risk ratings across clips for each controlled parameter (**cruising speed**, **braking intensity**, and **distance**). These visualisations help to illustrate the variation in perceived risk across different test conditions.

## [ClipAnalysis_LC.m](./ClipAnalysis_LC.m)

This MATLAB script performs an analysis of perceived risk ratings in the **LC** scenario, focusing on different controlled parameters such as **lateral behaviour**, **ACC categories**, and **lane changing distance**. The script generates boxplots to visualise the influence of these parameters on perceived risk across multiple clips.

### Key Analyses:

1. **Lateral Behaviour Analysis (1 m/s, 3 m/s, Fragmented, Aborted)**:
   - This section analyses the perceived risk ratings for lane change events with different neighbouring vehicles' lateral behaviour of **normal lane change with lateral speed 1 m/s**, **normal lane change with lateral speed 3 m/s**, **fragmented lane change with lateral speed 1 m/s**, and **aborted lane change with lateral speed 1 m/s**. The perceived risk ratings are compared and visualised using boxplots.

   - **Code Breakdown**:
     - `LC_c`, `LC_m`, `LC_f`, and `LC_a`: Arrays storing perceived risk ratings for the four lateral control categories.
     - The `boxplotGroup` function is used to create boxplots comparing the perceived risk ratings across these categories.
2. **ACC Categories Analysis (Normal Lane Change)**:
   - This section evaluates perceived risk ratings for ACC categories in normal lane change conditions, categorised into **Cautious**, **Mild**, and **Aggressive** styles.

   - **Code Breakdown**:
     - `LC_c`, `LC_m`, and `LC_a`: Arrays storing perceived risk ratings for **Cautious**, **Mild**, and **Aggressive** categories in normal conditions.
     - Boxplots are generated for each ACC category using `boxplotGroup`.

3. **ACC Categories Analysis (Fragmented Lane Change)**:
   - This section evaluates the influence of ACC categories on perceived risk in fragmented lane change events, comparing **Cautious**, **Mild**, and **Aggressive** categories.

   - **Code Breakdown**:
     - `LC_c`, `LC_m`, and `LC_a`: Arrays storing perceived risk ratings for the fragmented driving scenario.
     - Boxplots are created to compare perceived risk across these categories.

4. **ACC Categories Analysis (Aborted Lane Change)**:
   - Similar to the fragmented analysis, this section focuses on aborted lane changes for **Cautious**, **Mild**, and **Aggressive** driving styles.

   - **Code Breakdown**:
     - `LC_c`, `LC_m`, and `LC_a`: Arrays storing perceived risk ratings for aborted driving scenarios.
     - Boxplots are used to visualise and compare the perceived risk ratings across different ACC categories.

5. **Distance Analysis (Normal Lane Change)**:
   - The influence of the merging distance of neighbouring vehicle (e.g., **5 m** vs **15 m**) on perceived risk ratings is analysed for normal lane change events.

   - **Code Breakdown**:
     - `LC_c` and `LC_m`: Arrays storing perceived risk ratings for **5 m** and **15 m** distances.
     - Boxplots are generated to visualise the impact of distance on perceived risk.

6. **Distance Analysis (Fragmented Lange Change)**:
   - This section analyses the impact of the merging distance of the neighbouring vehicle of **5 m** and **15 m** on perceived risk in fragmented lane change events.

   - **Code Breakdown**:
     - `LC_c` and `LC_m`: Arrays storing perceived risk ratings for fragmented driving with different distances.
     - The `boxplotGroup` function is used to create the corresponding boxplots.

7. **Distance Analysis (Aborted Lane Change)**:
   - This section analyses the impact of the merging distance of the neighbouring vehicle of **5 m** and **15 m** on perceived risk in aborted lane change events.

   - **Code Breakdown**:
     - `LC_c` and `LC_m`: Arrays storing perceived risk ratings for aborted driving with different distances.
     - Boxplots are generated to compare perceived risk across these distance groups.

### Helper Functions:
- **boxplotGroup**: Used to generate grouped boxplots for the various control parameters, providing a compact and informative visualization of the data.
- **Data Handling**: The script preallocates matrices to hold the ratings data, ensures alignment between different groups, and handles missing data points by filling them with `NaN` values where necessary.

### Outputs:
- The script generates multiple figures showing boxplots of perceived risk ratings across clips for each control parameter (lateral control, ACC categories, and distance). These visualizations help to illustrate the variation in perceived risk across different test conditions.

## [ClipAnalysis_MB.m](./ClipAnalysis_MB.m)

This MATLAB script performs an analysis of perceived risk ratings for the **MB** scenario, focusing on various controlled parameters such as **cruising speed**, **braking intensity**, and **merging distance**. The script generates boxplots to visualise the influence of these parameters on perceived risk ratings across multiple clips.

### Key Analyses:

1. **Speed Analysis (80 km/h, 100 km/h, 120 km/h)**:
   - The script evaluates perceived risk ratings for clips where the vehicle speed is either **80 km/h**, **100 km/h**, or **120 km/h**. The ratings are compared and visualised using boxplots.

   - **Code Breakdown**:
     - `v_80`, `v_100`, and `v_120`: Arrays storing perceived risk ratings for speed categories.
     - The `boxplotGroup` function is used to create grouped boxplots comparing perceived risk ratings at different speeds.

   - **Matrix Construction**:
     - The script preallocates a matrix to store perceived risk data for all three speed categories, ensuring that data with different lengths are aligned for plotting and further analysis.

2. **Braking Intensity Analysis (-2, -5, -8 m/s²)**:
   - This section examines perceived risk ratings for different **braking intensities**: **-2 m/s²**, **-5 m/s²**, and **-8 m/s²**. Each braking intensity is analysed based on multiple clips, and the results are visualised using boxplots.

   - **Code Breakdown**:
     - `BI_2`, `BI_5`, and `BI_8`: Arrays storing perceived risk ratings for different braking intensities.
     - The `boxplotGroup` function generates boxplots for each braking intensity.

   - **Matrix Construction**:
     - A matrix is preallocated to hold the perceived risk ratings for all three braking intensity categories, with columns representing different clips.

3. **Distance Analysis (5 m, 15 m, 25 m)**:
   - This section analysis the influence of the merging **distance** of the neighbouring vehicle on perceived risk ratings. The distances analysed are **5 m**, **15 m**, and **25 m**. The ratings are compared across different clips and visualised using boxplots.

   - **Code Breakdown**:
     - `d_5`, `d_15`, and `d_25`: Arrays storing perceived risk ratings for the different distance categories.
     - Boxplots are generated using the `boxplotGroup` function to visualise the differences in perceived risk at different distances.

   - **Matrix Construction**:
     - The script constructs a matrix to store the ratings for all three distance categories, ensuring the correct alignment of data across clips.

### Helper Functions:
- **boxplotGroup**: This function is used throughout the script to generate grouped boxplots that compare perceived risk ratings across different categories, such as speed, braking intensity, and distance.

### Outputs:
- The script generates multiple figures with grouped boxplots showing the variation in perceived risk across clips for each control parameter (speed, braking intensity, and distance). These visualizations help highlight how each factor influences perceived risk in the **MB** scenario.

## [ClipAnalysis_SVM.m](./ClipAnalysis_SVM.m)

This MATLAB script performs an analysis of perceived risk ratings for the **SVM** scenario, focusing on controlled parameters such as **cruising speed**, **braking intensity**, and **distance**. The script generates boxplots to visualise the influence of these factors on perceived risk across multiple clips.

### Key Analyses:

1. **Speed Analysis (80 km/h, 100 km/h, 120 km/h)**:
   - This section examines the perceived risk ratings for different speeds: **80 km/h**, **100 km/h**, and **120 km/h**. The ratings are analysed for each speed group and compare and visualised using boxplots.

   - **Code Breakdown**:
     - `v_80`, `v_100`, and `v_120`: Arrays storing the perceived risk ratings for the three speed categories.
     - The `boxplotGroup` function generates grouped boxplots for each speed category.
   
   - **Matrix Construction**:
     - A new matrix is created to align and store the perceived risk ratings for all three speed categories, ensuring that data from different lengths are aligned for plotting and analysis.

2. **Braking Intensity Analysis (-2, -5, -8 m/s²)**:
   - This section evaluates the effect of different **braking intensities**: **-2 m/s²**, **-5 m/s²**, and **-8 m/s²** on perceived risk. The analysis is performed on multiple clips, and boxplots are generated to compare the ratings for each braking intensity.

   - **Code Breakdown**:
     - `BI_2`, `BI_5`, and `BI_8`: Arrays storing the perceived risk ratings for the three braking intensities.
     - The `boxplotGroup` function generates boxplots for each braking intensity category.
   
   - **Matrix Construction**:
     - The script preallocates a matrix with `NaN` values to hold the ratings for each braking intensity. Data are then aligned across clips.

3. **Distance Analysis (5 m, 15 m, 25 m)**:
   - This section focuses on **distance** as a control parameter, evaluating the perceived risk ratings at different vehicle-to-vehicle distances: **5 m**, **15 m**, and **25 m**. These ratings are compared and visualised using boxplots.

   - **Code Breakdown**:
     - `d_5`, `d_15`, and `d_25`: Arrays storing perceived risk ratings for the three distance categories.
     - The `boxplotGroup` function generates boxplots for each distance group.
   
   - **Matrix Construction**:
     - A matrix is preallocated and filled with perceived risk ratings for each distance category. This matrix ensures that data are properly aligned for comparison across clips.

### Helper Functions:
- **boxplotGroup**: Used throughout the script to generate grouped boxplots for the comparison of perceived risk ratings based on speed, braking intensity, and distance.

### Outputs:
- The script generates multiple figures with grouped boxplots comparing perceived risk ratings across clips for different control parameters, providing insight into how factors like speed, braking intensity, and distance affect perceived risk in the **SVM** scenario.

## [GroupedBoxplot_Functions](./GroupedBoxplot_Functions/)
### [boxplotGroup.m](./GroupedBoxplot_Functions/boxplotGroup.m)

The `boxplotGroup` function in MATLAB is designed to group boxplots together with adjustable horizontal space between groups. It allows users to customise and visualise groups of boxplots effectively by assigning primary and secondary labels, colors, and adding group lines between categories.

#### Purpose:
The function is primarily used to produce grouped boxplots from a set of matrices, where each matrix represents a group of boxplots. It offers the flexibility to adjust the spacing between groups, customise labels, and even add group dividers for enhanced clarity. This function is often used for visualizing data comparisons across multiple categories, making it useful for statistical analysis.

#### Input Parameters:
1. **x**: A 1xM cell array, where each element is a matrix containing data for N columns (boxplot groups). Each matrix represents a member within the group, and this input is mandatory.
2. **ax (Optional)**: An axis handle to specify the target axis. If not provided, the current axis is used.
3. **interGroupSpace (Optional)**: A scalar value that determines the horizontal space between boxplot groups. Default is `1`.
4. **groupLines (Optional)**: A boolean flag indicating whether vertical divider lines between groups should be added. Defaults to `false`.
5. **primaryLabels (Optional)**: A string or cell array specifying the x-axis tick labels for each boxplot. It must contain either one label per boxplot or one label per group member.
6. **secondaryLabels (Optional)**: A string or cell array specifying group labels for the boxplot groups.
7. **groupLabelType (Optional)**: Specifies how group labels are shown. Options include:
   - `'horizontal'`: Labels centered under the primary labels.
   - `'vertical'`: Vertical group labels placed between groups (requires MATLAB R2018b or later).
   - `'both'`: Uses both horizontal and vertical group labels.
8. **GroupType (Optional)**: Determines how colors are applied to the groups. Options include:
   - `'betweenGroups'`: Colors are applied to the boxes within each group (default).
   - `'withinGroups'`: Colors are applied across groups.
9. **Additional boxplot() parameters**: Any additional parameters accepted by the MATLAB `boxplot()` function (e.g., `BoxStyle`, `Colors`, `PlotStyle`, etc.) can also be passed in.

#### Output:
- **pValues**: A matrix containing p-values from statistical comparisons (ANOVA) performed between the boxplots within each group.

#### Main Functionalities:
1. **Grouped Boxplots**:
   - The function takes multiple matrices and produces grouped boxplots for each matrix. The number of groups is determined by the number of columns in each matrix, and the number of boxes per group is determined by the number of matrices (members).
   - The user can define primary and secondary labels for each group and customise the colors of the boxplots.

2. **Horizontal Spacing and Grouping**:
   - The horizontal spacing between groups of boxplots can be adjusted using the `interGroupSpace` parameter.
   - The function can draw group lines to separate different groups visually.

3. **Statistical Comparison (ANOVA)**:
   - The function performs statistical comparisons between boxplots within each group using the **two-sample t-test** and returns the p-values. It also marks significant differences using asterisks above the boxplots based on the significance level:
     - p ≤ 0.001: Three asterisks (***).
     - p ≤ 0.01: Two asterisks (**).
     - p ≤ 0.05: One asterisk (*).

4. **Labeling**:
   - The user can specify **primary labels** for each boxplot and **secondary labels** for the groups. The group labels can be displayed either horizontally, vertically, or both, depending on the `groupLabelType` parameter.
   - If no labels are provided, the function defaults to automatic x-axis tick

5. **Color customisation**:
   - Users can customise the color scheme of the boxplots using the `Colors` parameter. The function supports multiple colors, which can be applied either within groups or across groups, depending on the `GroupType`.

6. **Placeholder Removal**:
   - After plotting the boxplots, the function removes any dummy boxplot placeholders to ensure that only meaningful data is displayed.

#### Example Usage:
   ```matlab
   data = {rand(100,4), rand(20,4)*0.8, rand(1000,4)*1.2};
   boxplotGroup(data);
   ```
## [Significance_boxplot.opju](./Significance_boxplot.opju)

The file `Significance_boxplot.opju` is an **OriginLab project file** that generates Fig. 2a-c and Extended Data Fig. 3a-c, g-i, and m-o.

In this project, the boxplots represent different experimental or observational groups, with the following features:
- **Grouped Boxplots**: Each group contains multiple boxplots, corresponding to different data conditions.
- **Significance Markings**: Asterisks (*) are used to denote statistically significant differences between groups, with varying levels of significance (e.g., *p* ≤ 0.05, *p* ≤ 0.01, *p* ≤ 0.001).
- **Customizable Visuals**: Origin allows users to customize plot features such as colors, axis labels, and legend, providing a clear comparison of the groups.
