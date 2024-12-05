
%%
% MAL
%%
clear;clc;close all;
pt = '../0-Raw_Data/KineticData/DataForCalibration_MAL.mat';
mkdir('processed_feature');
data_ = load(pt);
data = data_.MAL;
for i=13:18 %  
x_s = data(i).x_s;
Time = data(i).Time;
x_n = data(i).x_n;
vx_s = data(i).vx_s;
vx_n = data(i).vx_n;
ax_s = data(i).ax_s;
ax_n = data(i).ax_n;
y_s = data(i).y_s;
y_n = data(i).y_n;
vy_s = data(i).vy_s;
vy_n = data(i).vy_n;
ay_s = data(i).ay_s;
ay_n = data(i).ay_n;
delta_x=data(i).delta_x;
delta_y=data(i).delta_y;

    File_name =append('processed_feature/MAL_2/regression_input/MAL_input_',num2str(i,'%02d'),'.mat');
    save(File_name,'Time','x_s', 'x_s', 'x_n', 'vx_s', 'vx_n', 'ax_s' ,...
        'ax_n' ,'y_s', 'y_n', 'vy_s' ,'vy_n' ,'ay_s' ,'ay_n' ,'delta_x' ,'delta_y');
end


dir='../0-Raw_Data/SubjectiveRatings/Formal/SubjectiveRatings_PR_2164_struct.mat';
load(dir);
j= 0;
for i = 13:18
    MAL_rating = MAL_PR(i).risk_p25_p75_mean;
    File_name =append('processed_feature/MAL_2/regression_label/MAL_rating_',num2str(i,'%02d'),'.mat');
    save(File_name,'MAL_rating');
 
end
disp('MAL Done!')

