function [v_In, v_Is] = Uncertain_v(x_s, x_n, y_s, y_n, sigxs, sigys, sigxn, sigyn)
    % Input: position, velocity, and acceleration values of the subject (s) and neighboring (n) vehicles
    % Output: Uncertain velocity
    % Uncertain velocity restrictions
    fb = 30;
    bb = -10;
    lb = 6;
    rb = -6;
    
    % Define positions of subject and neighboring vehicles
    pj = [x_n; y_n; 0];
    p_i = [x_s; y_s; 0];

    %% Adjust velocity for the neighboring vehicle
    % The probability density functions and expected values for the uncertain velocity vector
    % of the neighboring vehicle was already defined at the beginning of
    % the function
 
    prob_den_v_In_dir = @(k) (1./sigxn.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxn))./(normcdf(fb/sigxn)-normcdf(bb/sigxn)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigyn.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigyn))./(normcdf(lb/sigyn)-normcdf(rb/sigyn)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb);
        prob_v_In_dir=integral(prob_den_v_In_dir,0,Inf);

    v_exp_In = @(k) (1./sigxn.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxn))./(normcdf(fb/sigxn)-normcdf(bb/sigxn)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigyn.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigyn))./(normcdf(lb/sigyn)-normcdf(rb/sigyn)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb)./prob_v_In_dir.*k;

    v_In_len = integral(v_exp_In,0,Inf);

    v_In = v_In_len.*((p_i-pj)/norm(p_i-pj)); % pointing from n to s

    %% Adjust velocity for the subject vehicle    
    % The probability density functions and expected values for the uncertain velocity vector
    % of the subject vehicle was already defined at the beginning of the
    % function

    prob_den_v_Is_dir = @(k) (1./sigxs.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxs))./(normcdf(fb/sigxs)-normcdf(bb/sigxs)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigys.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigys))./(normcdf(lb/sigys)-normcdf(rb/sigys)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb);
        prob_v_Is_dir=integral(prob_den_v_Is_dir,0,Inf);

    v_exp_Is = @(k) (1./sigxs.*normpdf((k*abs(x_n-x_s)/norm(pj-p_i))/sigxs))./(normcdf(fb/sigxs)-normcdf(bb/sigxs)).*(k*(x_n-x_s)/norm(pj-p_i)>bb&(k*(x_n-x_s)/norm(pj-p_i))<fb).*...
        (1./sigys.*normpdf((k*abs(y_n-y_s)/norm(pj-p_i))/sigys))./(normcdf(lb/sigys)-normcdf(rb/sigys)).*(k*(y_n-y_s)/norm(pj-p_i)>rb&(k*(y_n-y_s)/norm(pj-p_i))<lb)./prob_v_Is_dir.*k;

    v_Is_len = integral(v_exp_Is,0,Inf);

    v_Is = v_Is_len.*((p_i-pj)/norm(p_i-pj))*(-1);


end