%% MB
clear; clc; close all;

pt1 = './CalibrationResults/PCAD_DRF/CalibratedParameters_MB.mat';
pt2 = '../Data/SubjectiveRatings.mat';
pt3 = './CalibrationResults/NN/MB.mat';
load(pt1);
load(pt2);
load(pt3);

iter = 101;
PCAD_scaled = struct();
DRF_scaled = struct();
NN_scaled = struct();
% This step is to scale the model output into 0-10.
for ii = 1:iter
PCAD_temp = [];
DRF_temp = [];
    for nn = 1:27
        PCAD_temp = [PCAD_temp, PCAD(nn).value(ii,:)];
        DRF_temp = [DRF_temp, DRF(nn).value(ii,:)];
    end
maxValIter_PCAD = max(PCAD_temp);
maxValIter_DRF = max(DRF_temp);
    for nn = 1:27
        PCAD_scaled(nn).value(ii,:) = PCAD(nn).value(ii, :)/maxValIter_PCAD*10;
        DRF_scaled(nn).value(ii,:) = DRF(nn).value(ii, :)/maxValIter_DRF*10;
    end
end

for nn = 1:27 
    PCAD_scaled(nn).plotData(:,1) = 0:0.1:30;
    PCAD_scaled(nn).plotData(:,3) = mean(PCAD_scaled(nn).value)'; 
    PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    PCAD_scaled(nn).plotData(:,4) = PCAD_scaled(nn).plotData(:,2); % The same as column 2

    DRF_scaled(nn).plotData(:,1) = 0:0.1:30;
    DRF_scaled(nn).plotData(:,3) = mean(DRF_scaled(nn).value)';
    DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    DRF_scaled(nn).plotData(:,4) = DRF_scaled(nn).plotData(:,2); % The same as column 2

    NN_scaled(nn).plotData(:,1) = 0:0.1:30;
    NN_scaled(nn).plotData(:,3) = prediction((nn-1)*301+1:nn*301);
    NN_scaled(nn).plotData(:,2) = epistemic((nn-1)*301+1:nn*301); % This is the Epistemic uncertainty. It exists in NN results, so no need to calculate here.
    NN_scaled(nn).plotData(:,4) = NN_scaled(nn).plotData(:,2); % The same as column 2
end

% save('./PredictionResults/Prediction_MB.mat', 'PCAD_scaled','DRF_scaled', 'NN_scaled')
%% HB
clear; clc; close all;

pt1 = './CalibrationResults/PCAD_DRF/CalibratedParameters_HB.mat';
pt2 = '../Data/SubjectiveRatings.mat';
pt3 = './CalibrationResults/NN/HB.mat';
load(pt1);
load(pt2);
load(pt3);

iter = 101;
PCAD_scaled = struct();
DRF_scaled = struct();
NN_scaled = struct();
% This step is to scale the model output into 0-10.
for ii = 1:iter
PCAD_temp = [];
DRF_temp = [];
    for nn = 1:27
        PCAD_temp = [PCAD_temp, PCAD(nn).value(ii,:)];
        DRF_temp = [DRF_temp, DRF(nn).value(ii,:)];
    end
maxValIter_PCAD = max(PCAD_temp);
maxValIter_DRF = max(DRF_temp);
    for nn = 1:27
        PCAD_scaled(nn).value(ii,:) = PCAD(nn).value(ii, :)/maxValIter_PCAD*10;
        DRF_scaled(nn).value(ii,:) = DRF(nn).value(ii, :)/maxValIter_DRF*10;
    end
end

for nn = 1:27
    PCAD_scaled(nn).plotData(:,1) = 0:0.1:30;
    PCAD_scaled(nn).plotData(:,3) = mean(PCAD_scaled(nn).value)';
    PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    PCAD_scaled(nn).plotData(:,4) = PCAD_scaled(nn).plotData(:,2); % The same as column 2

    DRF_scaled(nn).plotData(:,1) = 0:0.1:30;
    DRF_scaled(nn).plotData(:,3) = mean(DRF_scaled(nn).value)';
    DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    DRF_scaled(nn).plotData(:,4) = DRF_scaled(nn).plotData(:,2); % The same as column 2

    NN_scaled(nn).plotData(:,1) = 0:0.1:30;
    NN_scaled(nn).plotData(:,3) = prediction((nn-1)*301+1:nn*301);
    NN_scaled(nn).plotData(:,2) = epistemic((nn-1)*301+1:nn*301);  % This is the Epistemic uncertainty. It exists in NN results, so no need to calculate here.
    NN_scaled(nn).plotData(:,4) = NN_scaled(nn).plotData(:,2); % The same as column 2
end

% calculate residuals
for nn = 1:27
    PCAD_scaled(nn).error = abs(PCAD_scaled(nn).plotData(:,3) - HB_PR(nn).risk_p25_p75_mean');
    DRF_scaled(nn).error = abs(DRF_scaled(nn).plotData(:,3) - HB_PR(nn).risk_p25_p75_mean');
    NN_scaled(nn).error = abs(NN_scaled(nn).plotData(:,3) - HB_PR(nn).risk_p25_p75_mean');
end

PCAD_error_temp = [];
DRF_error_temp = [];
NN_error_temp = [];
for nn = 1:27
PCAD_error_temp = [PCAD_error_temp;PCAD_scaled(nn).error];
DRF_error_temp = [DRF_error_temp;DRF_scaled(nn).error];
NN_error_temp = [NN_error_temp;NN_scaled(nn).error];
end
PCAD_scaled(1).ERROR = PCAD_error_temp;
DRF_scaled(1).ERROR = DRF_error_temp;
NN_scaled(1).ERROR = NN_error_temp;

figure;
for nn=1:27
    subplot(5,6,nn)
plot(PCAD_scaled(nn).plotData(:,1),max(PCAD_scaled(nn).plotData(:,3)-PCAD_scaled(nn).plotData(:,2),0));hold on
plot(PCAD_scaled(nn).plotData(:,1),PCAD_scaled(nn).plotData(:,3));hold on
plot(PCAD_scaled(nn).plotData(:,1),min(PCAD_scaled(nn).plotData(:,3)+PCAD_scaled(nn).plotData(:,4),10));hold on
ylim([0 10])
end

figure;
for nn=1:27
    subplot(5,6,nn)
plot(DRF_scaled(nn).plotData(:,1),max(DRF_scaled(nn).plotData(:,3)-DRF_scaled(nn).plotData(:,2),0));hold on
plot(DRF_scaled(nn).plotData(:,1),DRF_scaled(nn).plotData(:,3));hold on
plot(DRF_scaled(nn).plotData(:,1),min(DRF_scaled(nn).plotData(:,3)+DRF_scaled(nn).plotData(:,4),10));hold on
ylim([0 10])
end

figure;
for nn=1:27
    subplot(5,6,nn)
plot(NN_scaled(nn).plotData(:,1),max(NN_scaled(nn).plotData(:,3)-NN_scaled(nn).plotData(:,2),0));hold on
plot(NN_scaled(nn).plotData(:,1),NN_scaled(nn).plotData(:,3));hold on
plot(NN_scaled(nn).plotData(:,1),min(NN_scaled(nn).plotData(:,3)+NN_scaled(nn).plotData(:,4),10));hold on
ylim([0 10])
end

figure;
boxplot([PCAD_scaled(1).ERROR,DRF_scaled(1).ERROR,NN_scaled(1).ERROR])

% save('./PredictionResults/Prediction_HB.mat', 'PCAD_scaled','DRF_scaled', 'NN_scaled')
%% SVM
clear; clc; close all;

pt1 = './CalibrationResults/PCAD_DRF/CalibratedParameters_SVM.mat';
pt2 = '../Data/SubjectiveRatings.mat';
pt3 = './CalibrationResults/NN/SVM.mat';
load(pt1);
load(pt2);
load(pt3);

iter = 101;
PCAD_scaled = struct();
DRF_scaled = struct();
NN_scaled = struct();
% This step is to scale the model output into 0-10.
for ii = 1:iter
PCAD_temp = [];
DRF_temp = [];
    for nn = 1:27
        PCAD_temp = [PCAD_temp, PCAD(nn).value(ii,:)];
        DRF_temp = [DRF_temp, DRF(nn).value(ii,:)];
    end
maxValIter_PCAD = max(PCAD_temp);
maxValIter_DRF = max(DRF_temp);
    for nn = 1:27
        PCAD_scaled(nn).value(ii,:) = PCAD(nn).value(ii, :)/maxValIter_PCAD*10;
        DRF_scaled(nn).value(ii,:) = DRF(nn).value(ii, :)/maxValIter_DRF*10;
    end
end

for nn = 1:27
    PCAD_scaled(nn).plotData(:,1) = 0:0.1:30;
    PCAD_scaled(nn).plotData(:,3) = mean(PCAD_scaled(nn).value)';
    PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    PCAD_scaled(nn).plotData(:,4) = PCAD_scaled(nn).plotData(:,2); % The same as column 2

    DRF_scaled(nn).plotData(:,1) = 0:0.1:30;
    DRF_scaled(nn).plotData(:,3) = mean(DRF_scaled(nn).value)';
    DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    DRF_scaled(nn).plotData(:,4) = DRF_scaled(nn).plotData(:,2); % The same as column 2

        NN_scaled(nn).plotData(:,1) = 0:0.1:30;
    NN_scaled(nn).plotData(:,3) = prediction((nn-1)*301+1:nn*301);
    NN_scaled(nn).plotData(:,2) = epistemic((nn-1)*301+1:nn*301);  % This is the Epistemic uncertainty. It exists in NN results, so no need to calculate here.
    NN_scaled(nn).plotData(:,4) = NN_scaled(nn).plotData(:,2); % The same as column 2
end

% save('./PredictionResults/Prediction_SVM.mat', 'PCAD_scaled','DRF_scaled', 'NN_scaled')
%% LC_1
clear; clc; close all;

pt1 = './CalibrationResults/PCAD_DRF/CalibratedParameters_LC.mat';
pt2 = '../Data/SubjectiveRatings.mat';
pt3 = './CalibrationResults/NN/LC_1.mat';
load(pt1);
load(pt2);
load(pt3);

iter = 101;
PCAD_scaled = struct();
DRF_scaled = struct();
NN_scaled = struct();
% This step is to scale the model output into 0-10.
for ii = 1:iter
PCAD_temp = [];
DRF_temp = [];
    for nn = 1:12
        PCAD_temp = [PCAD_temp, PCAD(nn).value(ii,:)];
        DRF_temp = [DRF_temp, DRF(nn).value(ii,:)];
    end
maxValIter_PCAD = max(PCAD_temp);
maxValIter_DRF = max(DRF_temp);
    for nn = 1:12
        PCAD_scaled(nn).value(ii,:) = PCAD(nn).value(ii, :)/maxValIter_PCAD*10;
        DRF_scaled(nn).value(ii,:) = DRF(nn).value(ii, :)/maxValIter_DRF*10;
    end
end
for nn = 1:12
    PCAD_scaled(nn).plotData(:,1) = 0:0.1:36;
    PCAD_scaled(nn).plotData(:,3) = mean(PCAD_scaled(nn).value)';
    PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    PCAD_scaled(nn).plotData(:,4) = PCAD_scaled(nn).plotData(:,2); % The same as column 2

    DRF_scaled(nn).plotData(:,1) = 0:0.1:36;
    DRF_scaled(nn).plotData(:,3) = mean(DRF_scaled(nn).value)';
    DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    DRF_scaled(nn).plotData(:,4) = DRF_scaled(nn).plotData(:,2); % The same as column 2

        NN_scaled(nn).plotData(:,1) = 0:0.1:36;
    NN_scaled(nn).plotData(:,3) = prediction((nn-1)*361+1:nn*361);
    NN_scaled(nn).plotData(:,2) = epistemic((nn-1)*361+1:nn*361);  % This is the Epistemic uncertainty. It exists in NN results, so no need to calculate here.
    NN_scaled(nn).plotData(:,4) = NN_scaled(nn).plotData(:,2); % The same as column 2
end

% save('./PredictionResults/Prediction_LC1.mat', 'PCAD_scaled','DRF_scaled', 'NN_scaled')
%% LC_2
clear; clc; close all;

pt1 = './CalibrationResults/PCAD_DRF/CalibratedParameters_LC.mat';
pt2 = '../Data/SubjectiveRatings.mat';
pt3 = './CalibrationResults/NN/LC_2.mat';
load(pt1);
load(pt2);
load(pt3);

iter = 101;
PCAD_scaled = struct();
DRF_scaled = struct();
NN_scaled = struct();
% This step is to scale the model output into 0-10.
for ii = 1:iter
PCAD_temp = [];
DRF_temp = [];
    for nn = 1:6
        PCAD_temp = [PCAD_temp, PCAD(nn+12).value(ii,:)];
        DRF_temp = [DRF_temp, DRF(nn+12).value(ii,:)];
    end
maxValIter_PCAD = max(PCAD_temp);
maxValIter_DRF = max(DRF_temp);
    for nn = 1:6
        PCAD_scaled(nn).value(ii,:) = PCAD(nn+12).value(ii, :)/maxValIter_PCAD*10;
        DRF_scaled(nn).value(ii,:) = DRF(nn+12).value(ii, :)/maxValIter_DRF*10;
    end
end
for nn = 1:6
    PCAD_scaled(nn).plotData(:,1) = 0:0.1:36;
    PCAD_scaled(nn).plotData(:,3) = mean(PCAD_scaled(nn).value)';
    PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2)./iter)';  % This is the Epistemic uncertainty
    PCAD_scaled(nn).plotData(:,4) = PCAD_scaled(nn).plotData(:,2); % The same as column 2

    DRF_scaled(nn).plotData(:,1) = 0:0.1:36;
    DRF_scaled(nn).plotData(:,3) = mean(DRF_scaled(nn).value)';
    DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2)./iter)';  % This is the Epistemic uncertainty
    DRF_scaled(nn).plotData(:,4) = DRF_scaled(nn).plotData(:,2); % The same as column 2

    NN_scaled(nn).plotData(:,1) = 0:0.1:36;
    NN_scaled(nn).plotData(:,3) = prediction((nn-1)*361+1:nn*361);
    NN_scaled(nn).plotData(:,2) = epistemic((nn-1)*361+1:nn*361);  % This is the Epistemic uncertainty. It exists in NN results, so no need to calculate here.
    NN_scaled(nn).plotData(:,4) = NN_scaled(nn).plotData(:,2); % The same as column 2
end

% save('./PredictionResults/Prediction_LC2.mat', 'PCAD_scaled','DRF_scaled', 'NN_scaled');
%% LC_3
clear; clc; close all;

pt1 = './CalibrationResults/PCAD_DRF/CalibratedParameters_LC.mat';
pt2 = '../Data/SubjectiveRatings.mat';
pt3 = './CalibrationResults/NN/LC_3.mat';
load(pt1);
load(pt2);
load(pt3);

iter = 101;
PCAD_scaled = struct();
DRF_scaled = struct();
NN_scaled = struct();
% This step is to scale the model output into 0-10.
for ii = 1:iter
PCAD_temp = [];
DRF_temp = [];
    for nn = 1:6
        PCAD_temp = [PCAD_temp, PCAD(nn+18).value(ii,:)];
        DRF_temp = [DRF_temp, DRF(nn+18).value(ii,:)];
    end
maxValIter_PCAD = max(PCAD_temp);
maxValIter_DRF = max(DRF_temp);
    for nn = 1:6
        PCAD_scaled(nn).value(ii,:) = PCAD(nn+18).value(ii, :)/maxValIter_PCAD*10;
        DRF_scaled(nn).value(ii,:) = DRF(nn+18).value(ii, :)/maxValIter_DRF*10;
    end
end
for nn = 1:6
    PCAD_scaled(nn).plotData(:,1) = 0:0.1:36;
    PCAD_scaled(nn).plotData(:,3) = mean(PCAD_scaled(nn).value)';
    PCAD_scaled(nn).plotData(:,2) = (sum((PCAD_scaled(nn).value - mean(PCAD_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    PCAD_scaled(nn).plotData(:,4) = PCAD_scaled(nn).plotData(:,2); % The same as column 2

    DRF_scaled(nn).plotData(:,1) = 0:0.1:36;
    DRF_scaled(nn).plotData(:,3) = mean(DRF_scaled(nn).value)';
    DRF_scaled(nn).plotData(:,2) = (sum((DRF_scaled(nn).value - mean(DRF_scaled(nn).value)).^2)./iter)'; % This is the Epistemic uncertainty
    DRF_scaled(nn).plotData(:,4) = DRF_scaled(nn).plotData(:,2); % The same as column 2

    NN_scaled(nn).plotData(:,1) = 0:0.1:36;
    NN_scaled(nn).plotData(:,3) = prediction((nn-1)*361+1:nn*361);
    NN_scaled(nn).plotData(:,2) = epistemic((nn-1)*361+1:nn*361); % This is the Epistemic uncertainty. It exists in NN results, so no need to calculate here.
    NN_scaled(nn).plotData(:,4) = NN_scaled(nn).plotData(:,2); % The same as column 2
end

% save('./PredictionResults/Prediction_LC3.mat', 'PCAD_scaled','DRF_scaled', 'NN_scaled');