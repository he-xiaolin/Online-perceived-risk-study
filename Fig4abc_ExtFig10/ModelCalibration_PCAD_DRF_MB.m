% This function is to calibrate DRF and PCAD in MB scenario. This version
% is for local run. To run the calibration on HPC, please include the .sh
% file.
clear;clc;close all;

% add path and load data
addpath('SMoS_Functions/DRF');
addpath('SMoS_Functions/PCAD');

pt1 = '../Data/KinematicData.mat';
pt2 = '../Data/SubjectiveRatings.mat';
load(pt1);
load(pt2);

% Number of workers you intend to use
nworkers = 12;

% Check if there is an existing parallel pool
poolObj = gcp('nocreate'); % Get the current pool object if it exists

% If no pool, start a new one
if isempty(poolObj)
    myCluster = parcluster('local');
    PP = parpool(myCluster, nworkers);
else
    % There is an existing pool. Decide what to do:
    % Use the existing pool or delete it and start a new one.
    
    % Option 1: Use the existing pool as is
    PP = poolObj;
    
    % Option 2: Restart the pool with a specific number of workers
    %{
    delete(poolObj); % Shut down the existing pool
    myCluster = parcluster('local');
    PP = parpool(myCluster, nworkers); % Start a new pool
    %}
end

% data process
x_s = [MB.x_s];
x_n = [MB.x_n];
y_s = [MB.y_s];
y_n = [MB.y_n];
vx_s = [MB.vx_s];
vx_n = [MB.vx_n];
vy_s = [MB.vy_s];vy_s(:)=0;
vy_n = [MB.vy_n];vy_n(:)=0;
ax_s = [MB.ax_s];
ax_n = [MB.ax_n];
ay_s = [MB.ay_s];
ay_n = [MB.ay_n];
delta_x = [MB.delta_x];
delta_y = [MB.delta_y];

PR = [MB_PR.risk_p25_p75_mean];
len = length(x_s);

%% PCAD
% Define the number of bootstrap samples
numBootstrap = 100;  % for example, 100 bootstrap samples

% Define the number of iterations for the random search
numIterations = 200; % make a balance between accuracy and computation cost

% Define the parameter ranges for PCAD
paramRanges_PCAD = {
    [0, 6],  % Range for sig_xs
    [0, 6],  % Range for sig_ys
    [0, 6],  % Range for sig_xn
    [0, 6],  % Range for sig_yn
    [0, 1],  % Range for tps
    [0, 1],  % Range for tpn
    [0, 2]   % Range for alpha
};

% Initialize arrays to store bootstrap results
bootstrapParams_PCAD = zeros(numBootstrap, length(paramRanges_PCAD));%
bootstrapCosts_PCAD = zeros(numBootstrap, 1);

% Main Bootstrap Loop

for b = 1:numBootstrap+1
    %tic
    % Create a bootstrap sample
    if b ==1
        indices = 1:len;
    else
    indices = randi(len, [1, len]);  % Random indices for bootstrap
    end
    x_s_b = x_s(indices); 
    x_n_b = x_n(indices);  % and so on for all variables
    y_s_b = y_s(indices);
    y_n_b = y_n(indices);
    vx_s_b = vx_s(indices);
    vx_n_b = vx_n(indices);
    vy_s_b = vy_s(indices);
    vy_n_b = vy_n(indices);
    ax_s_b = ax_s(indices);
    ax_n_b = ax_n(indices);
    ay_s_b = ay_s(indices);
    ay_n_b = ay_n(indices);
    delta_x_b = delta_x(indices);
    delta_y_b = delta_y(indices);

    PR_b = PR(indices);

    
    % % Initialize arrays for this bootstrap sample
    allCosts_PCAD = zeros(numIterations, 1);
    allParams_PCAD = zeros(numIterations, length(paramRanges_PCAD));

    % Parallel random search loop for this bootstrap sample
    parfor i = 1:numIterations % grid search calibration
            % Randomly sample parameters
    params_PCAD = cellfun(@(r) r(1) + (r(2)-r(1)) * rand, paramRanges_PCAD, 'UniformOutput', false);
    params_PCAD = [params_PCAD{:}];

    % Evaluate the cost function
    cost = cost_function_PCAD(params_PCAD, x_s_b, x_n_b, y_s_b, y_n_b, vx_s_b, vx_n_b, vy_s_b, vy_n_b, ax_s_b, ax_n_b, ay_s_b, ay_n_b, PR_b);

    % Store the results
    allCosts_PCAD(i) = cost;
    allParams_PCAD(i, :) = params_PCAD;
    end

    % Find the best parameters for this bootstrap sample
    [minCost, idx] = min(allCosts_PCAD);
    bestParams = allParams_PCAD(idx, :);

    % Store the results of this bootstrap iteration
    bootstrapParams_PCAD(b, :) = bestParams;
    bootstrapCosts_PCAD(b) = minCost;
    disp(b);
    disp('MB PCAD');
    % toc
end

results_PCAD = struct('X', bootstrapParams_PCAD, 'fval', bootstrapCosts_PCAD);
%% DRF
% Define the number of bootstrap samples
numBootstrap = 100;  % for example, 100 bootstrap samples

% Define the number of iterations for the random search
numIterations = 200; % make a balance of the accuracy and computation cost

% Define the parameter ranges for DRF
paramRanges_DRF = {
    [0, 10],  % tla
    [0, 1e-3],  % m
    [0, 1],  % c
    [0, 1] % s
};

% Initialize arrays to store bootstrap results
bootstrapParams_DRF = zeros(numBootstrap, length(paramRanges_DRF));%
bootstrapCosts_DRF = zeros(numBootstrap, 1);

% Main Bootstrap Loop

for b = 1:numBootstrap+1
    %tic
    % Create a bootstrap sample
    if b ==1
        indices = 1:len;
    else
        indices = randi(len, [1, len]);  % Random indices for bootstrap
    end
    x_s_b = x_s(indices); 
    x_n_b = x_n(indices);  
    y_s_b = y_s(indices);
    y_n_b = y_n(indices);
    vx_s_b = vx_s(indices);
    vx_n_b = vx_n(indices);
    vy_s_b = vy_s(indices);
    vy_n_b = vy_n(indices);
    ax_s_b = ax_s(indices);
    ax_n_b = ax_n(indices);
    ay_s_b = ay_s(indices);
    ay_n_b = ay_n(indices);
    delta_x_b = delta_x(indices);
    delta_y_b = delta_y(indices);

    PR_b = PR(indices);
    
    % % Initialize arrays for this bootstrap sample
    allCosts_DRF = zeros(numIterations, 1);
    allParams_DRF = zeros(numIterations, length(paramRanges_DRF));

    % Parallel random search loop for this bootstrap sample
    parfor i = 1:numIterations % grid search calibration
            % Randomly sample parameters
    params_DRF = cellfun(@(r) r(1) + (r(2)-r(1)) * rand, paramRanges_DRF, 'UniformOutput', false);
    params_DRF = [params_DRF{:}];

    % Evaluate the cost function
    cost = cost_function_DRF(params_DRF, delta_x_b, delta_y_b, vx_s_b, PR_b);

    % Store the results
    allCosts_DRF(i) = cost;
    allParams_DRF(i, :) = params_DRF;
    end

    % Find the best parameters for this bootstrap sample
    [minCost, idx] = min(allCosts_DRF);
    bestParams = allParams_DRF(idx, :);

    % Store the results of this bootstrap iteration
    bootstrapParams_DRF(b, :) = bestParams;
    bootstrapCosts_DRF(b) = minCost;
    disp(b);
    disp('MB DRF');
    % toc
end

results_DRF = struct('X', bootstrapParams_DRF, 'fval', bootstrapCosts_DRF);

%% Calculate PCAD
PCAD = struct();
[iter,~] = size(results_PCAD.X);
for bb = 1:iter
    % define parameters
    sigxs = results_PCAD.X(bb,1);
    sigys= results_PCAD.X(bb,2); 
    sigxn= results_PCAD.X(bb,3); 
    sigyn= results_PCAD.X(bb,4); 
    tps = results_PCAD.X(bb,5); 
    tpn = results_PCAD.X(bb,6); 
    alpha = results_PCAD.X(bb,7);

    for nn= 1:27 % event order 1-27
        x_s = MB(nn).x_s;
        x_n = MB(nn).x_n;
        y_s = MB(nn).y_s;
        y_n = MB(nn).y_n;
        vx_s = MB(nn).vx_s;
        vx_n = MB(nn).vx_n;
        vy_s = MB(nn).vy_s;
        vy_n = MB(nn).vy_n;
        ax_s = MB(nn).ax_s;
        ax_n = MB(nn).ax_n;
        ay_s = MB(nn).ay_s;
        ay_n = MB(nn).ay_n;
        time = MB(nn).Time;
        delta_x = abs(x_n - x_s);
        delta_y = abs(y_n - y_s);
        len = length(x_s);
        parfor i = 1:len
            PCAD_temp(i) = PCAD_function(x_s(i), x_n(i), y_s(i), y_n(i), vx_s(i), vx_n(i), 0, 0, ax_s(i), ax_n(i), ay_s(i), ay_n(i),...
                sigxs, sigys, sigxn, sigyn, tps, tpn, alpha);
        end
        PCAD_temp = smooth(PCAD_temp, 0.1, 'rloess');
        
        PCAD(nn).value(bb,:) = PCAD_temp';
        
    end
    disp(num2str(bb));
end 

%% DRF
DRF = struct();
[iter,~] = size(results_DRF.X);
for bb = 1:iter
    % Define model parameters
    s = 0.15;
    tla = results_DRF.X(bb,1);
    m = results_DRF.X(bb,2);
    c = results_DRF.X(bb,3);
    for nn=1:27
        x_s = MB(nn).x_s;
        x_n = MB(nn).x_n;
        y_s = MB(nn).y_s;
        y_n = MB(nn).y_n;
        vx_s = MB(nn).vx_s;
        vx_n = MB(nn).vx_n;
        vy_s = MB(nn).vy_s;
        vy_n = MB(nn).vy_n;
        ax_s = MB(nn).ax_s;
        ax_n = MB(nn).ax_n;
        ay_s = MB(nn).ay_s;
        ay_n = MB(nn).ay_n;
        time = MB(nn).Time;
        delta_x = abs(x_n - x_s);
        delta_y = abs(y_n - y_s);
        len = length(x_s);
        parfor i = 1:len
            DRF_temp(i) = DRF_cal(delta_x(i), delta_y(i), vx_s(i), s, tla, m, c);
        end
        DRF(nn).value(bb,:) = DRF_temp;
    end
    disp(num2str(bb));
end
%% save
save('./CalibratedParameters_MB','results_DRF','results_PCAD','DRF','PCAD');