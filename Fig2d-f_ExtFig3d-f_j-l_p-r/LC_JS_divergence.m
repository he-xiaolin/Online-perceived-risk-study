%% load data
clc; clear; close all;
dir = '../Data/SubjectiveRatings.mat';
load(dir)
%% TS Markov, transition matrix and GMM training for LC

figure(1) % Rating transition matrix
for i = 1:24
sub_fig = subplot(4,6,i);
event_temp = LC_PR(i).event_ratings;
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
zlim([0 0.25])
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
for i = 1:24
    subplot(4,6,i)
    eval(['gmPDF','=','gmPDF_',num2str(i),';']);
    title(['Event ',num2str(i)]);
    fcontour(gmPDF,[0 11 0 11])
    xlim([0 11])
    ylim([0 11])

end

for i=1:24
    eval(['determinent(i)=det(GMModel_',num2str(i),'.Sigma);']);   
end
close all;
%% KL, JS matrx computation
color_limit = 1;

KL_matrix_1 = zeros(24,24);
KL_matrix_2 = zeros(24,24);
JS_matrix = zeros(24,24);
for i = 1:24
    for j = 1:24
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
d_5 = [1 3 5 7 9 11 13 15 17 19 21 23];
d_15 = d_5 + 1;

JS_matrix_reordered = JS_matrix([d_5, d_15], [d_5, d_15]);

% Initialize a matrix to store the means of each block
means_distance = zeros(2,2);

for i = 1:2
    for j = 1:2
        % Extract the block
        block = JS_matrix_reordered(1 + (i-1)*12:i*12, 1 + (j-1)*12:j*12);
        
        % Compute the mean of the block
        means_distance(i, j) = mean(block(:));
    end
end
% log_means = log(means - min(min(means)) + 1);
figure('Position',[400 75 700 500]);
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
for i = 1
    line([i, i]+0.5, [0.5,2.5], 'Color', 'k', 'LineWidth', 1.5);
    line([0.5, 2.5], [i, i]+0.5, 'Color', 'k', 'LineWidth', 1.5);
end
hold off;
xticks([1 2])
xticklabels({'5 m','25 m'})

yticks([1 2 ])
yticklabels({'5 m','25 m'})
set(gca,'FontSize',23)

%% ACC_cat

ACC_c = [1 2 7 8 13 14 19 20];
ACC_m = ACC_c + 2;
ACC_a = ACC_m + 2;
JS_matrix_reordered = JS_matrix([ACC_c, ACC_m, ACC_a], [ACC_c, ACC_m, ACC_a]);

% Initialize a matrix to store the means of each block
means_cat = zeros(3, 3);

for i = 1:3
    for j = 1:3
        % Extract the block
        block = JS_matrix_reordered(1 + (i-1)*8:i*8, 1 + (j-1)*8:j*8);
        
        % Compute the mean of the block
        means_cat(i, j) = mean(block(:));
    end
end
% log_means = log(means - min(min(means)) + 1);
figure('Position',[400 75 700 500]);
map = (linspace(1,0,100)'.*[231-18,242-124,248-194]+[18,124,194])/255;

% imagesc(log_means);
imagesc(means_cat);
colormap(map);
colorbar;
% title('JS Divergence for ACC category');

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
xticklabels({'Cautious','Mild','Aggressive'})

yticks([1 2 3])
yticklabels({'Cautious','Mild','Aggressive'})
ytickangle(60)  
set(gca,'FontSize',23)
%% Lateral control
LC_1 = 1:6;
LC_3 = 7:12;
LC_f = 13:18;
LC_a = 19:24;
JS_matrix_reordered = JS_matrix([LC_1, LC_3, LC_f, LC_a], [LC_1, LC_3, LC_f, LC_a]);

% Initialize a matrix to store the means of each block
means_LC = zeros(4, 4);

for i = 1:4
    for j = 1:4
        % Extract the block
        block = JS_matrix_reordered(1 + (i-1)*6:i*6, 1 + (j-1)*6:j*6);
        
        % Compute the mean of the block
        means_LC(i, j) = mean(block(:));
    end
end
% log_means = log(means - min(min(means)) + 1);
figure('Position',[400 75 700 500]);
map = (linspace(1,0,100)'.*[231-18,242-124,248-194]+[18,124,194])/255;

% imagesc(log_means);
imagesc(means_LC);
colormap(map);
colorbar;
% title('JS Divergence for Lateral control category');

% Adjust the aspect ratio
axis equal tight;

% Add edges for each block
hold on;
for i = 1:3
    line([i, i]+0.5, [0.5,4.5], 'Color', 'k', 'LineWidth', 1.5);
    line([0.5, 4.5], [i, i]+0.5, 'Color', 'k', 'LineWidth', 1.5);
end
hold off;
xticks([1 2 3 4])
xticklabels({'1 m/s','3 m/s','Fragmented (1m/s)','Abortion (1m/s)'})

yticks([1 2 3 4])
yticklabels({'1 m/s','3 m/s','Fragmented (1m/s)','Abortion (1m/s)'});
ytickangle(60)  
set(gca,'FontSize',23)