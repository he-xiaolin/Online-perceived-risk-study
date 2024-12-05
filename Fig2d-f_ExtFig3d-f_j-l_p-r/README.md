# Function explanations in Fig2d-f_ExtFig3d-f_j-l_p-r
This folder contains necessary code and data to generate Fig. 2d-f and Extended Data Fig. 3d-f, j-l, and p-r. It contains MATLAB scripts for analysing the influence of controlled parameters on perceived risk ratings across different scenarios (**HB**, **LC**, **MB**, and **SVM**) using J-S divergence. The results are presented in a series of heatmaps to show the significance of various parameters. 
```
Fig2d-f_ExtFig3d-f_j-l_p-r/
├── HB_JS_divergence.m
├── LC_JS_divergence.m
├── MB_JS_divergence.m
├── SVM_JS_divergence.m
└── mvgkl.m
```

## [HB_JS_divergence.m](./HB_JS_divergence.m)
This MATLAB script performs an analysis of perceived risk ratings in the **HB** scenario with respect to three controlled parameters: **cruising speed**, **braking intensity**, and **distance**. The script generates visualisations of rating transitions and applies Markov modeling, Gaussian Mixture Models (GMM), and divergence measures to quantify and compare the perceived risk across multiple events.

### Key Analyses:

1. **Rating Transition Matrix and GMM Training**:
   - For each event, the script constructs a **Markov transition matrix** from the perceived risk ratings. The transition matrix describes how ratings transition between clips.
   - A **Gaussian Mixture Model (GMM)** is fitted to the rating transition data for each event.
   
   - **Code Breakdown**:
     - The `markov_matrix` is an 11 &times; 11 matrix, capturing transitions between ratings (scaled from 0 to 10).
     - The script uses the `fitgmdist` function to train a GMM on the transition data, with one component (`k = 1`).

2. **Kullback-Leibler (KL) and Jensen-Shannon (JS) Divergence Matrix Computation**:
   - The script computes the **KL divergence** between the GMMs fitted for each event. This provides a measure of the similarity between events' rating transitions.
   - A **JS divergence matrix** is calculated as a symmetrised version of the KL divergence, using the formula:  
     
     JS = 0.5 &times; (KL_1 + KL_2)
     
   - **Code Breakdown**:
     - The `mvgkl` function computes the KL divergence between two GMMs.
     - `KL_matrix_1` and `KL_matrix_2` store the directional KL divergences between all event pairs.
     - `JS_matrix` is derived as the average of the two directional KL values.

3. **Distance Analysis (5, 15, 25 m)**:
   - This section evaluates the impact of varying distances between vehicles (**5 m**, **15 m**, and **25 m**) on perceived risk ratings, based on JS divergence.
   
   - **Code Breakdown**:
     - The arrays `d_5`, `d_15`, and `d_25` represent indices of events associated with specific distances.
     - The **reordered JS matrix** is created by selecting the events associated with each distance group.
     - The script computes the mean JS divergence for each distance combination and visualises the result using a heatmap (`imagesc`).

4. **Braking Intensity Analysis (-2, -5, -8 m/s²)**:
   - This section investigates how different braking intensities (**-2**, **-5**, and **-8 m/s²**) affect perceived risk.
   
   - **Code Breakdown**:
     - Arrays `BI_2`, `BI_5`, and `BI_8` correspond to events with specific braking intensities.
     - The script calculates the mean JS divergence across these groups and generates a heatmap to visualise the results.

5. **Cruising Speed Analysis (80, 100, 120 km/h)**:
   - This section analyses the impact of different cruising speeds (**80**, **100**, and **120 km/h**) on perceived risk.
   
   - **Code Breakdown**:
     - Arrays `v_80`, `v_100`, and `v_120` represent events grouped by speed.
     - The script computes and visualises the mean JS divergence for these speeds using a heatmap.

### Helper Functions:
- **mvgkl**: This function calculates the multivariate Gaussian KL divergence between two distributions, helping to quantify the difference between event transition models.
- **Data Preprocessing**: The script handles the ratings data, calculates transition matrices, and scales data for GMM input by converting frequencies into categorical pairs.
  
### Outputs:
- **Transition Matrix Visualisations**: The script generates bar plots for the transition matrices of all 27 events, showing the probability of transitioning from one rating to another.
- **GMM and Divergence Visualisations**: It also provides contour plots of the GMMs fitted to the transition data and heatmaps illustrating JS divergence for different controlled parameters (distance, speed, and braking intensity).

### Example Visualisations:
- **Figure 1**: Transition matrix bar plots for each event, showing the rating dynamics over time.
- **Figure 2**: Contour plots of the fitted GMM for each event, illustrating the distribution of rating transitions.
- **Heatmaps**: For each controlled parameter (distance, braking intensity, speed), heatmaps of the log-transformed JS divergence are displayed, allowing for visual comparison of risk ratings under different conditions.

### Key Insights:
- **Distance**: Events with shorter vehicle-to-vehicle distances tend to show higher perceived risks.
- **Braking Intensity**: Higher braking intensities are associated with higher perceived risk.
- **Speed**: Higher speeds also lead to an increase in perceived risk.

### Dependencies:
- MATLAB's **Statistics and Machine Learning Toolbox** for GMM fitting (`fitgmdist`).
- The dataset `SubjectiveRatings.mat` which contains subjective risk rating data for 27 events.

## [LC_JS_divergence.m](./LC_JS_divergence.m)
This MATLAB script performs an analysis of perceived risk ratings in the **LC** scenario with respect to controlled parameters such as **distance**, **ACC category**, and **lateral control**. The script generates visualisations of rating transitions, applies Markov modeling, Gaussian Mixture Models (GMM), and computes divergence measures (KL, JS) to compare perceived risk across multiple events.

### Key Analyses:

1. **Rating Transition Matrix and GMM Training**:
   - For each event, the script constructs a **Markov transition matrix** from the perceived risk ratings. This matrix models how ratings transition between different clips
   - A **Gaussian Mixture Model (GMM)** is fitted to the rating transition data for each event.

   - **Code Breakdown**:
     - The `markov_matrix` is an 11 &times; 11 matrix, representing transitions between perceived risk ratings (0 to 10).
     - The `fitgmdist` function is used to fit a GMM to the transition data, with one component (`k = 1`).

2. **Kullback-Leibler (KL) and Jensen-Shannon (JS) Divergence Matrix Computation**:
   - The script computes the **KL divergence** between GMMs fitted for each event, quantifying the similarity between event transitions.
   - A **JS divergence matrix** is calculated as a symmetrised version of the KL divergence using the formula:
     
     JS = 0.5 &times; (KL_1 + KL_2)

   - **Code Breakdown**:
     - The `mvgkl` function computes the KL divergence between two GMMs.
     - `KL_matrix_1` and `KL_matrix_2` store the directional KL divergences between all event pairs.
     - The `JS_matrix` is derived as the average of the two directional KL values.

3. **Distance Analysis (5, 15, 25 m)**:
   - This section evaluates the impact of varying distances between vehicles (**5 m**, **15 m**, and **25 m**) on perceived risk, based on JS divergence.

   - **Code Breakdown**:
     - Arrays `d_5` and `d_15` represent events associated with specific distances.
     - The **reordered JS matrix** is created by selecting events corresponding to each distance group.
     - The mean JS divergence for each distance combination is computed and visualised using a heatmap.

4. **ACC Category Analysis**:
   - This section examines the effect of different acceleration categories (Cautious, Mild, Aggressive) on perceived risk, based on JS divergence.

   - **Code Breakdown**:
     - Arrays `ACC_c`, `ACC_m`, and `ACC_a` represent events grouped by acceleration categories (Cautious, Mild, Aggressive).
     - The **reordered JS matrix** is generated for these groups, and the mean JS divergence for each combination is computed and visualised using a heatmap.

5. **Lateral Behaviour of the Neighbouring Vehicle Analysis**:
   - This section analyses the impact of lateral control parameters, such as lateral speed (e.g., 1 m/s and 3 m/s) in normal lane change events and manoeuvre type (e.g., fragmented or abortion), on perceived risk ratings.

   - **Code Breakdown**:
     - Arrays `LC_1`, `LC_3`, `LC_f`, and `LC_a` represent events with specific lateral control characteristics (e.g., crusing speed or manoeuvre type).
     - The mean JS divergence for each lateral control combination is computed and visualised using a heatmap.

### Helper Functions:
- **mvgkl**: This function computes the multivariate Gaussian KL divergence between two GMM distributions, allowing the script to measure differences between event models.
- **Data Preprocessing**: The script processes event rating data, constructs transition matrices, scales the data, and prepares GMM inputs by transforming transition frequencies into categorical pairs.

### Outputs:
- **Transition Matrix Visualisations**: Bar plots of transition matrices for all 24 events, displaying the probability of transitioning from one rating to another.
- **GMM and Divergence Visualisations**: Contour plots of the GMMs fitted to each event's transition data and heatmaps of log-transformed JS divergence for different parameters (distance, acceleration, lateral control).

### Example Visualisations:
- **Figure 1**: Transition matrix bar plots for each event, displaying the dynamics of perceived risk ratings over time.
- **Figure 2**: Contour plots of the fitted GMM for each event, visualizing the distribution of transitions between ratings.
- **Heatmaps**: Heatmaps showing the JS divergence for various controlled parameters (distance, acceleration category, lateral control), allowing for visual comparisons of perceived risk.

### Key Insights:
- **Distance**: Smaller distances between vehicles (5 m) tend to correlate with higher perceived risks compared to longer distances (25 m).
- **Acceleration Category**: More aggressive acceleration behaviors correspond to higher perceived risks compared to cautious and mild categories.
- **Lateral Control**: Certain lateral maneuvers, such as fragmented or aborted maneuvers, are associated with higher perceived risks.

### Dependencies:
- MATLAB's **Statistics and Machine Learning Toolbox** for GMM fitting (`fitgmdist`).
- The dataset `SubjectiveRatings.mat` containing subjective risk rating data for 24 events.

## [MB_JS_divergence.m](./MB_JS_divergence.m)
This MATLAB script performs an analysis of perceived risk ratings in the **MB** scenario with respect to three controlled parameters: **cruising speed**, **braking intensity**, and **initial merging distance**. The script generates visualisations of rating transitions and applies Markov modeling, Gaussian Mixture Models (GMM), and divergence measures to quantify and compare the perceived risk across multiple events.

### Key Analyses:

1. **Rating Transition Matrix and GMM Training**:
   - For each event, the script constructs a **Markov transition matrix** from the perceived risk ratings. The transition matrix describes how ratings transition between clips.
   - A **Gaussian Mixture Model (GMM)** is fitted to the rating transition data for each event.
   
   - **Code Breakdown**:
     - The `markov_matrix` is an 11 &times; 11 matrix, capturing transitions between ratings (scaled from 0 to 10).
     - The script uses the `fitgmdist` function to train a GMM on the transition data, with one component (`k = 1`).

2. **Kullback-Leibler (KL) and Jensen-Shannon (JS) Divergence Matrix Computation**:
   - The script computes the **KL divergence** between the GMMs fitted for each event. This provides a measure of the similarity between events' rating transitions.
   - A **JS divergence matrix** is calculated as a symmetrised version of the KL divergence, using the formula:  
     
     JS = 0.5 &times; (KL_1 + KL_2)
     
   - **Code Breakdown**:
     - The `mvgkl` function computes the KL divergence between two GMMs.
     - `KL_matrix_1` and `KL_matrix_2` store the directional KL divergences between all event pairs.
     - `JS_matrix` is derived as the average of the two directional KL values.

3. **Distance Analysis (5, 15, 25 m)**:
   - This section evaluates the impact of varying distances between vehicles (**5 m**, **15 m**, and **25 m**) on perceived risk ratings, based on JS divergence.
   
   - **Code Breakdown**:
     - The arrays `d_5`, `d_15`, and `d_25` represent indices of events associated with specific distances.
     - The **reordered JS matrix** is created by selecting the events associated with each distance group.
     - The script computes the mean JS divergence for each distance combination and visualises the result using a heatmap (`imagesc`).

4. **Braking Intensity Analysis (-2, -5, -8 m/s²)**:
   - This section investigates how different braking intensities (**-2**, **-5**, and **-8 m/s²**) affect perceived risk.
   
   - **Code Breakdown**:
     - Arrays `BI_2`, `BI_5`, and `BI_8` correspond to events with specific braking intensities.
     - The script calculates the mean JS divergence across these groups and generates a heatmap to visualise the results.

5. **Cruising Speed Analysis (80, 100, 120 km/h)**:
   - This section analyses the impact of different cruising speeds (**80**, **100**, and **120 km/h**) on perceived risk.
   
   - **Code Breakdown**:
     - Arrays `v_80`, `v_100`, and `v_120` represent events grouped by speed.
     - The script computes and visualises the mean JS divergence for these speeds using a heatmap.

### Helper Functions:
- **mvgkl**: This function calculates the multivariate Gaussian KL divergence between two distributions, helping to quantify the difference between event transition models.
- **Data Preprocessing**: The script handles the ratings data, calculates transition matrices, and scales data for GMM input by converting frequencies into categorical pairs.
  
### Outputs:
- **Transition Matrix Visualisations**: The script generates bar plots for the transition matrices of all 27 events, showing the probability of transitioning from one rating to another.
- **GMM and Divergence Visualisations**: It also provides contour plots of the GMMs fitted to the transition data and heatmaps illustrating JS divergence for different controlled parameters (distance, speed, and braking intensity).

### Example Visualisations:
- **Figure 1**: Transition matrix bar plots for each event, showing the rating dynamics over time.
- **Figure 2**: Contour plots of the fitted GMM for each event, illustrating the distribution of rating transitions.
- **Heatmaps**: For each controlled parameter (distance, braking intensity, speed), heatmaps of the log-transformed JS divergence are displayed, allowing for visual comparison of risk ratings under different conditions.

### Key Insights:
- **Distance**: Events with shorter vehicle-to-vehicle distances tend to show higher perceived risks.
- **Braking Intensity**: Higher braking intensities are associated with higher perceived risk.
- **Speed**: Higher speeds also lead to an increase in perceived risk.

### Dependencies:
- MATLAB's **Statistics and Machine Learning Toolbox** for GMM fitting (`fitgmdist`).
- The dataset `SubjectiveRatings.mat` which contains subjective risk rating data for 27 events.

## [SVM_JS_divergence.m](./SVM_JS_divergence.m)
This MATLAB script performs an analysis of perceived risk ratings in the **SVM** scenario with respect to three controlled parameters: **cruising speed**, **braking intensity**, and **initial merging distance**. The script generates visualisations of rating transitions and applies Markov modeling, Gaussian Mixture Models (GMM), and divergence measures to quantify and compare the perceived risk across multiple events.

### Key Analyses:

1. **Rating Transition Matrix and GMM Training**:
   - For each event, the script constructs a **Markov transition matrix** from the perceived risk ratings. The transition matrix describes how ratings transition between clips.
   - A **Gaussian Mixture Model (GMM)** is fitted to the rating transition data for each event.
   
   - **Code Breakdown**:
     - The `markov_matrix` is an 11 &times; 11 matrix, capturing transitions between ratings (scaled from 0 to 10).
     - The script uses the `fitgmdist` function to train a GMM on the transition data, with one component (`k = 1`).

2. **Kullback-Leibler (KL) and Jensen-Shannon (JS) Divergence Matrix Computation**:
   - The script computes the **KL divergence** between the GMMs fitted for each event. This provides a measure of the similarity between events' rating transitions.
   - A **JS divergence matrix** is calculated as a symmetrised version of the KL divergence, using the formula:  
     
     JS = 0.5 &times; (KL_1 + KL_2)
     
   - **Code Breakdown**:
     - The `mvgkl` function computes the KL divergence between two GMMs.
     - `KL_matrix_1` and `KL_matrix_2` store the directional KL divergences between all event pairs.
     - `JS_matrix` is derived as the average of the two directional KL values.

3. **Distance Analysis (5, 15, 25 m)**:
   - This section evaluates the impact of varying distances between vehicles (**5 m**, **15 m**, and **25 m**) on perceived risk ratings, based on JS divergence.
   
   - **Code Breakdown**:
     - The arrays `d_5`, `d_15`, and `d_25` represent indices of events associated with specific distances.
     - The **reordered JS matrix** is created by selecting the events associated with each distance group.
     - The script computes the mean JS divergence for each distance combination and visualises the result using a heatmap (`imagesc`).

4. **Braking Intensity Analysis (-2, -5, -8 m/s²)**:
   - This section investigates how different braking intensities (**-2**, **-5**, and **-8 m/s²**) affect perceived risk.
   
   - **Code Breakdown**:
     - Arrays `BI_2`, `BI_5`, and `BI_8` correspond to events with specific braking intensities.
     - The script calculates the mean JS divergence across these groups and generates a heatmap to visualise the results.

5. **Cruising Speed Analysis (80, 100, 120 km/h)**:
   - This section analyses the impact of different cruising speeds (**80**, **100**, and **120 km/h**) on perceived risk.
   
   - **Code Breakdown**:
     - Arrays `v_80`, `v_100`, and `v_120` represent events grouped by speed.
     - The script computes and visualises the mean JS divergence for these speeds using a heatmap.

### Helper Functions:
- **mvgkl**: This function calculates the multivariate Gaussian KL divergence between two distributions, helping to quantify the difference between event transition models.
- **Data Preprocessing**: The script handles the ratings data, calculates transition matrices, and scales data for GMM input by converting frequencies into categorical pairs.
  
### Outputs:
- **Transition Matrix Visualisations**: The script generates bar plots for the transition matrices of all 27 events, showing the probability of transitioning from one rating to another.
- **GMM and Divergence Visualisations**: It also provides contour plots of the GMMs fitted to the transition data and heatmaps illustrating JS divergence for different controlled parameters (distance, speed, and braking intensity).

### Example Visualisations:
- **Figure 1**: Transition matrix bar plots for each event, showing the rating dynamics over time.
- **Figure 2**: Contour plots of the fitted GMM for each event, illustrating the distribution of rating transitions.
- **Heatmaps**: For each controlled parameter (distance, braking intensity, speed), heatmaps of the log-transformed JS divergence are displayed, allowing for visual comparison of risk ratings under different conditions.

### Key Insights:
- **Distance**: Events with shorter vehicle-to-vehicle distances tend to show higher perceived risks.
- **Braking Intensity**: Higher braking intensities are associated with higher perceived risk.
- **Speed**: Higher speeds also lead to an increase in perceived risk.

### Dependencies:
- MATLAB's **Statistics and Machine Learning Toolbox** for GMM fitting (`fitgmdist`).
- The dataset `SubjectiveRatings.mat` which contains subjective risk rating data for 27 events.

## [mvgkl.m](./mvgkl.m)
This MATLAB function calculates the **Kullback-Leibler (KL) divergence** between two **multivariate Gaussian distributions**.

### Key Features:
- **KL divergence** is computed between two distributions, **P1** and **P2**, with parameters:
  - **P1**: mean (`m1`) and covariance matrix (`S1`)
  - **P2**: mean (`m2`) and covariance matrix (`S2`)
- The covariance matrices, **S1** and **S2**, must be **positive definite**.

### Inputs:
- **m1**: Mean vector of the first Gaussian distribution.
- **S1**: Covariance matrix of the first Gaussian distribution.
- **m2**: Mean vector of the second Gaussian distribution.
- **S2**: Covariance matrix of the second Gaussian distribution.

### Outputs:
- **kl**: The Kullback-Leibler divergence between the two multivariate Gaussian distributions.

### Examples:

1. **Univariate Gaussians**: KL divergence between `N(-1, 1)` and `N(+1, 1)`
    ```matlab
    mu1 = -1; mu2 = +1; s1 = 1; s2 = 1;   
    mvgkl(mu1, s1^2, mu2, s2^2)
    ```

2. **Multivariate Gaussians**: KL divergence between `N(mu1, S1)` and `N(mu2, S2)`
    ```matlab
    mu1 = [-1 -1]'; mu2 = [+1 +1]';
    S1 = [1 0.5; 0.5 1]; S2 = [1 -0.7; -0.7 1];
    mvgkl(mu1, S1, mu2, S2)
    ```

### Dependencies:
- No external dependencies.

### Notes:
- The function checks if the input means are column vectors and if the covariance matrices are positive definite using Cholesky decomposition.
- The function computes the KL divergence as:

$$
KL(P1 || P2) = \frac{1}{2} \left[ \text{tr}(S_2^{-1} S_1) + (m_2 - m_1)^T S_2^{-1} (m_2 - m_1) - d + \log\left(\frac{\det(S_2)}{\det(S_1)}\right) \right]
$$

  Where `d` is the dimension of the mean vectors.

