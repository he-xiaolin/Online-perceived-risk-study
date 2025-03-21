
%%
% AMB
%%
clear;clc;close all;

pt = '../0-Raw_Data/KineticData/KinematicData_struct.mat';
mkdir('processed_feature_v4');
data_ = load(pt);
data = data_.AMB;
for i=1:27 %   AMB event order 1-27
% s is ego
% n is leading  surrounding 
% n2 is  behind
Time = data(i).Time;
% x_s = data(i).x_s;
% x_n = data(i).x_n;
% x_n2 = data(i).x_n2;

vx_s = data(i).vx_s;
vx_n = data(i).vx_n;
vx_n2 = data(i).vx_n2;

ax_s = data(i).ax_s;
ax_n = data(i).ax_n;
ax_n2 = data(i).ax_n2;


% y_s = data(i).y_s;
% y_n = data(i).y_n;
% y_n2 = data(i).y_n2;


vy_s = data(i).vy_s;
vy_n = data(i).vy_n;
vy_n2 =data(i).vy_n2;

ay_s = data(i).ay_s;
ay_n = data(i).ay_n;
ay_n2 = data(i).ay_n2;

delta_x=data(i).delta_x;
delta_y=data(i).delta_y;

delta_x2 = data(i).delta_x2;
delta_y2 = data(i).delta_y2;

% new added imgination velocity
v_In_x = data(i).v_In_x;
v_In_y = data(i).v_In_y;
v_Is_x = data(i).v_Is_x;
v_Is_y = data(i).v_Is_y;
v_In2_x = data(i).v_In2_x;
v_In2_y = data(i).v_In2_y;

% new added drac 
DRAC_Rx = data(i).DRAC_Rx;
DRAC_Ix = data(i).DRAC_Ix;
DRAC_Ry = data(i).DRAC_Ry;
DRAC_Iy = data(i).DRAC_Iy;
DRAC_Rx2 = data(i).DRAC_Rx2;
DRAC_Ix2 = data(i).DRAC_Ix2;
DRAC_Ry2 = data(i).DRAC_Ry2;
DRAC_Iy2 = data(i).DRAC_Iy2;


% newly added delta v, delta a
delta_vx = data(i).delta_vx;    
delta_vy = data(i).delta_vy;
delta_ax = data(i).delta_ax;
delta_ay = data(i).delta_ay;
delta_vx2 = data(i).delta_vx2;
delta_vy2 = data(i).delta_vy2;
delta_ax2 = data(i).delta_ax2;
delta_ay2 = data(i).delta_ay2;


File_name =append('processed_feature_v4/AMB/regression_input/AMB_input_',num2str(i,'%02d'),'.mat');
save(File_name,'Time', ...
        'vx_s', 'vx_n', 'vx_n2',...
        'ax_s' ,'ax_n' , 'ax_n2',...
        'vy_s' ,'vy_n' , 'vy_n2',...
        'ay_s' ,'ay_n' , 'ay_n2', ...
        'delta_x' ,'delta_y','delta_x2','delta_y2', ...
        'v_In_x','v_In_y', 'v_Is_x', 'v_Is_y','v_In2_x','v_In2_y', ...
        'DRAC_Rx','DRAC_Ix','DRAC_Ry','DRAC_Iy', ...
        'DRAC_Rx2','DRAC_Ix2','DRAC_Ry2','DRAC_Iy2', ...
        'delta_vx',"delta_vy","delta_ax","delta_ay","delta_vx2","delta_vy2","delta_ax2","delta_ay2");

end

dir='../0-Raw_Data/SubjectiveRatings/Formal/SubjectiveRatings_PR_2164_struct.mat';
load(dir);
j= 0;
for i = 1:27
    AMB_rating = AMB_PR(i).risk_p25_p75_mean;
    File_name =append('processed_feature_v4/AMB/regression_label/AMB_rating_',num2str(i,'%02d'),'.mat');
    save(File_name,'AMB_rating');
end
disp('AMB Done!')

