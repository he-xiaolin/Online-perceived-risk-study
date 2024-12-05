%% HB
clear;clc;close all;
pt = '../../../../Data/KinematicData.mat';
mkdir('processed_feature_v5'); % be careful of the name per each run
mkdir('processed_feature_v5/HB/regression_input');
mkdir('processed_feature_v5/HB/regression_label');
data_ = load(pt);
data = data_.HB;
for i=1:27 %   HB event order 1-27
% 18 dims
Time = data(i).Time;
% x_s = data(i).x_s;
% x_n = data(i).x_n;

vx_s = data(i).vx_s;
vx_n = data(i).vx_n;

ax_s = data(i).ax_s;
ax_n = data(i).ax_n;


% y_s = data(i).y_s;
% y_n = data(i).y_n;


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


% new added drac 
DRAC_Rx = data(i).DRAC_Rx;
DRAC_Ix = data(i).DRAC_Ix;
DRAC_Ry = data(i).DRAC_Ry;
DRAC_Iy = data(i).DRAC_Iy;

% newly added delta v, delta a
delta_vx = data(i).delta_vx;    
delta_vy = data(i).delta_vy;
delta_ax = data(i).delta_ax;
delta_ay = data(i).delta_ay;


File_name =append('processed_feature_v5/HB/regression_input/HB_input_',num2str(i,'%02d'),'.mat');
save(File_name,'Time', ...
        'vx_s', 'vx_n', ...
        'ax_s' ,'ax_n' ,...
        'vy_s' ,'vy_n' , ...
        'ay_s' ,'ay_n' , ...
        'delta_x' ,'delta_y', ...
        'v_In_x','v_In_y', 'v_Is_x', 'v_Is_y', ...
        'DRAC_Rx','DRAC_Ix','DRAC_Ry','DRAC_Iy', ...
        'delta_vx',"delta_vy","delta_ax","delta_ay");
end
dir = '../../../../Data/SubjectiveRatings.mat';
load(dir);
j= 0;
for i = 1:27
    HB_rating = HB_PR(i).risk_p25_p75_mean;
    File_name =append('processed_feature_v5/HB/regression_label/HB_rating_',num2str(i,'%02d'),'.mat');
    save(File_name,'HB_rating');
end
disp('HB Done!')

