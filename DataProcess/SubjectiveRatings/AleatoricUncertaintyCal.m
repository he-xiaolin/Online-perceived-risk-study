%% MB
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
for nn = 1:27
matrixData = [MB_PR(nn).risk]; 

[nRows, nCols] = size(matrixData); % Get the number of rows and columns

% Number of bootstrap samples
numBootstrapSamples = 5000;

% Preallocate matrix for bootstrap results
bootstrapResults = zeros(numBootstrapSamples, nCols); % 1000x301 matrix

% Bootstrapping for each moment
for moment = 1:nCols % For each of the 301 moments
    parfor b = 1:numBootstrapSamples
        % Create a bootstrap sample (random sampling with replacement)
        bootstrapSample = matrixData(randi(nRows, nRows, 1), moment);
        
        % Calculate standard deviation of this sample
        bootstrapResults(b, moment) = std(bootstrapSample);
    end
end

% Calculate mean standard deviation across all bootstrap samples
% This is the estimated aleatoric uncertainty for each moment
aleatoricUncertainty = mean(bootstrapResults, 1);
MB_PR(nn).AU = aleatoricUncertainty;
disp(nn)
end

% save(dir,'MB_PR','HB_PR','LC_PR','SVM_PR');
%% HB
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
for nn = 1:27
matrixData = [HB_PR(nn).risk]; 

[nRows, nCols] = size(matrixData); % Get the number of rows and columns

% Number of bootstrap samples
numBootstrapSamples = 5000;

% Preallocate matrix for bootstrap results
bootstrapResults = zeros(numBootstrapSamples, nCols); % 1000x301 matrix

% Bootstrapping for each moment
for moment = 1:nCols % For each of the 301 moments
    for b = 1:numBootstrapSamples
        % Create a bootstrap sample (random sampling with replacement)
        bootstrapSample = matrixData(randi(nRows, nRows, 1), moment);
        
        % Calculate standard deviation of this sample
        bootstrapResults(b, moment) = std(bootstrapSample);
    end
end

% Calculate mean standard deviation across all bootstrap samples
% This is the estimated aleatoric uncertainty for each moment
aleatoricUncertainty = mean(bootstrapResults, 1);
HB_PR(nn).AU = aleatoricUncertainty;
disp(nn)
end

% save(dir,'MB_PR','HB_PR','LC_PR','SVM_PR');
%% LC
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
for nn = 1:24
matrixData = [LC_PR(nn).risk]; 

[nRows, nCols] = size(matrixData); % Get the number of rows and columns

% Number of bootstrap samples
numBootstrapSamples = 5000;

% Preallocate matrix for bootstrap results
bootstrapResults = zeros(numBootstrapSamples, nCols); % 1000x301 matrix

% Bootstrapping for each moment
for moment = 1:nCols % For each of the 301 moments
    for b = 1:numBootstrapSamples
        % Create a bootstrap sample (random sampling with replacement)
        bootstrapSample = matrixData(randi(nRows, nRows, 1), moment);
        
        % Calculate standard deviation of this sample
        bootstrapResults(b, moment) = std(bootstrapSample);
    end
end

% Calculate mean standard deviation across all bootstrap samples
% This is the estimated aleatoric uncertainty for each moment
aleatoricUncertainty = mean(bootstrapResults, 1);
LC_PR(nn).AU = aleatoricUncertainty;
disp(nn)
end

% save(dir,'MB_PR','HB_PR','LC_PR','SVM_PR');
%% SVM
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
for nn = 1:27
matrixData = [SVM_PR(nn).risk]; 

[nRows, nCols] = size(matrixData); % Get the number of rows and columns

% Number of bootstrap samples
numBootstrapSamples = 5000;

% Preallocate matrix for bootstrap results
bootstrapResults = zeros(numBootstrapSamples, nCols); % 1000x301 matrix

% Bootstrapping for each moment
for moment = 1:nCols % For each of the 301 moments
    for b = 1:numBootstrapSamples
        % Create a bootstrap sample (random sampling with replacement)
        bootstrapSample = matrixData(randi(nRows, nRows, 1), moment);
        
        % Calculate standard deviation of this sample
        bootstrapResults(b, moment) = std(bootstrapSample);
    end
end

% Calculate mean standard deviation across all bootstrap samples
% This is the estimated aleatoric uncertainty for each moment
aleatoricUncertainty = mean(bootstrapResults, 1);
SVM_PR(nn).AU = aleatoricUncertainty;
disp(nn)
end

% save(dir,'MB_PR','HB_PR','LC_PR','SVM_PR');