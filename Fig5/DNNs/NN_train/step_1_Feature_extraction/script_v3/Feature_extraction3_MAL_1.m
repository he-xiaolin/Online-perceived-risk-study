
%%
% MAL_1
%%
clear;clc;close all;

pt = '../0-Raw_Data/KineticData/KinematicData_struct.mat';
mkdir('processed_feature_v3');
data_ = load(pt);
data = data_.MAL;
for i=1:12 %   MAL_1 event order 1-12

Time = data(i).Time;
x_s = data(i).x_s;
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

% new added imgination velocity
v_In_x = data(i).v_In_x;
v_In_y = data(i).v_In_y;
v_Is_x = data(i).v_Is_x;
v_Is_y = data(i).v_Is_y;



File_name =append('processed_feature_v3/MAL_1/regression_input/MAL_1_input_',num2str(i,'%02d'),'.mat');
save(File_name,'Time', ...
        'x_s', 'x_n', ...
        'vx_s', 'vx_n', ...
        'ax_s' ,'ax_n' ,...
        'y_s', 'y_n', ...
        'vy_s' ,'vy_n' , ...
        'ay_s' ,'ay_n' , ...
        'delta_x' ,'delta_y', ...
        'v_In_x','v_In_y', 'v_Is_x', 'v_Is_y');
end

dir='../0-Raw_Data/SubjectiveRatings/Formal/SubjectiveRatings_PR_2164_struct.mat';
load(dir);
j= 0;
for i = 1:12
    MAL_1_rating = MAL_PR(i).risk_p25_p75_mean;
    File_name =append('processed_feature_v3/MAL_1/regression_label/MAL_1_rating_',num2str(i,'%02d'),'.mat');
    save(File_name,'MAL_1_rating');
end
disp('MAL_1 Done!')

