% This function is to calculate the uncertain velocity in MB, HB, LC and
% SVM scenarios.
%% Calculate uncertain velocity in MB
clear;clc;close all;
addpath('functionLibrary');
pt1 = '../../Data/KinematicData.mat';
load(pt1);

% define parameters
    sigxs = 0.8;
    sigys= 1.7; 
    sigxn= 4.28; 
    sigyn= 3.86; 
 
for nn=1:27 % event order 1-27
    x_s = MB(nn).x_s;
    x_n = MB(nn).x_n;
    y_s = MB(nn).y_s;
    y_n = MB(nn).y_n;
    vx_s = MB(nn).vx_s;
    vx_n = MB(nn).vx_n;
    vy_s = MB(nn).vy_s;
    vy_n = MB(nn).vy_n;
    ax_s = MB(nn).ax_s;
    ax_n = MB(nn).ax_n;
    ay_s = MB(nn).ay_s;
    ay_n = MB(nn).ay_n;
    time = MB(nn).Time;
    delta_x = MB(nn).delta_x;%abs(x_n - x_s);
    delta_y = MB(nn).delta_y;%abs(y_n - y_s);
    len = length(x_s);

    for i = 1:len
        [v_In, v_Is] = Uncertain_v(x_s(i), x_n(i), y_s(i), y_n(i),...
            sigxs, sigys, sigxn, sigyn);
        v_In_x(i) = v_In(1);
        v_In_y(i) = v_In(2);

        v_Is_x(i) = v_Is(1);
        v_Is_y(i) = v_Is(2);
    end

    MB(nn).v_In_x = v_In_x;
    MB(nn).v_In_y = v_In_y;

    MB(nn).v_Is_x = v_Is_x;
    MB(nn).v_Is_y = v_Is_y;
    disp(num2str(nn));
end
% save(pt1, 'SVM','HB','MB','LC');
%% Calculate uncertain velocity in HB
clear;clc;close all;
addpath('functionLibrary');
pt1 = '../../Data/KinematicData.mat';
load(pt1);

% define parameters
    sigxs = 0.8;
    sigys= 1.7; 
    sigxn= 4.28; 
    sigyn= 3.86; 

for nn=1:27 % event order 1-27
    x_s = HB(nn).x_s;
    x_n = HB(nn).x_n;
    y_s = HB(nn).y_s;
    y_n = HB(nn).y_n;
    vx_s = HB(nn).vx_s;
    vx_n = HB(nn).vx_n;
    vy_s = HB(nn).vy_s;
    vy_n = HB(nn).vy_n;
    ax_s = HB(nn).ax_s;
    ax_n = HB(nn).ax_n;
    ay_s = HB(nn).ay_s;
    ay_n = HB(nn).ay_n;
    time = HB(nn).Time;
    delta_x = HB(nn).delta_x;
    delta_y = HB(nn).delta_y;
    len = length(x_s);

    for i = 1:len
        [v_In, v_Is] = Uncertain_v(x_s(i), x_n(i), y_s(i), y_n(i),...
            sigxs, sigys, sigxn, sigyn);
        v_In_x(i) = v_In(1);
        v_In_y(i) = v_In(2);

        v_Is_x(i) = v_Is(1);
        v_Is_y(i) = v_Is(2);
    end

    HB(nn).v_In_x = v_In_x;
    HB(nn).v_In_y = v_In_y;

    HB(nn).v_Is_x = v_Is_x;
    HB(nn).v_Is_y = v_Is_y;
    disp(num2str(nn));
end
% save(pt1, 'SVM','HB','MB','LC');
%% Calculate uncertain velocity in LC
clear;clc;close all;
addpath('functionLibrary');
pt1 = '../../Data/KinematicData.mat';
load(pt1);

% define parameters
    sigxs = 0.8;
    sigys= 1.7; 
    sigxn= 4.28; 
    sigyn= 3.86; 

for nn=1:24 % event order 1-24
    x_s = LC(nn).x_s;
    x_n = LC(nn).x_n;
    y_s = LC(nn).y_s;
    y_n = LC(nn).y_n;
    vx_s = LC(nn).vx_s;
    vx_n = LC(nn).vx_n;
    vy_s = LC(nn).vy_s;
    vy_n = LC(nn).vy_n;
    ax_s = LC(nn).ax_s;
    ax_n = LC(nn).ax_n;
    ay_s = LC(nn).ay_s;
    ay_n = LC(nn).ay_n;
    time = LC(nn).Time;
    delta_x = LC(nn).delta_x;
    delta_y = LC(nn).delta_y;
    len = length(x_s);

    for i = 1:len
        [v_In, v_Is] = Uncertain_v(x_s(i), x_n(i), y_s(i), y_n(i),...
            sigxs, sigys, sigxn, sigyn);
        v_In_x(i) = v_In(1);
        v_In_y(i) = v_In(2);

        v_Is_x(i) = v_Is(1);
        v_Is_y(i) = v_Is(2);
    end

    LC(nn).v_In_x = v_In_x;
    LC(nn).v_In_y = v_In_y;

    LC(nn).v_Is_x = v_Is_x;
    LC(nn).v_Is_y = v_Is_y;
    disp(num2str(nn));
end
% save(pt1, 'SVM','HB','MB','LC');
%% Calculate uncertain velocity in SVM
clear;clc;close all;
addpath('functionLibrary');
pt1 = '../../Data/KinematicData.mat';
load(pt1);

% define parameters
    sigxs = 0.8;
    sigys= 1.7; 
    sigxn= 4.28; 
    sigyn= 3.86; 

for nn=1:27 % event order 1-27
    x_s = SVM(nn).x_s;
    x_n = SVM(nn).x_n;
    y_s = SVM(nn).y_s;
    y_n = SVM(nn).y_n;
    vx_s = SVM(nn).vx_s;
    vx_n = SVM(nn).vx_n;
    vy_s = SVM(nn).vy_s;
    vy_n = SVM(nn).vy_n;
    ax_s = SVM(nn).ax_s;
    ax_n = SVM(nn).ax_n;
    ay_s = SVM(nn).ay_s;
    ay_n = SVM(nn).ay_n;
    time = SVM(nn).Time;
    delta_x = SVM(nn).delta_x;
    delta_y = SVM(nn).delta_y;


    x_n2 = SVM(nn).x_n2;
    y_n2 = SVM(nn).y_n2;
    vx_n2 = SVM(nn).vx_n2;
    vy_n2 = SVM(nn).vy_n2;
    ax_n2 = SVM(nn).ax_n2;
    ay_n2 = SVM(nn).ay_n2;

    len = length(x_s);

    for i = 1:len
        [v_In, v_Is] = Uncertain_v(x_s(i), x_n(i), y_s(i), y_n(i),...
            sigxs, sigys, sigxn, sigyn);
        v_In_x(i) = v_In(1);
        v_In_y(i) = v_In(2);

        v_Is_x(i) = v_Is(1);
        v_Is_y(i) = v_Is(2);
    end

    SVM(nn).v_In_x = v_In_x;
    SVM(nn).v_In_y = v_In_y;

    SVM(nn).v_Is_x = v_Is_x;
    SVM(nn).v_Is_y = v_Is_y;


    for i = 1:len
        [v_In2, v_Is2] = Uncertain_v(x_s(i), x_n2(i), y_s(i), y_n2(i),...
            sigxs, sigys, sigxn, sigyn);
        v_In2_x(i) = v_In2(1);
        v_In2_y(i) = v_In2(2);
         
        v_Is2_x(i) = v_Is2(1);
        v_Is2_y(i) = v_Is2(2);
    end
    SVM(nn).v_In2_x = v_In2_x;
    SVM(nn).v_In2_y = v_In2_y;

    SVM(nn).v_Is2_x = v_Is2_x;
    SVM(nn).v_Is2_y = v_Is2_y;
    disp(num2str(nn));
end
% save(pt1, 'SVM','HB','MB','LC');


