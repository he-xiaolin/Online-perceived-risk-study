%% Load data
clear;clc;
close all;
addpath('GroupedBoxplot_Functions')
dir='../Data/SubjectiveRatings.mat';
load(dir);
%% MB clip analysis %%%%%% Speed 80 100 120 km/h
clc
v_80=[];
for i=1:9
v_80 = [v_80; MB_PR(i).event_ratings];
end

v_100=[];
for i=10:18
v_100 = [v_100; MB_PR(i).event_ratings];
end

v_120=[];
for i=19:27
v_120 = [v_120; MB_PR(i).event_ratings];
end

rng('default')
x = {v_80,  v_100,  v_120};

figure('Position',[400 75 550 300]);
labels = ["A" "B" "C"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5"];
pValues=boxplotGroup(x,'Colors',[64,57,144;128,166,226;244,111,57]/255,'PrimaryLabels',labels,...
    'SecondaryLabels', ...
    grpLabels,...
    'GroupType','betweenGroups','GroupLines',true,'BoxStyle','filled','PlotStyle','Compact');
% title('MB - Speed','FontName','FixedWidth');
ylabel('Perceived risk','FontSize',20);
set(get(gca,'XLabel'),'FontSize',20);

set(gca, 'FontSize', 20);
% Example matrices with different sizes


A = v_80; % First matrix
B = v_100; % Second matrix
C = v_120; % Third matrix

% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 15);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:5
    newMatrix(1:size(A,1), (i-1)*3+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*3+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*3+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C
end
%% MB clip analysis %%%%%% braking intensity -2 -5 -8 m/s^2
clc
BI_2=[];
for i=[1:3,10:12,19:21]
BI_2 = [BI_2; MB_PR(i).event_ratings];
end

BI_5=[];
for i=[4:6, 13:15, 22:24]
BI_5 = [BI_5; MB_PR(i).event_ratings];
end

BI_8=[];
for i=[7:9, 16:18,25:27]
BI_8 = [BI_8; MB_PR(i).event_ratings];
end

rng('default')
x = {BI_2,  BI_5,  BI_8};

figure('Position',[400 75 550 300])
labels = ["A" "B" "C"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5"];
pValues=boxplotGroup(x,'Colors',[64,57,144;128,166,226;244,111,57]/255,'PrimaryLabels',labels, ...
    'SecondaryLabels', ...
    grpLabels,...
    'GroupType','betweenGroups','GroupLines',true,'BoxStyle','filled','PlotStyle','Compact');

% title('MB - Braking Intensity','FontName','FixedWidth');
ylabel('Perceived risk','FontSize',20);
set(get(gca,'XLabel'),'FontSize',20);

set(gca, 'FontSize', 20);


A = BI_2; % First matrix
B = BI_5; % Second matrix
C = BI_8; % Third matrix

% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 15);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:5
    newMatrix(1:size(A,1), (i-1)*3+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*3+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*3+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C
end
%% MB clip analysis %%%%%% Distance 
clc
idx=[1 4 7 10 13 16 19 22 25];
d_5=[];
for i=idx
d_5 = [d_5; MB_PR(i).event_ratings];
end

d_15=[];
for i=idx+1
d_15 = [d_15; MB_PR(i).event_ratings];
end

d_25=[];
for i=idx+2
d_25 = [d_25; MB_PR(i).event_ratings];
end

rng('default')
x = {d_5,  d_15,  d_25};

figure('Position',[400 75 550 300])
labels = ["A" "B" "C"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5"];
pValues=boxplotGroup(x,'Colors',[64,57,144;128,166,226;244,111,57]/255,'PrimaryLabels',labels, ...
    'SecondaryLabels', ...
    grpLabels,...
    'GroupType','betweenGroups','GroupLines',true,'BoxStyle','filled','PlotStyle','Compact');

% title('MB - Distance','FontName','FixedWidth');
ylabel('Perceived risk','FontSize',20);
set(get(gca,'XLabel'),'FontSize',20);

set(gca, 'FontSize', 20);

A = d_5; % First matrix
B = d_15; % Second matrix
C = d_25; % Third matrix

% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 15);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:5
    newMatrix(1:size(A,1), (i-1)*3+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*3+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*3+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C
end