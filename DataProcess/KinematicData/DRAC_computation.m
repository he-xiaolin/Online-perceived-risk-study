clear;clc;close all;
addpath('functionLibrary');
pt1 = '../../Data/KinematicData.mat';
load(pt1);
%% HB
for nn = 1:27
    delta_vx = HB(nn).vx_n-HB(nn).vx_s;
    delta_vIx = HB(nn).v_In_x-HB(nn).v_Is_x;
    delta_x = HB(nn).x_n - HB(nn).x_s;

    delta_vy = HB(nn).vy_n-HB(nn).vy_s;
    delta_vIy = HB(nn).v_In_y-HB(nn).v_Is_y;
    delta_y = HB(nn).y_n - HB(nn).y_s;


for i = 1:length(HB(nn).x_s)
    d_dot_R(i) = d_dot_cal(HB(nn).x_s(i), HB(nn).vx_s(i), HB(nn).y_s(i), HB(nn).vy_s(i), HB(nn).x_n(i), HB(nn).vx_n(i), HB(nn).y_n(i), HB(nn).vy_n(i));
    d_dot_I(i) = d_dot_cal(HB(nn).x_s(i), HB(nn).v_Is_x(i), HB(nn).y_s(i), HB(nn).v_Is_y(i), HB(nn).x_n(i), HB(nn).v_In_x(i), HB(nn).y_n(i), HB(nn).v_In_y(i));

end
    d = sqrt(delta_x.^2+delta_y.^2);
    HB(nn).DRAC_R = d_dot_R.^2/2./d;
    HB(nn).DRAC_I = (2*d_dot_R.*d_dot_I+d_dot_I.^2)/2./d;
for i = 1:length(HB(nn).x_s)
    pj = [HB(nn).x_n(i); HB(nn).y_n(i); 0];
    p_i = [HB(nn).x_s(i); HB(nn).y_s(i); 0];

    DRAC_R_vec = HB(nn).DRAC_R(i).*((p_i-pj)/norm(p_i-pj));
    DRAC_I_vec = HB(nn).DRAC_I(i).*((p_i-pj)/norm(p_i-pj));

    HB(nn).DRAC_Rx(i) = DRAC_R_vec(1);
    HB(nn).DRAC_Ry(i) = DRAC_R_vec(2);

    HB(nn).DRAC_Ix(i) = DRAC_I_vec(1);
    HB(nn).DRAC_Iy(i) = DRAC_I_vec(2);
end
end

%% MB
for nn = 1:27
    delta_vx = MB(nn).vx_n-MB(nn).vx_s;
    delta_vIx = MB(nn).v_In_x-MB(nn).v_Is_x;
    delta_x = MB(nn).x_n - MB(nn).x_s;

    delta_vy = MB(nn).vy_n-MB(nn).vy_s;
    delta_vIy = MB(nn).v_In_y-MB(nn).v_Is_y;
    delta_y = MB(nn).y_n - MB(nn).y_s;

for i = 1:length(MB(nn).x_s)
    d_dot_R(i) = d_dot_cal(MB(nn).x_s(i), MB(nn).vx_s(i), MB(nn).y_s(i), MB(nn).vy_s(i), MB(nn).x_n(i), MB(nn).vx_n(i), MB(nn).y_n(i), MB(nn).vy_n(i));
    d_dot_I(i) = d_dot_cal(MB(nn).x_s(i), MB(nn).v_Is_x(i), MB(nn).y_s(i), MB(nn).v_Is_y(i), MB(nn).x_n(i), MB(nn).v_In_x(i), MB(nn).y_n(i), MB(nn).v_In_y(i));

end
    d = sqrt(delta_x.^2+delta_y.^2);
    MB(nn).DRAC_R = d_dot_R.^2/2./d;
    MB(nn).DRAC_I = (2*d_dot_R.*d_dot_I+d_dot_I.^2)/2./d;
for i = 1:length(MB(nn).x_s)
    pj = [MB(nn).x_n(i); MB(nn).y_n(i); 0];
    p_i = [MB(nn).x_s(i); MB(nn).y_s(i); 0];

    DRAC_R_vec = MB(nn).DRAC_R(i).*((p_i-pj)/norm(p_i-pj));
    DRAC_I_vec = MB(nn).DRAC_I(i).*((p_i-pj)/norm(p_i-pj));

    MB(nn).DRAC_Rx(i) = DRAC_R_vec(1);
    MB(nn).DRAC_Ry(i) = DRAC_R_vec(2);

    MB(nn).DRAC_Ix(i) = DRAC_I_vec(1);
    MB(nn).DRAC_Iy(i) = DRAC_I_vec(2);
end

end

%% SVM
for nn = 1:27
    delta_vx = SVM(nn).vx_n-SVM(nn).vx_s;
    delta_vIx = SVM(nn).v_In_x-SVM(nn).v_Is_x;
    delta_x = SVM(nn).x_n - SVM(nn).x_s;


    delta_vy = SVM(nn).vy_n-SVM(nn).vy_s;
    delta_vIy = SVM(nn).v_In_y-SVM(nn).v_Is_y;
    delta_y = SVM(nn).y_n - SVM(nn).y_s;


    delta_vx2 = SVM(nn).vx_n2-SVM(nn).vx_s;
    delta_vIx2 = SVM(nn).v_In2_x-SVM(nn).v_Is_x;
    delta_x2 = SVM(nn).x_n2 - SVM(nn).x_s;


    delta_vy2 = SVM(nn).vy_n2-SVM(nn).vy_s;
    delta_vIy2 = SVM(nn).v_In2_y-SVM(nn).v_Is_y;
    delta_y2 = SVM(nn).y_n2 - SVM(nn).y_s;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% front
    for i = 1:length(SVM(nn).x_s)
    d_dot_R(i) = d_dot_cal(SVM(nn).x_s(i), SVM(nn).vx_s(i), SVM(nn).y_s(i), SVM(nn).vy_s(i), SVM(nn).x_n(i), SVM(nn).vx_n(i), SVM(nn).y_n(i), SVM(nn).vy_n(i));
    d_dot_I(i) = d_dot_cal(SVM(nn).x_s(i), SVM(nn).v_Is_x(i), SVM(nn).y_s(i), SVM(nn).v_Is_y(i), SVM(nn).x_n(i), SVM(nn).v_In_x(i), SVM(nn).y_n(i), SVM(nn).v_In_y(i));
    end
    d = sqrt(delta_x2.^2+delta_y2.^2);
    SVM(nn).DRAC_R = d_dot_R.^2/2./d;
    SVM(nn).DRAC_I = (2*d_dot_R.*d_dot_I+d_dot_I.^2)/2./d;
    for i = 1:length(SVM(nn).x_s)
    pj = [SVM(nn).x_n(i); SVM(nn).y_n(i); 0];
    p_i = [SVM(nn).x_s(i); SVM(nn).y_s(i); 0];

    DRAC_R_vec = SVM(nn).DRAC_R(i).*((p_i-pj)/norm(p_i-pj));
    DRAC_I_vec = SVM(nn).DRAC_I(i).*((p_i-pj)/norm(p_i-pj));

    SVM(nn).DRAC_Rx(i) = DRAC_R_vec(1);
    SVM(nn).DRAC_Ry(i) = DRAC_R_vec(2);

    SVM(nn).DRAC_Ix(i) = DRAC_I_vec(1);
    SVM(nn).DRAC_Iy(i) = DRAC_I_vec(2);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% behind

    for i = 1:length(SVM(nn).x_s)
    d_dot_R2(i) = d_dot_cal(SVM(nn).x_s(i), SVM(nn).vx_s(i), SVM(nn).y_s(i), SVM(nn).vy_s(i), SVM(nn).x_n2(i), SVM(nn).vx_n2(i), SVM(nn).y_n2(i), SVM(nn).vy_n2(i));
    d_dot_I2(i) = d_dot_cal(SVM(nn).x_s(i), SVM(nn).v_Is_x(i), SVM(nn).y_s(i), SVM(nn).v_Is_y(i), SVM(nn).x_n2(i), SVM(nn).v_In2_x(i), SVM(nn).y_n2(i), SVM(nn).v_In2_y(i));
    end
    d2 = sqrt(delta_x2.^2+delta_y2.^2);
    SVM(nn).DRAC_R2 = d_dot_R2.^2/2./d2;
    SVM(nn).DRAC_I2 = (2*d_dot_R2.*d_dot_I+d_dot_I2.^2)/2./d2;
    for i = 1:length(SVM(nn).x_s)
    pj = [SVM(nn).x_n2(i); SVM(nn).y_n2(i); 0];
    p_i = [SVM(nn).x_s(i); SVM(nn).y_s(i); 0];

    DRAC_R_vec2 = SVM(nn).DRAC_R2(i).*((p_i-pj)/norm(p_i-pj));
    DRAC_I_vec2 = SVM(nn).DRAC_I2(i).*((p_i-pj)/norm(p_i-pj));

    SVM(nn).DRAC_Rx2(i) = DRAC_R_vec2(1);
    SVM(nn).DRAC_Ry2(i) = DRAC_R_vec2(2);

    SVM(nn).DRAC_Ix2(i) = DRAC_I_vec2(1);
    SVM(nn).DRAC_Iy2(i) = DRAC_I_vec2(2);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% behind

end
%% LC
for nn = 1:24
    delta_vx = LC(nn).vx_n-LC(nn).vx_s;
    delta_vIx = LC(nn).v_In_x-LC(nn).v_Is_x;
    delta_x = LC(nn).x_n - LC(nn).x_s;


    delta_vy = LC(nn).vy_n-LC(nn).vy_s;
    delta_vIy = LC(nn).v_In_y-LC(nn).v_Is_y;
    delta_y = LC(nn).y_n - LC(nn).y_s;
 
    for i = 1:length(LC(nn).x_s)
        d_dot_R(i) = d_dot_cal(LC(nn).x_s(i), LC(nn).vx_s(i), LC(nn).y_s(i), LC(nn).vy_s(i), LC(nn).x_n(i), LC(nn).vx_n(i), LC(nn).y_n(i), LC(nn).vy_n(i));
        d_dot_I(i) = d_dot_cal(LC(nn).x_s(i), LC(nn).v_Is_x(i), LC(nn).y_s(i), LC(nn).v_Is_y(i), LC(nn).x_n(i), LC(nn).v_In_x(i), LC(nn).y_n(i), LC(nn).v_In_y(i));

    end
    d = sqrt(delta_x.^2+delta_y.^2);
    LC(nn).DRAC_R = d_dot_R.^2/2./d;
    LC(nn).DRAC_I = (2*d_dot_R.*d_dot_I+d_dot_I.^2)/2./d;
    for i = 1:length(LC(nn).x_s)
        pj = [LC(nn).x_n(i); LC(nn).y_n(i); 0];
        p_i = [LC(nn).x_s(i); LC(nn).y_s(i); 0];
    
        DRAC_R_vec = LC(nn).DRAC_R(i).*((p_i-pj)/norm(p_i-pj));
        DRAC_I_vec = LC(nn).DRAC_I(i).*((p_i-pj)/norm(p_i-pj));
    
        LC(nn).DRAC_Rx(i) = DRAC_R_vec(1);
        LC(nn).DRAC_Ry(i) = DRAC_R_vec(2);
    
        LC(nn).DRAC_Ix(i) = DRAC_I_vec(1);
        LC(nn).DRAC_Iy(i) = DRAC_I_vec(2);
    end


end

%% save
% save(pt,'SVM','HB','MB','LC');
