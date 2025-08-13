% This function is to interpolate all ratings in field of event_ratings
% with hundreds of rows of data x 301 or 361 columns. Then it generates the
% field 'risk' containing continuous perceived risk for each recording. 
%% MB
clear; clc; close all;
dir = '../../Data/SubjectiveRatings.mat';
load(dir);

for nn=1:27
    [col,~]=size(MB_PR(nn).event_ratings);
  for i = 1:col
        ratings = [MB_PR(nn).event_ratings(i,1),MB_PR(nn).event_ratings(i,1),...
            MB_PR(nn).event_ratings(i,2),MB_PR(nn).event_ratings(i,2),...
            MB_PR(nn).event_ratings(i,3),MB_PR(nn).event_ratings(i,4),MB_PR(nn).event_ratings(i,5)];

        MB_PR(nn).risk(i,:) = pchipNew(MB_PR(nn).ratingTiming, ratings, MB_PR(nn).Time);
        MB_PR(nn).risk(i, MB_PR(nn).Time < MB_PR(nn).ratingTiming(1)) = ratings(1);
        MB_PR(nn).risk(i, MB_PR(nn).Time > MB_PR(nn).ratingTiming(end)) = ratings(end);
  end

end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');
%% HB
clear; clc; close all;
dir = '../../Data/SubjectiveRatings.mat';
load(dir);

for nn=1:27
    [col,~]=size(HB_PR(nn).event_ratings);
  for i = 1:col
        ratings = [HB_PR(nn).event_ratings(i,1),HB_PR(nn).event_ratings(i,1),...
            HB_PR(nn).event_ratings(i,2),HB_PR(nn).event_ratings(i,2),...
            HB_PR(nn).event_ratings(i,3),HB_PR(nn).event_ratings(i,4),HB_PR(nn).event_ratings(i,5)];

        HB_PR(nn).risk(i,:) = pchipNew(HB_PR(nn).ratingTiming, ratings, HB_PR(nn).Time);
        HB_PR(nn).risk(i, HB_PR(nn).Time < HB_PR(nn).ratingTiming(1)) = ratings(1);
        HB_PR(nn).risk(i, HB_PR(nn).Time > HB_PR(nn).ratingTiming(end)) = ratings(end);
  end

end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');
%% SVM
clear; clc; close all;
dir = '../../Data/SubjectiveRatings.mat';
load(dir);

for nn=1:27
    [col,~]=size(SVM_PR(nn).event_ratings);
  for i = 1:col
        ratings = [SVM_PR(nn).event_ratings(i,1),SVM_PR(nn).event_ratings(i,1),...
            SVM_PR(nn).event_ratings(i,2),SVM_PR(nn).event_ratings(i,2),...
            SVM_PR(nn).event_ratings(i,3),SVM_PR(nn).event_ratings(i,4),SVM_PR(nn).event_ratings(i,5)];

        SVM_PR(nn).risk(i,:) = pchipNew(SVM_PR(nn).ratingTiming, ratings, SVM_PR(nn).Time);
        SVM_PR(nn).risk(i, SVM_PR(nn).Time < SVM_PR(nn).ratingTiming(1)) = ratings(1);
        SVM_PR(nn).risk(i, SVM_PR(nn).Time > SVM_PR(nn).ratingTiming(end)) = ratings(end);
  end

end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');
%% LC
clear; clc; close all;
dir = '../../Data/SubjectiveRatings.mat';
load(dir);

for nn=1:24
    [col,~]=size(LC_PR(nn).event_ratings);
  for i = 1:col
        ratings = [LC_PR(nn).event_ratings(i,1),...
            LC_PR(nn).event_ratings(i,2),...
            LC_PR(nn).event_ratings(i,3),LC_PR(nn).event_ratings(i,4),LC_PR(nn).event_ratings(i,5),LC_PR(nn).event_ratings(i,6)];

        LC_PR(nn).risk(i,:) = pchipNew(LC_PR(nn).ratingTiming, ratings, LC_PR(nn).Time);
        LC_PR(nn).risk(i, LC_PR(nn).Time < LC_PR(nn).ratingTiming(1)) = ratings(1);
        LC_PR(nn).risk(i, LC_PR(nn).Time > LC_PR(nn).ratingTiming(end)) = ratings(end);
  end

end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');