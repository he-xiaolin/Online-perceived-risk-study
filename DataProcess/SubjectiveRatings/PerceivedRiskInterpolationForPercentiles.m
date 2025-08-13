% This function is to interpolate the continuous perceived risk by
% connecting 5th, 25th, 50th, 75th and 95th percentile based on rating time
% in the field of 'ratingTiming'.
%% MB
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
addpath('functionLibrary/');

for nn=1:27
    Ratings_p5 = [MB_PR(nn).ratings_p5(1), MB_PR(nn).ratings_p5(1),...
        MB_PR(nn).ratings_p5(2), MB_PR(nn).ratings_p5(2),...
        MB_PR(nn).ratings_p5(3),MB_PR(nn).ratings_p5(4),MB_PR(nn).ratings_p5(5)];
    MB_PR(nn).risk_p5 = pchipNew(MB_PR(nn).ratingTiming, Ratings_p5, MB_PR(nn).Time);
    MB_PR(nn).risk_p5(MB_PR(nn).Time<MB_PR(nn).ratingTiming(1)) = MB_PR(nn).ratings_p5(1);
    MB_PR(nn).risk_p5(MB_PR(nn).Time>MB_PR(nn).ratingTiming(end)) = MB_PR(nn).ratings_p5(end);

    Ratings_p25 = [MB_PR(nn).ratings_p25(1), MB_PR(nn).ratings_p25(1),...
        MB_PR(nn).ratings_p25(2), MB_PR(nn).ratings_p25(2),...
        MB_PR(nn).ratings_p25(3),MB_PR(nn).ratings_p25(4),MB_PR(nn).ratings_p25(5)];
    MB_PR(nn).risk_p25 = pchipNew(MB_PR(nn).ratingTiming, Ratings_p25, MB_PR(nn).Time);
    MB_PR(nn).risk_p25(MB_PR(nn).Time<MB_PR(nn).ratingTiming(1)) = MB_PR(nn).ratings_p25(1);
    MB_PR(nn).risk_p25(MB_PR(nn).Time>MB_PR(nn).ratingTiming(end)) = MB_PR(nn).ratings_p25(end);

    Ratings_p50 = [MB_PR(nn).ratings_p50(1), MB_PR(nn).ratings_p50(1),...
        MB_PR(nn).ratings_p50(2), MB_PR(nn).ratings_p50(2),...
        MB_PR(nn).ratings_p50(3),MB_PR(nn).ratings_p50(4),MB_PR(nn).ratings_p50(5)];
    MB_PR(nn).risk_p50 = pchipNew(MB_PR(nn).ratingTiming, Ratings_p50, MB_PR(nn).Time);
    MB_PR(nn).risk_p50(MB_PR(nn).Time<MB_PR(nn).ratingTiming(1)) = MB_PR(nn).ratings_p50(1);
    MB_PR(nn).risk_p50(MB_PR(nn).Time>MB_PR(nn).ratingTiming(end)) = MB_PR(nn).ratings_p50(end);

    Ratings_p75 = [MB_PR(nn).ratings_p75(1), MB_PR(nn).ratings_p75(1),...
        MB_PR(nn).ratings_p75(2), MB_PR(nn).ratings_p75(2),...
        MB_PR(nn).ratings_p75(3),MB_PR(nn).ratings_p75(4),MB_PR(nn).ratings_p75(5)];
    MB_PR(nn).risk_p75 = pchipNew(MB_PR(nn).ratingTiming, Ratings_p75, MB_PR(nn).Time);
    MB_PR(nn).risk_p75(MB_PR(nn).Time<MB_PR(nn).ratingTiming(1)) = MB_PR(nn).ratings_p75(1);
    MB_PR(nn).risk_p75(MB_PR(nn).Time>MB_PR(nn).ratingTiming(end)) = MB_PR(nn).ratings_p75(end);

    Ratings_p95 = [MB_PR(nn).ratings_p95(1), MB_PR(nn).ratings_p95(1),...
        MB_PR(nn).ratings_p95(2), MB_PR(nn).ratings_p95(2),...
        MB_PR(nn).ratings_p95(3),MB_PR(nn).ratings_p95(4),MB_PR(nn).ratings_p95(5)];
    MB_PR(nn).risk_p95 = pchipNew(MB_PR(nn).ratingTiming, Ratings_p95, MB_PR(nn).Time);
    MB_PR(nn).risk_p95(MB_PR(nn).Time<MB_PR(nn).ratingTiming(1)) = MB_PR(nn).ratings_p95(1);
    MB_PR(nn).risk_p95(MB_PR(nn).Time>MB_PR(nn).ratingTiming(end)) = MB_PR(nn).ratings_p95(end);

    Ratings_p25_p75_mean = [MB_PR(nn).ratings_p25_p75_mean(1), MB_PR(nn).ratings_p25_p75_mean(1),...
        MB_PR(nn).ratings_p25_p75_mean(2), MB_PR(nn).ratings_p25_p75_mean(2),...
        MB_PR(nn).ratings_p25_p75_mean(3),MB_PR(nn).ratings_p25_p75_mean(4),MB_PR(nn).ratings_p25_p75_mean(5)];
    MB_PR(nn).risk_p25_p75_mean = pchipNew(MB_PR(nn).ratingTiming, Ratings_p25_p75_mean, MB_PR(nn).Time);
    MB_PR(nn).risk_p25_p75_mean(MB_PR(nn).Time<MB_PR(nn).ratingTiming(1)) = MB_PR(nn).ratings_p25_p75_mean(1);
    MB_PR(nn).risk_p25_p75_mean(MB_PR(nn).Time>MB_PR(nn).ratingTiming(end)) = MB_PR(nn).ratings_p25_p75_mean(end);
end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');
%% HB
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
addpath('functionLibrary/');

for nn=1:27
    Ratings_p5 = [HB_PR(nn).ratings_p5(1), HB_PR(nn).ratings_p5(1),...
        HB_PR(nn).ratings_p5(2), HB_PR(nn).ratings_p5(2),...
        HB_PR(nn).ratings_p5(3),HB_PR(nn).ratings_p5(4),HB_PR(nn).ratings_p5(5)];
    HB_PR(nn).risk_p5 = pchipNew(HB_PR(nn).ratingTiming, Ratings_p5, HB_PR(nn).Time);
    HB_PR(nn).risk_p5(HB_PR(nn).Time<HB_PR(nn).ratingTiming(1)) = HB_PR(nn).ratings_p5(1);
    HB_PR(nn).risk_p5(HB_PR(nn).Time>HB_PR(nn).ratingTiming(end)) = HB_PR(nn).ratings_p5(end);

    Ratings_p25 = [HB_PR(nn).ratings_p25(1), HB_PR(nn).ratings_p25(1),...
        HB_PR(nn).ratings_p25(2), HB_PR(nn).ratings_p25(2),...
        HB_PR(nn).ratings_p25(3),HB_PR(nn).ratings_p25(4),HB_PR(nn).ratings_p25(5)];
    HB_PR(nn).risk_p25 = pchipNew(HB_PR(nn).ratingTiming, Ratings_p25, HB_PR(nn).Time);
    HB_PR(nn).risk_p25(HB_PR(nn).Time<HB_PR(nn).ratingTiming(1)) = HB_PR(nn).ratings_p25(1);
    HB_PR(nn).risk_p25(HB_PR(nn).Time>HB_PR(nn).ratingTiming(end)) = HB_PR(nn).ratings_p25(end);

    Ratings_p50 = [HB_PR(nn).ratings_p50(1), HB_PR(nn).ratings_p50(1),...
        HB_PR(nn).ratings_p50(2), HB_PR(nn).ratings_p50(2),...
        HB_PR(nn).ratings_p50(3),HB_PR(nn).ratings_p50(4),HB_PR(nn).ratings_p50(5)];
    HB_PR(nn).risk_p50 = pchipNew(HB_PR(nn).ratingTiming, Ratings_p50, HB_PR(nn).Time);
    HB_PR(nn).risk_p50(HB_PR(nn).Time<HB_PR(nn).ratingTiming(1)) = HB_PR(nn).ratings_p50(1);
    HB_PR(nn).risk_p50(HB_PR(nn).Time>HB_PR(nn).ratingTiming(end)) = HB_PR(nn).ratings_p50(end);

    Ratings_p75 = [HB_PR(nn).ratings_p75(1), HB_PR(nn).ratings_p75(1),...
        HB_PR(nn).ratings_p75(2), HB_PR(nn).ratings_p75(2),...
        HB_PR(nn).ratings_p75(3),HB_PR(nn).ratings_p75(4),HB_PR(nn).ratings_p75(5)];
    HB_PR(nn).risk_p75 = pchipNew(HB_PR(nn).ratingTiming, Ratings_p75, HB_PR(nn).Time);
    HB_PR(nn).risk_p75(HB_PR(nn).Time<HB_PR(nn).ratingTiming(1)) = HB_PR(nn).ratings_p75(1);
    HB_PR(nn).risk_p75(HB_PR(nn).Time>HB_PR(nn).ratingTiming(end)) = HB_PR(nn).ratings_p75(end);

    Ratings_p95 = [HB_PR(nn).ratings_p95(1), HB_PR(nn).ratings_p95(1),...
        HB_PR(nn).ratings_p95(2), HB_PR(nn).ratings_p95(2),...
        HB_PR(nn).ratings_p95(3),HB_PR(nn).ratings_p95(4),HB_PR(nn).ratings_p95(5)];
    HB_PR(nn).risk_p95 = pchipNew(HB_PR(nn).ratingTiming, Ratings_p95, HB_PR(nn).Time);
    HB_PR(nn).risk_p95(HB_PR(nn).Time<HB_PR(nn).ratingTiming(1)) = HB_PR(nn).ratings_p95(1);
    HB_PR(nn).risk_p95(HB_PR(nn).Time>HB_PR(nn).ratingTiming(end)) = HB_PR(nn).ratings_p95(end);

     Ratings_p25_p75_mean = [HB_PR(nn).ratings_p25_p75_mean(1), HB_PR(nn).ratings_p25_p75_mean(1),...
        HB_PR(nn).ratings_p25_p75_mean(2), HB_PR(nn).ratings_p25_p75_mean(2),...
        HB_PR(nn).ratings_p25_p75_mean(3),HB_PR(nn).ratings_p25_p75_mean(4),HB_PR(nn).ratings_p25_p75_mean(5)];
    HB_PR(nn).risk_p25_p75_mean = pchipNew(HB_PR(nn).ratingTiming, Ratings_p25_p75_mean, HB_PR(nn).Time);
    HB_PR(nn).risk_p25_p75_mean(HB_PR(nn).Time<HB_PR(nn).ratingTiming(1)) = HB_PR(nn).ratings_p25_p75_mean(1);
    HB_PR(nn).risk_p25_p75_mean(HB_PR(nn).Time>HB_PR(nn).ratingTiming(end)) = HB_PR(nn).ratings_p25_p75_mean(end);
end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');
%% SVM
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
addpath('functionLibrary/');

for nn=1:27
    Ratings_p5 = [SVM_PR(nn).ratings_p5(1), SVM_PR(nn).ratings_p5(1),...
        SVM_PR(nn).ratings_p5(2), SVM_PR(nn).ratings_p5(2),...
        SVM_PR(nn).ratings_p5(3),SVM_PR(nn).ratings_p5(4),SVM_PR(nn).ratings_p5(5)];
    SVM_PR(nn).risk_p5 = pchipNew(SVM_PR(nn).ratingTiming, Ratings_p5, SVM_PR(nn).Time);
    SVM_PR(nn).risk_p5(SVM_PR(nn).Time<SVM_PR(nn).ratingTiming(1)) = SVM_PR(nn).ratings_p5(1);
    SVM_PR(nn).risk_p5(SVM_PR(nn).Time>SVM_PR(nn).ratingTiming(end)) = SVM_PR(nn).ratings_p5(end);

    Ratings_p25 = [SVM_PR(nn).ratings_p25(1), SVM_PR(nn).ratings_p25(1),...
        SVM_PR(nn).ratings_p25(2), SVM_PR(nn).ratings_p25(2),...
        SVM_PR(nn).ratings_p25(3),SVM_PR(nn).ratings_p25(4),SVM_PR(nn).ratings_p25(5)];
    SVM_PR(nn).risk_p25 = pchipNew(SVM_PR(nn).ratingTiming, Ratings_p25, SVM_PR(nn).Time);
    SVM_PR(nn).risk_p25(SVM_PR(nn).Time<SVM_PR(nn).ratingTiming(1)) = SVM_PR(nn).ratings_p25(1);
    SVM_PR(nn).risk_p25(SVM_PR(nn).Time>SVM_PR(nn).ratingTiming(end)) = SVM_PR(nn).ratings_p25(end);

    Ratings_p50 = [SVM_PR(nn).ratings_p50(1), SVM_PR(nn).ratings_p50(1),...
        SVM_PR(nn).ratings_p50(2), SVM_PR(nn).ratings_p50(2),...
        SVM_PR(nn).ratings_p50(3),SVM_PR(nn).ratings_p50(4),SVM_PR(nn).ratings_p50(5)];
    SVM_PR(nn).risk_p50 = pchipNew(SVM_PR(nn).ratingTiming, Ratings_p50, SVM_PR(nn).Time);
    SVM_PR(nn).risk_p50(SVM_PR(nn).Time<SVM_PR(nn).ratingTiming(1)) = SVM_PR(nn).ratings_p50(1);
    SVM_PR(nn).risk_p50(SVM_PR(nn).Time>SVM_PR(nn).ratingTiming(end)) = SVM_PR(nn).ratings_p50(end);

    Ratings_p75 = [SVM_PR(nn).ratings_p75(1), SVM_PR(nn).ratings_p75(1),...
        SVM_PR(nn).ratings_p75(2), SVM_PR(nn).ratings_p75(2),...
        SVM_PR(nn).ratings_p75(3),SVM_PR(nn).ratings_p75(4),SVM_PR(nn).ratings_p75(5)];
    SVM_PR(nn).risk_p75 = pchipNew(SVM_PR(nn).ratingTiming, Ratings_p75, SVM_PR(nn).Time);
    SVM_PR(nn).risk_p75(SVM_PR(nn).Time<SVM_PR(nn).ratingTiming(1)) = SVM_PR(nn).ratings_p75(1);
    SVM_PR(nn).risk_p75(SVM_PR(nn).Time>SVM_PR(nn).ratingTiming(end)) = SVM_PR(nn).ratings_p75(end);

    Ratings_p95 = [SVM_PR(nn).ratings_p95(1), SVM_PR(nn).ratings_p95(1),...
        SVM_PR(nn).ratings_p95(2), SVM_PR(nn).ratings_p95(2),...
        SVM_PR(nn).ratings_p95(3),SVM_PR(nn).ratings_p95(4),SVM_PR(nn).ratings_p95(5)];
    SVM_PR(nn).risk_p95 = pchipNew(SVM_PR(nn).ratingTiming, Ratings_p95, SVM_PR(nn).Time);
    SVM_PR(nn).risk_p95(SVM_PR(nn).Time<SVM_PR(nn).ratingTiming(1)) = SVM_PR(nn).ratings_p95(1);
    SVM_PR(nn).risk_p95(SVM_PR(nn).Time>SVM_PR(nn).ratingTiming(end)) = SVM_PR(nn).ratings_p95(end);

    Ratings_p25_p75_mean = [SVM_PR(nn).ratings_p25_p75_mean(1), SVM_PR(nn).ratings_p25_p75_mean(1),...
        SVM_PR(nn).ratings_p25_p75_mean(2), SVM_PR(nn).ratings_p25_p75_mean(2),...
        SVM_PR(nn).ratings_p25_p75_mean(3),SVM_PR(nn).ratings_p25_p75_mean(4),SVM_PR(nn).ratings_p25_p75_mean(5)];
    SVM_PR(nn).risk_p25_p75_mean = pchipNew(SVM_PR(nn).ratingTiming, Ratings_p25_p75_mean, SVM_PR(nn).Time);
    SVM_PR(nn).risk_p25_p75_mean(SVM_PR(nn).Time<SVM_PR(nn).ratingTiming(1)) = SVM_PR(nn).ratings_p25_p75_mean(1);
    SVM_PR(nn).risk_p25_p75_mean(SVM_PR(nn).Time>SVM_PR(nn).ratingTiming(end)) = SVM_PR(nn).ratings_p25_p75_mean(end);
end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');
%% LC
clear; clc; close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
addpath('functionLibrary/');

for nn=1:18 % lane change (normal) and lane change (fragmented)
    Ratings_p5 = [LC_PR(nn).ratings_p5(1), ...
        LC_PR(nn).ratings_p5(2), ...
        LC_PR(nn).ratings_p5(3),LC_PR(nn).ratings_p5(4),LC_PR(nn).ratings_p5(5),LC_PR(nn).ratings_p5(6)];
    LC_PR(nn).risk_p5 = pchip(LC_PR(nn).ratingTiming, Ratings_p5, LC_PR(nn).Time);
    LC_PR(nn).risk_p5(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p5(1);
    LC_PR(nn).risk_p5(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p5(end);

    Ratings_p25 = [LC_PR(nn).ratings_p25(1), ...
        LC_PR(nn).ratings_p25(2),...
        LC_PR(nn).ratings_p25(3),LC_PR(nn).ratings_p25(4),LC_PR(nn).ratings_p25(5),LC_PR(nn).ratings_p25(6)];
    LC_PR(nn).risk_p25 = pchip(LC_PR(nn).ratingTiming, Ratings_p25, LC_PR(nn).Time);
    LC_PR(nn).risk_p25(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p25(1);
    LC_PR(nn).risk_p25(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p25(end);

    Ratings_p50 = [LC_PR(nn).ratings_p50(1), ...
        LC_PR(nn).ratings_p50(2), ...
        LC_PR(nn).ratings_p50(3),LC_PR(nn).ratings_p50(4),LC_PR(nn).ratings_p50(5),LC_PR(nn).ratings_p50(6)];
    LC_PR(nn).risk_p50 = pchip(LC_PR(nn).ratingTiming, Ratings_p50, LC_PR(nn).Time);
    LC_PR(nn).risk_p50(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p50(1);
    LC_PR(nn).risk_p50(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p50(end);

    Ratings_p75 = [LC_PR(nn).ratings_p75(1), ...
        LC_PR(nn).ratings_p75(2), ...
        LC_PR(nn).ratings_p75(3),LC_PR(nn).ratings_p75(4),LC_PR(nn).ratings_p75(5),LC_PR(nn).ratings_p75(6)];
    LC_PR(nn).risk_p75 = pchip(LC_PR(nn).ratingTiming, Ratings_p75, LC_PR(nn).Time);
    LC_PR(nn).risk_p75(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p75(1);
    LC_PR(nn).risk_p75(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p75(end);

    Ratings_p95 = [LC_PR(nn).ratings_p95(1), ...
        LC_PR(nn).ratings_p95(2), ...
        LC_PR(nn).ratings_p95(3),LC_PR(nn).ratings_p95(4),LC_PR(nn).ratings_p95(5),LC_PR(nn).ratings_p95(6)];
    LC_PR(nn).risk_p95 = pchip(LC_PR(nn).ratingTiming, Ratings_p95, LC_PR(nn).Time);
    LC_PR(nn).risk_p95(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p95(1);
    LC_PR(nn).risk_p95(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p95(end);

    Ratings_p25_p75_mean = [LC_PR(nn).ratings_p25_p75_mean(1), ...
        LC_PR(nn).ratings_p25_p75_mean(2), ...
        LC_PR(nn).ratings_p25_p75_mean(3),LC_PR(nn).ratings_p25_p75_mean(4),LC_PR(nn).ratings_p25_p75_mean(5),LC_PR(nn).ratings_p25_p75_mean(6)];
    LC_PR(nn).risk_p25_p75_mean = pchip(LC_PR(nn).ratingTiming, Ratings_p25_p75_mean, LC_PR(nn).Time);
    LC_PR(nn).risk_p25_p75_mean(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p25_p75_mean(1);
    LC_PR(nn).risk_p25_p75_mean(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p25_p75_mean(end);
end

for nn=19:24 % lane change (aborted)
    Ratings_p5 = [LC_PR(nn).ratings_p5(1), ...
        LC_PR(nn).ratings_p5(2), ...
        LC_PR(nn).ratings_p5(3),LC_PR(nn).ratings_p5(4),LC_PR(nn).ratings_p5(5),LC_PR(nn).ratings_p5(5), LC_PR(nn).ratings_p5(6)];
    LC_PR(nn).risk_p5 = pchip(LC_PR(nn).ratingTiming, Ratings_p5, LC_PR(nn).Time);
    LC_PR(nn).risk_p5(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p5(1);
    LC_PR(nn).risk_p5(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p5(end);

    Ratings_p25 = [LC_PR(nn).ratings_p25(1), ...
        LC_PR(nn).ratings_p25(2),...
        LC_PR(nn).ratings_p25(3),LC_PR(nn).ratings_p25(4),LC_PR(nn).ratings_p25(5),LC_PR(nn).ratings_p25(5),LC_PR(nn).ratings_p25(6)];
    LC_PR(nn).risk_p25 = pchip(LC_PR(nn).ratingTiming, Ratings_p25, LC_PR(nn).Time);
    LC_PR(nn).risk_p25(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p25(1);
    LC_PR(nn).risk_p25(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p25(end);

    Ratings_p50 = [LC_PR(nn).ratings_p50(1), ...
        LC_PR(nn).ratings_p50(2), ...
        LC_PR(nn).ratings_p50(3),LC_PR(nn).ratings_p50(4),LC_PR(nn).ratings_p50(5),LC_PR(nn).ratings_p50(5),LC_PR(nn).ratings_p50(6)];
    LC_PR(nn).risk_p50 = pchip(LC_PR(nn).ratingTiming, Ratings_p50, LC_PR(nn).Time);
    LC_PR(nn).risk_p50(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p50(1);
    LC_PR(nn).risk_p50(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p50(end);

    Ratings_p75 = [LC_PR(nn).ratings_p75(1), ...
        LC_PR(nn).ratings_p75(2), ...
        LC_PR(nn).ratings_p75(3),LC_PR(nn).ratings_p75(4),LC_PR(nn).ratings_p75(5),LC_PR(nn).ratings_p75(5),LC_PR(nn).ratings_p75(6)];
    LC_PR(nn).risk_p75 = pchip(LC_PR(nn).ratingTiming, Ratings_p75, LC_PR(nn).Time);
    LC_PR(nn).risk_p75(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p75(1);
    LC_PR(nn).risk_p75(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p75(end);

    Ratings_p95 = [LC_PR(nn).ratings_p95(1), ...
        LC_PR(nn).ratings_p95(2), ...
        LC_PR(nn).ratings_p95(3),LC_PR(nn).ratings_p95(4),LC_PR(nn).ratings_p95(5),LC_PR(nn).ratings_p95(5),LC_PR(nn).ratings_p95(6)];
    LC_PR(nn).risk_p95 = pchip(LC_PR(nn).ratingTiming, Ratings_p95, LC_PR(nn).Time);
    LC_PR(nn).risk_p95(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p95(1);
    LC_PR(nn).risk_p95(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p95(end);

    Ratings_p25_p75_mean = [LC_PR(nn).ratings_p25_p75_mean(1), ...
        LC_PR(nn).ratings_p25_p75_mean(2), ...
        LC_PR(nn).ratings_p25_p75_mean(3),LC_PR(nn).ratings_p25_p75_mean(4),LC_PR(nn).ratings_p25_p75_mean(5),LC_PR(nn).ratings_p25_p75_mean(5),LC_PR(nn).ratings_p25_p75_mean(6)];
    LC_PR(nn).risk_p25_p75_mean = pchip(LC_PR(nn).ratingTiming, Ratings_p25_p75_mean, LC_PR(nn).Time);
    LC_PR(nn).risk_p25_p75_mean(LC_PR(nn).Time<LC_PR(nn).ratingTiming(1)) = LC_PR(nn).ratings_p25_p75_mean(1);
    LC_PR(nn).risk_p25_p75_mean(LC_PR(nn).Time>LC_PR(nn).ratingTiming(end)) = LC_PR(nn).ratings_p25_p75_mean(end);
end

% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');