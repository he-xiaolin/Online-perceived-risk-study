% This function is to remove the rating series for an event, which has a
% weak correlationship with the event average (r<0.3). 
% 
% That function generates the first two fields (event_ratings and idx) for 
% each of the scenarios within SubjectiveRatings.mat

% SubjectiveRatings_raw.mat contains ratings of 2164
% participants without selection.

clear;clc;close all
dir='./SubjectiveRatings_raw.mat';
load(dir);
%% MB
for i = 1:27
    ratings_temp = MB_PR(i).event_ratings;
    ratings_mean = mean(ratings_temp);
    [row, col] = size(ratings_temp);
    corcoeff = corr(ratings_temp',ratings_mean');
    idx_eliminated = find(corcoeff<0.3);
    idx_NaN = find(isnan(corcoeff));
    MB_PR(i).event_ratings([idx_eliminated;idx_NaN],:) = [];
    MB_PR(i).idx([idx_eliminated;idx_NaN],:) = [];
end
%% HB
for i = 1:27
    ratings_temp = HB_PR(i).event_ratings;
    ratings_mean = mean(ratings_temp);
    [row, col] = size(ratings_temp);
    corcoeff = corr(ratings_temp',ratings_mean');
    idx_eliminated = find(corcoeff<0.3);
    idx_NaN = find(isnan(corcoeff));
    HB_PR(i).event_ratings([idx_eliminated;idx_NaN],:) = [];
    HB_PR(i).idx([idx_eliminated;idx_NaN],:) = [];

end
%% LC
for i = 1:24
    ratings_temp = LC_PR(i).event_ratings;
    ratings_mean = mean(ratings_temp);
    [row, col] = size(ratings_temp);
    corcoeff = corr(ratings_temp',ratings_mean');
    idx_eliminated = find(corcoeff<0.3);
    idx_NaN = find(isnan(corcoeff));
    LC_PR(i).event_ratings([idx_eliminated;idx_NaN],:) = [];
    LC_PR(i).idx([idx_eliminated;idx_NaN],:) = [];
end
%% SVM
for i = 1:27
    ratings_temp = SVM_PR(i).event_ratings;
    ratings_mean = mean(ratings_temp);
    [row, col] = size(ratings_temp);
    corcoeff = corr(ratings_temp',ratings_mean');
    idx_eliminated = find(corcoeff<0.3);
    idx_NaN = find(isnan(corcoeff));
    SVM_PR(i).event_ratings([idx_eliminated;idx_NaN],:) = [];
    SVM_PR(i).idx([idx_eliminated;idx_NaN],:) = [];
end
