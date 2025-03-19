%% Load data
clear;clc;
close all;
addpath('GroupedBoxplot_Functions')
dir='../Data/SubjectiveRatings.mat';
load(dir);
%% LC clip analysis
%%%%%%%% Lateral control: 1m/s 3m/s fragmented aborted
clc
LC_c=[];
for i=1:6
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=7:12
LC_m = [LC_m; LC_PR(i).event_ratings];
end

LC_f=[];
for i=13:18
LC_f = [LC_f; LC_PR(i).event_ratings];
end

LC_a = [];
for i=19:24
LC_a = [LC_a; LC_PR(i).event_ratings];
end

rng('default')
x = {LC_c,  LC_m,  LC_f,  LC_a};

figure('Position',[400 75 500 300])
labels = ["A" "B" "C" "D"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors',[64,57,144;128,166,226;244,111,57]/255,'PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true,'BoxStyle','filled','PlotStyle','Compact');

% title('LC - Lateral control','FontName','FixedWidth');
ylabel('Perceived risk');
set(gca,'FontSize',20)



A = LC_c; % First matrix
B = LC_m; % Second matrix
C = LC_f; % Third matrix
D = LC_a;

% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1), size(D, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 24);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*4+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*4+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*4+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C
    newMatrix(1:size(D,1), (i-1)*4+4) = D(:,i); % 3rd, 6th, 9th, etc., columns from C
end
%% LC clip analysis ACC Categories normal
%%%%%%%% ACC cat
clc
LC_c=[];
for i=[1 2 7 8]
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=[3 4 9 10]
LC_m = [LC_m; LC_PR(i).event_ratings];
end

LC_a=[];
for i=[5 6 11 12]
LC_a = [LC_a; LC_PR(i).event_ratings];
end


rng('default')
x = {LC_c,  LC_m,  LC_a};

figure('Position',[400 75 500 300])
labels = ["A" "B" "C"];% cautiour mild aggressive
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors',[64,57,144;128,166,226;244,111,57]/255,'PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true,'BoxStyle','filled','PlotStyle','Compact');

% title('LC - ACC CAT Normal','FontName','FixedWidth');
ylabel('Perceived risk');
set(gca,'FontSize',20)


A = LC_c; % First matrix
B = LC_m; % Second matrix
C = LC_a; % Third matrix


% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 18);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*3+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*3+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*3+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C

end
%% LC clip analysis ACC Categories Fragmented
clc
LC_c=[];
for i=[13 14]
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=[15 16]
LC_m = [LC_m; LC_PR(i).event_ratings];
end

LC_a=[];
for i=[17 18]
LC_a = [LC_a; LC_PR(i).event_ratings];
end


rng('default')
x = {LC_c,  LC_m,  LC_a};

figure('Position',[400 75 500 300])
labels = ["Cautious" "Mild" "Aggressive"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors','rkbg','PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true);

% title('LC - ACC Cat Fragmented','FontName','FixedWidth');
ylabel('Perceived risk');

A = LC_c; % First matrix
B = LC_m; % Second matrix
C = LC_a; % Third matrix


% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 18);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*3+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*3+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*3+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C

end
%% LC clip analysis ACC Categories Aborted
clc
LC_c=[];
for i=[19 20]
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=[21 22]
LC_m = [LC_m; LC_PR(i).event_ratings];
end

LC_a=[];
for i=[23 24]
LC_a = [LC_a; LC_PR(i).event_ratings];
end


rng('default')
x = {LC_c,  LC_m,  LC_a};

figure('Position',[400 75 500 300])
labels = ["Cautious" "Mild" "Aggressive"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors','rkbg','PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true);

% title('LC - ACC Cat Aborted','FontName','FixedWidth');
ylabel('Perceived risk');


A = LC_c; % First matrix
B = LC_m; % Second matrix
C = LC_a; % Third matrix


% Determine the maximum length
N = max([size(A, 1), size(B, 1), size(C, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 18);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*3+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*3+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B
    newMatrix(1:size(C,1), (i-1)*3+3) = C(:,i); % 3rd, 6th, 9th, etc., columns from C

end
%% LC clip analysis Distance Normal
clc
LC_c=[];
for i=[1 3 5 7 9 11]
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=[2 4 6 8 10 12]
LC_m = [LC_m; LC_PR(i).event_ratings];
end

rng('default')
x = {LC_c,  LC_m};

figure('Position',[400 75 500 300])
labels = ["A" "B"];% 5m 15m
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors',[64,57,144;128,166,226;244,111,57]/255,'PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true,'BoxStyle','filled','PlotStyle','Compact');

% title('LC - Distance Normal','FontName','FixedWidth');
ylabel('Perceived risk');
set(gca,'FontSize',20);

A = LC_c; % First matrix
B = LC_m; % Second matrix



% Determine the maximum length
N = max([size(A, 1), size(B, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 12);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*2+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*2+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B

end
%% LC clip analysis Distance Fragmented
clc
LC_c=[];
for i=[13 15 17]
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=[14 16 18]
LC_m = [LC_m; LC_PR(i).event_ratings];
end

rng('default')
x = {LC_c,  LC_m};

figure('Position',[400 75 500 300])
labels = ["5m" "15m"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors','rkbg','PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true);

% title('LC - Distance Fragmented','FontName','FixedWidth');
ylabel('Perceived risk');


A = LC_c; % First matrix
B = LC_m; % Second matrix



% Determine the maximum length
N = max([size(A, 1), size(B, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 12);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*2+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*2+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B

end

%% LC clip analysis Distance Aborted
clc
LC_c=[];
for i=[19 21 23]
LC_c = [LC_c; LC_PR(i).event_ratings];
end

LC_m=[];
for i=[20 22 24]
LC_m = [LC_m; LC_PR(i).event_ratings];
end

rng('default')
x = {LC_c,  LC_m};

figure('Position',[400 75 500 300])
labels = ["5m" "15m"];
grpLabels = ["Clip 1" "Clip 2" "Clip 3" "Clip 4" "Clip 5" "Clip 6"];
pValues=boxplotGroup(x,'Colors','rkbg','PrimaryLabels',labels,'SecondaryLabels',grpLabels,...
    'GroupType','betweenGroups','GroupLines',true);

% title('LC - Distance Aborted','FontName','FixedWidth');
ylabel('Perceived risk');

A = LC_c; % First matrix
B = LC_m; % Second matrix



% Determine the maximum length
N = max([size(A, 1), size(B, 1)]);

% Preallocate the new matrix with NaNs
newMatrix = NaN(N, 12);

% Fill in the new matrix
% Note: This loop assumes the pattern you described for the columns
for i = 1:6
    newMatrix(1:size(A,1), (i-1)*2+1) = A(:,i); % 1st, 4th, 7th, etc., columns from A
    newMatrix(1:size(B,1), (i-1)*2+2) = B(:,i); % 2nd, 5th, 8th, etc., columns from B

end
