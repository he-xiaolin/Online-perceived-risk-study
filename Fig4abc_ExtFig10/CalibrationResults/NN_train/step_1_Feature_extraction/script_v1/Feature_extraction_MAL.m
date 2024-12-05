
%%
% MAL
%%
clear;clc;close all;
pt = '../0-Raw_Data/KineticData/MAL/MAL_';
mkdir('processed_feature');

for nn=1:24 %   MAL event order 1-27
load([pt, num2str(nn),'.mat'])
    % Define all kinetic data. Traffic_cutin1 is the leading vehicle on the
    % main road
    x_s = DATASTRUCTURE.Car_Con_tx.data;
    x_n = DATASTRUCTURE.Traffic_cutin1_tx.data;
    vx_s = DATASTRUCTURE.Car_Con_vx_1.data;
    vx_n = DATASTRUCTURE.Traffic_cutin1_v_0_x.data;
    ax_s = DATASTRUCTURE.Car_Con_ax.data;
    ax_n = DATASTRUCTURE.Traffic_cutin1_a_1_x.data;
    ax_n(abs(ax_n)>50)=0;
    vx_n(abs(vx_n)>50)=0;
    y_s = DATASTRUCTURE.Car_Con_ty.data;
    y_n = DATASTRUCTURE.Traffic_cutin1_ty.data;
    vy_s = DATASTRUCTURE.Car_Con_vy_1.data;
    vy_n = DATASTRUCTURE.Traffic_cutin1_v_0_y.data;
    ay_s = DATASTRUCTURE.Car_Con_ay.data;
    ay_n = DATASTRUCTURE.Traffic_cutin1_a_1_y.data;
    ay_n(abs(ay_n)>50)=0;
    vy_n(abs(vy_n)>50)=0;
    delta_x=x_n-x_s;
    delta_y=abs(y_n-y_s);
    len = length(x_s);
    Time=DATASTRUCTURE.Time.data;

    Duration = 220:580;  % MAL 220:580
    x_s = x_s(Duration);
    x_n = x_n(Duration);
    vx_s = vx_s(Duration);
    vx_n = vx_n(Duration);
    ax_s = ax_s(Duration);
    ax_n = ax_n(Duration);
    y_s = y_s(Duration);
    y_n = y_n(Duration);
    vy_s = vy_s(Duration);
    vy_n = vy_n(Duration);
    ay_s = ay_s(Duration);
    ay_n = ay_n(Duration);
    delta_x=delta_x(Duration);
    delta_y=delta_y(Duration);
    len = length(Duration);
    Time=DATASTRUCTURE.Time.data;
    File_name =append('processed_feature/MAL/regression_input/MAL_input_',num2str(nn,'%02d'),'.mat');
    save(File_name,'Time','x_s', 'x_s', 'x_n', 'vx_s', 'vx_n', 'ax_s' ,...
        'ax_n' ,'y_s', 'y_n', 'vy_s' ,'vy_n' ,'ay_s' ,'ay_n' ,'delta_x' ,'delta_y');
end


dir='../0-Raw_Data/SubjectiveRatings/Formal/SubjectiveRatings_PR_2164_struct.mat';
load(dir);
j= 0;
for i = 1:24
    MAL_rating = MAL_PR(i).risk_p25_p75_mean;
    File_name =append('processed_feature/MAL/regression_label/MAL_rating_',num2str(i,'%02d'),'.mat');
    save(File_name,'MAL_rating');
 
end
disp('MAL Done!')

