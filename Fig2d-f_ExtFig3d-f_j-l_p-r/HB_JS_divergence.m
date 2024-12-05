%% load data
clc; clear; close all;
dir = '../Data/SubjectiveRatings.mat';
load(dir)
%% TS Markov, transition matrix and GMM training for HB


figure(1) % Rating transition matrix
for i = 1:27
sub_fig = subplot(5,6,i);
% eval(['event_temp','=','HB_event_',num2str(i),';']);
event_temp = HB_PR(i).event_ratings;
nb_participant = size(event_temp,1);
nb_timestep = size(event_temp,2);
markov_matrix = zeros(11,11);
nb_total = nb_participant*(nb_timestep-1);
for j = 1: nb_participant
    for k = 1: nb_timestep-1
      markov_matrix( event_temp(j,k)+1,event_temp(j,k+1)+1) = markov_matrix( event_temp(j,k)+1,event_temp(j,k+1)+1)+ 1;
    end
end
markov_matrix = markov_matrix/nb_total;
b = bar3(markov_matrix);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'XTickLabel',[0 1 2 3 4 5 6 7 8 9 10])
set(gca,'YTickLabel',[0 1 2 3 4 5 6 7 8 9 10])
xlabel('timestep t');
ylabel('timestep t+1');
zlim([0 0.3])
title(['event ', num2str(i)])
eval(['Z_data_',num2str(i),'=','markov_matrix',';']);

% GMM fitting
k = 1;
Z_data_scale = int8(markov_matrix*nb_total);
GMM_input = [];
for ii = 1:11
    for jj = 1:11
        temp = Z_data_scale(ii,jj);
        temp = repmat([ii-1,jj-1],[temp 1]);
        GMM_input = [GMM_input ; temp ];

    end
end


GMModel = fitgmdist(GMM_input, k);
y = [zeros(nb_total,1)];
hold on
gmPDF = @(x,y) arrayfun(@(x0,y0) pdf(GMModel,[x0 y0]),x,y);
g = gca;
eval(['gmPDF_',num2str(i),'=','gmPDF',';']);
eval(['GMModel_',num2str(i),'=','GMModel',';']);
end


figure(2) % Fitted GMM for rating transition matrix for all events
for i = 1:27
    subplot(5,6,i)
    eval(['gmPDF','=','gmPDF_',num2str(i),';']);
    fcontour(gmPDF,[0 11 0 11])
    xlim([0 11])
    ylim([0 11])
    title(['event ', num2str(i)])
end

for i=1:27
    eval(['determinent(i)=det(GMModel_',num2str(i),'.Sigma);']);   
end
close all;
%% KL, JS matrix computation
% figure(3)
color_limit = 5;  % do not forget to change 

KL_matrix_1 = zeros(27,27);
KL_matrix_2 = zeros(27,27);
JS_matrix = zeros(27,27);
for i = 1:27
    for j = 1:27
        eval(['GMModel_A','=','GMModel_',num2str(i),';']);
        eval(['GMModel_B','=','GMModel_',num2str(j),';']);
        KL_1 = mvgkl(GMModel_A.mu', GMModel_A.Sigma, GMModel_B.mu', GMModel_B.Sigma);
        KL_matrix_1(i,j) = KL_1;
        KL_2 = mvgkl(GMModel_B.mu', GMModel_B.Sigma, GMModel_A.mu', GMModel_A.Sigma);
        KL_matrix_2(i,j) = KL_2;
        
    end
end
JS_matrix = 0.5*KL_matrix_1 + 0.5*KL_matrix_2;

%% The effect of Single varaible JS comparison
%% Distance 
d_5 = [1 4 7 10 13 16 19 22 25];
d_15 = d_5 + 1;
d_25 = d_5 + 2;
JS_matrix_reordered = JS_matrix([d_5, d_15, d_25], [d_5, d_15, d_25]);

% Initialize a matrix to store the means of each block
means_distance = zeros(3, 3);

for i = 1:3
    for j = 1:3
        % Extract the block
        block = JS_matrix_reordered(1 + (i-1)*9:i*9, 1 + (j-1)*9:j*9);
        
        % Compute the mean of the block
        means_distance(i, j) = mean(block(:));
    end
end
% log_means = log(means - min(min(means)) + 1);
figure('Position',[400 75 550 500])
map = (linspace(1,0,100)'.*[231-18,242-124,248-194]+[18,124,194])/255;

% imagesc(log_means);
imagesc(means_distance);
colormap(map);
colorbar;
% title('JS Divergence for Distance');

% Adjust the aspect ratio
axis equal tight;

% Add edges for each block
hold on;
for i = 1:2
    line([i, i]+0.5, [0.5,3.5], 'Color', 'k', 'LineWidth', 1.5);
    line([0.5, 3.5], [i, i]+0.5, 'Color', 'k', 'LineWidth', 1.5);
end
hold off;
xticks([1 2 3])
xticklabels({'5 m','15 m','25 m'})

yticks([1 2 3])
yticklabels({'5 m','15 m','25 m'})
set(gca,'FontSize',20)

%% BI
BI_2 = [1:3,10:12,19:21];
BI_5 = BI_2 + 3;
BI_8 = BI_5 + 3;
JS_matrix_reordered = JS_matrix([BI_2, BI_5, BI_8], [BI_2, BI_5, BI_8]);

% Initialize a matrix to store the means of each block
means_BI = zeros(3, 3);

for i = 1:3
    for j = 1:3
        % Extract the block
        block = JS_matrix_reordered(1 + (i-1)*9:i*9, 1 + (j-1)*9:j*9);
        
        % Compute the mean of the block
        means_BI(i, j) = mean(block(:));
    end
end
% log_means = log(means - min(min(means)) + 1);
figure('Position',[400 75 550 500])
map = (linspace(1,0,100)'.*[231-18,242-124,248-194]+[18,124,194])/255;

% imagesc(log_means);
imagesc(means_BI);
colormap(map);
colorbar;
% title('JS Divergence for BI');

% Adjust the aspect ratio
axis equal tight;

% Add edges for each block
hold on;
for i = 1:2
    line([i, i]+0.5, [0.5,3.5], 'Color', 'k', 'LineWidth', 1.5);
    line([0.5, 3.5], [i, i]+0.5, 'Color', 'k', 'LineWidth', 1.5);
end
hold off;
xticks([1 2 3])
xticklabels({'-2 m/s^2','-5 m/s^2','-8 m/s^2'})

yticks([1 2 3])
yticklabels({'-2 m/s^2','-5 m/s^2','-8 m/s^2'})
set(gca,'FontSize',20)

%% Speed
v_80 = 1:9;
v_100 = 10:18;
v_120 = 19:27;
JS_matrix_reordered = JS_matrix([v_80, v_100, v_120], [v_80, v_100, v_120]);

% Initialize a matrix to store the means of each block
means_speed = zeros(3, 3);

for i = 1:3
    for j = 1:3
        % Extract the block
        block = JS_matrix_reordered(1 + (i-1)*9:i*9, 1 + (j-1)*9:j*9);
        
        % Compute the mean of the block
        means_speed(i, j) = mean(block(:));
    end
end
% log_means = log(means - min(min(means)) + 1);
figure('Position',[400 75 550 500])
map = (linspace(1,0,100)'.*[231-18,242-124,248-194]+[18,124,194])/255;

% imagesc(log_means);
imagesc(means_speed);
colormap(map);
colorbar;
% title('JS Divergence for Speed');

% Adjust the aspect ratio
axis equal tight;

% Add edges for each block
hold on;
for i = 1:2
    line([i, i]+0.5, [0.5,3.5], 'Color', 'k', 'LineWidth', 1.5);
    line([0.5, 3.5], [i, i]+0.5, 'Color', 'k', 'LineWidth', 1.5);
end
hold off;
xticks([1 2 3])
xticklabels({'80 km/h','100 km/h','120 km/h'})

yticks([1 2 3])
yticklabels({'80 km/h','100 km/h','120 km/h'})
set(gca,'FontSize',20)
