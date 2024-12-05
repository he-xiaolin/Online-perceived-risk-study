function PCAD = PCAD_function(x_s, x_n, y_s, y_n, vx_s, vx_n, vy_s, vy_n, ax_s, ax_n, ay_s, ay_n, sigxs, sigys, sigxn, sigyn, tps, tpn, alpha)
    % Input: position, velocity, and acceleration values of the subject (s) and neighboring (n) vehicles
    % Output: PCAD value
    
    % Define model parameters
    % For the neighbouring vehicle Gaussian density function and
if abs(y_n-y_s)>10
    PCAD = 0;
    return;
end
    % Imaginary velocity restrictions
    fb = 30;
    bb = -10;
    lb = 6;
    rb = -6;
    
    % Define positions of subject and neighboring vehicles
    pj = [x_n; y_n; 0];
    p_i = [x_s; y_s; 0];

    %% Adjust velocity for the neighboring vehicle
    % The probability density functions and expected values for the imaginary velocity vector
    % of the neighboring vehicle was already defined at the beginning of
    % the function
 
    prob_den_v_In_dir = @(k) (1./sigxn.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxn))./(normcdf(fb/sigxn)-normcdf(bb/sigxn)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigyn.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigyn))./(normcdf(lb/sigyn)-normcdf(rb/sigyn)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb);
        prob_v_In_dir=integral(prob_den_v_In_dir,0,Inf);

    v_exp_In = @(k) (1./sigxn.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxn))./(normcdf(fb/sigxn)-normcdf(bb/sigxn)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigyn.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigyn))./(normcdf(lb/sigyn)-normcdf(rb/sigyn)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb)./prob_v_In_dir.*k;

    v_In_len = integral(v_exp_In,0,Inf);

    v_In = v_In_len.*((p_i-pj)/norm(p_i-pj)); % pointing from n to s
    
    % Adjust the velocity for the neighbouring vehicle
    vx_n = vx_n + v_In(1) + ax_n * tpn;
    vy_n = vy_n + v_In(2) + ay_n * tpn;
    %% Adjust velocity for the subject vehicle    
    % The probability density functions and expected values for the imaginary velocity vector
    % of the subject vehicle was already defined at the beginning of the
    % function

    prob_den_v_Is_dir = @(k) (1./sigxs.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxs))./(normcdf(fb/sigxs)-normcdf(bb/sigxs)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigys.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigys))./(normcdf(lb/sigys)-normcdf(rb/sigys)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb);
        prob_v_Is_dir=integral(prob_den_v_Is_dir,0,Inf);

    v_exp_Is = @(k) (1./sigxs.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxs))./(normcdf(fb/sigxs)-normcdf(bb/sigxs)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigys.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigys))./(normcdf(lb/sigys)-normcdf(rb/sigys)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb)./prob_v_Is_dir.*k;

    v_Is_len = integral(v_exp_Is,0,Inf);

    v_Is = v_Is_len.*((p_i-pj)/norm(p_i-pj))*(-1);
    
    % Adjust the velocity for the subject vehicle
    vx_s = vx_s + v_Is(1) + ax_s * tps;
    vy_s = vy_s + v_Is(2) + ay_s * tps;    
    %% Find the optimal velocity change -- using grid search
%     % Calculate the dot product of the distance changing rate (d_dot)
    d_dot = d_dot_cal(x_s, vx_s, y_s, vy_s, x_n, vx_n, y_n, vy_n);
% 
%     % Initialize variables for the control loop
    vx1 = 0;
    vy1 = 0;
 
    % Refine the optimal velocity change with a finer search grid (accuracy
    % = 0.05)
    % Find the optimal velocity change (accuracy = 0.5)
    if d_dot <= 0
        if y_n>0
        [delta_vx, delta_vy] = meshgrid(-20:0.5:0, -5:0.5:0);
        elseif y_n<0
        [delta_vx, delta_vy] = meshgrid(-20:0.5:0, 0:0.5:5);    
        else
        [delta_vx, delta_vy] = meshgrid(-20:0.5:0, -5:0.5:5);    
        end
        fm = arrayfun(@(dvx, dvy) BearingRate_prod(0, x_s, vx_s + dvx, y_s, ...
            vy_s + dvy, x_n, vx_n, y_n, vy_n), delta_vx, delta_vy);

        positive_fm = fm >= 0;
        delta_vx_positive_fm = delta_vx(positive_fm);
        delta_vy_positive_fm = delta_vy(positive_fm);
        vec_lens = sqrt(delta_vx_positive_fm.^2 + delta_vy_positive_fm.^2);

        [min_vec_len, idx1] = min(vec_lens);

        if ~isempty(min_vec_len)
            vx1 = delta_vx_positive_fm(idx1);
            vy1 = delta_vy_positive_fm(idx1);
%             vec_len = min_vec_len;
        end
    else
        PCAD = 0;
        return
    end

    % Refine the optimal velocity change with a finer search grid (accuracy
    % = 0.05)
    if vx1 ~= 0 || vy1 ~= 0
        delta_vx_range = vx1 - 0.5:0.05:vx1 + 0.5;
        delta_vy_range = vy1 - 0.5:0.05:vy1 + 0.5;

        [delta_vx, delta_vy] = meshgrid(delta_vx_range, delta_vy_range);
        fm = arrayfun(@(dvx, dvy) BearingRate_prod(0, x_s, vx_s + dvx, y_s, ...
            vy_s + dvy, x_n, vx_n, y_n, vy_n), delta_vx, delta_vy);

        positive_fm = fm > 0;
        delta_vx_positive_fm = delta_vx(positive_fm);
        delta_vy_positive_fm = delta_vy(positive_fm);
        vec_lens = sqrt(delta_vx_positive_fm.^2 + delta_vy_positive_fm.^2);

        [min_vec_len, idx2] = min(vec_lens);

        if ~isempty(min_vec_len)
            vx2 = delta_vx_positive_fm(idx2);
            vy2 = delta_vy_positive_fm(idx2);
%             vec_len = min_vec_len;
        end
    else
        PCAD = 0;
        return
    end
    
    % Refine the optimal velocity change with a finer search grid (accuracy
    % = 0.01)
    if vx2 ~= 0 || vy2 ~= 0
%         vec_len = sqrt(vx.^2 + vy.^2);
        delta_vx_range = vx2 - 0.05:0.01:vx2 + 0.05;
        delta_vy_range = vy2 - 0.05:0.01:vy2 + 0.05;

        [delta_vx, delta_vy] = meshgrid(delta_vx_range, delta_vy_range);
        fm = arrayfun(@(dvx, dvy) BearingRate_prod(0, x_s, vx_s + dvx, y_s, ...
            vy_s + dvy, x_n, vx_n, y_n, vy_n), delta_vx, delta_vy);

        positive_fm = fm > 0;
        delta_vx_positive_fm = delta_vx(positive_fm);
        delta_vy_positive_fm = delta_vy(positive_fm);
        vec_lens = sqrt(delta_vx_positive_fm.^2 + delta_vy_positive_fm.^2);

        [min_vec_len,idx3] = min(vec_lens);
%         fenliangx=delta_vx_positive_fm(idx3);
%         fenliangy=delta_vy_positive_fm(idx3);
        if ~isempty(min_vec_len)
            vec_len = min_vec_len;
        end
    else
        PCAD = 0;
        return
    end  
%%
    % Calculate the final PCAD value
    PCAD = vec_len * (vx_s / 100 * 3.6) ^ alpha;
end