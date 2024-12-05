% This function is to calculate the percentile 5th, 25
% th, 50th, 75th, 95th
% of perceived risk ratings.
% This will generate the fields risk_p5, risk_p25, risk_p50, risk_p75,
% risk_95, risk_p25_p75_mean of MB_PR, HB_PR, LC_PR and SVM_PR of
% SubjectiveRatings.mat.
%% load data
clc;clear;close all;
dir = '../../Data/SubjectiveRatings.mat';
load(dir);

%% LC
for i = 1:24
    ratings_temp = LC_PR(i).event_ratings;
    for j = 1: 6
    ratings_p5(j) = prctile(ratings_temp(:, j), 5);
    ratings_p25(j) = prctile(ratings_temp(:, j), 25);
    ratings_p50(j) = prctile(ratings_temp(:, j), 50);
    ratings_p75(j) = prctile(ratings_temp(:, j), 75);
    ratings_p95(j) = prctile(ratings_temp(:, j), 95);
    ratings_25_75(j) = mean(ratings_temp(ratings_temp >= ratings_p25(j)& ratings_temp <= ratings_p75(j)));
    end
    
    LC_PR(i).ratings_p5 = ratings_p5;
    LC_PR(i).ratings_p25 = ratings_p25;
    LC_PR(i).ratings_p50 = ratings_p50;
    LC_PR(i).ratings_p75 = ratings_p75;
    LC_PR(i).ratings_p95 = ratings_p95;
    LC_PR(i).ratings_p25_p75_mean = ratings_25_75;
end
figure;
tl_LC = tiledlayout(4,6);
for i = 1:24
%     subplot(4, 6, i);
    nexttile(tl_LC)
    plot(LC_PR(i).ratings_p5, 'r-');hold on;
    plot(LC_PR(i).ratings_p25, 'g-');
    plot(LC_PR(i).ratings_p50, 'b-');
    plot(LC_PR(i).ratings_p75, 'k-');
    plot(LC_PR(i).ratings_p95, 'c-');
    plot(LC_PR(i).ratings_p25_p75_mean, 'm-');
    xlabel('clip');
    ylabel('Perceived risk Ratings');
    title(num2str(i));
%     if i == 1
%         legend('p5','p25','p50','p75','p95');
%     end
end
    sgtitle('LC');
%% SVM
    ratings_p5 = [];
    ratings_p25  = [];
    ratings_p50  = [];
    ratings_p75 = [];
    ratings_p95 = [];
    ratings_25_75 = [];
for i = 1:27
    ratings_temp = SVM_PR(i).event_ratings;
    for j = 1: 5
    ratings_p5(j) = prctile(ratings_temp(:, j), 5);
    ratings_p25(j) = prctile(ratings_temp(:, j), 25);
    ratings_p50(j) = prctile(ratings_temp(:, j), 50);
    ratings_p75(j) = prctile(ratings_temp(:, j), 75);
    ratings_p95(j) = prctile(ratings_temp(:, j), 95);
    ratings_25_75(j) = mean(ratings_temp(ratings_temp >= ratings_p25(j)& ratings_temp <= ratings_p75(j)));
    end
    SVM_PR(i).ratings_p5 = ratings_p5;
    SVM_PR(i).ratings_p25 = ratings_p25;
    SVM_PR(i).ratings_p50 = ratings_p50;
    SVM_PR(i).ratings_p75 = ratings_p75;
    SVM_PR(i).ratings_p95 = ratings_p95;
    SVM_PR(i).ratings_p25_p75_mean = ratings_25_75;
end
figure;
tl_SVM = tiledlayout(5,6);
for i = 1:27
%     subplot(4, 6, i);
    nexttile(tl_SVM)
    plot(SVM_PR(i).ratings_p5, 'r-');hold on;
    plot(SVM_PR(i).ratings_p25, 'g-');
    plot(SVM_PR(i).ratings_p50, 'b-');
    plot(SVM_PR(i).ratings_p75, 'k-');
    plot(SVM_PR(i).ratings_p95, 'c-');
    plot(SVM_PR(i).ratings_p25_p75_mean, 'm-');
    xlabel('clip');
    ylabel('Perceived risk Ratings');
    title(num2str(i));
%     if i == 1
%         legend('p5','p25','p50','p75','p95');
%     end
end
    sgtitle('SVM');
%% HB
    ratings_p5 = [];
    ratings_p25  = [];
    ratings_p50  = [];
    ratings_p75 = [];
    ratings_p95 = [];
    ratings_25_75 = [];
for i = 1:27
    ratings_temp = HB_PR(i).event_ratings;
    for j = 1: 5
    ratings_p5(j) = prctile(ratings_temp(:, j), 5);
    ratings_p25(j) = prctile(ratings_temp(:, j), 25);
    ratings_p50(j) = prctile(ratings_temp(:, j), 50);
    ratings_p75(j) = prctile(ratings_temp(:, j), 75);
    ratings_p95(j) = prctile(ratings_temp(:, j), 95);
    ratings_25_75(j) = mean(ratings_temp(ratings_temp >= ratings_p25(j)& ratings_temp <= ratings_p75(j)));
    end
    HB_PR(i).ratings_p5 = ratings_p5;
    HB_PR(i).ratings_p25 = ratings_p25;
    HB_PR(i).ratings_p50 = ratings_p50;
    HB_PR(i).ratings_p75 = ratings_p75;
    HB_PR(i).ratings_p95 = ratings_p95;
    HB_PR(i).ratings_p25_p75_mean = ratings_25_75;
end
figure;
tl_HB = tiledlayout(5,6);
for i = 1:27
%     subplot(4, 6, i);
    nexttile(tl_HB)
    plot(HB_PR(i).ratings_p5, 'r-');hold on;
    plot(HB_PR(i).ratings_p25, 'g-');
    plot(HB_PR(i).ratings_p50, 'b-');
    plot(HB_PR(i).ratings_p75, 'k-');
    plot(HB_PR(i).ratings_p95, 'c-');
    xlabel('clip');
    ylabel('Perceived risk Ratings');
    title(num2str(i));
%     if i == 1
%         legend('p5','p25','p50','p75','p95');
%     end
end
    sgtitle('HB');
%% MB
    ratings_p5 = [];
    ratings_p25  = [];
    ratings_p50  = [];
    ratings_p75 = [];
    ratings_p95 = [];
    ratings_25_75 = [];
for i = 1:27
    ratings_temp = MB_PR(i).event_ratings;
    for j = 1: 5
    ratings_p5(j) = prctile(ratings_temp(:, j), 5);
    ratings_p25(j) = prctile(ratings_temp(:, j), 25);
    ratings_p50(j) = prctile(ratings_temp(:, j), 50);
    ratings_p75(j) = prctile(ratings_temp(:, j), 75);
    ratings_p95(j) = prctile(ratings_temp(:, j), 95);
    ratings_25_75(j) = mean(ratings_temp(ratings_temp >= ratings_p25(j)& ratings_temp <= ratings_p75(j)));
    end
    MB_PR(i).ratings_p5 = ratings_p5;
    MB_PR(i).ratings_p25 = ratings_p25;
    MB_PR(i).ratings_p50 = ratings_p50;
    MB_PR(i).ratings_p75 = ratings_p75;
    MB_PR(i).ratings_p95 = ratings_p95;
    MB_PR(i).ratings_p25_p75_mean = ratings_25_75;
end
figure;
tl_MB = tiledlayout(5,6);
for i = 1:27
%     subplot(4, 6, i);
    nexttile(tl_MB)
    plot(MB_PR(i).ratings_p5, 'r-');hold on;
    plot(MB_PR(i).ratings_p25, 'g-');
    plot(MB_PR(i).ratings_p50, 'b-');
    plot(MB_PR(i).ratings_p75, 'k-');
    plot(MB_PR(i).ratings_p95, 'c-');
    xlabel('clip');
    ylabel('Perceived risk Ratings');
    title(num2str(i));
%     if i == 1
%         legend('p5','p25','p50','p75','p95');
%     end
end
    sgtitle('MB');
%% save the data
% save(dir, 'SVM_PR', 'LC_PR', 'HB_PR', 'MB_PR');

