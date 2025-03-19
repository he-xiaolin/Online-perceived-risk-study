function cost_PCAD = cost_function_PCAD(params, x_s, x_n, y_s, y_n, vx_s, vx_n, vy_s, vy_n, ax_s, ax_n, ay_s, ay_n, PR)
    sigxs = params(1);
    sigys = params(2);
    sigxn = params(3);
    sigyn = params(4);
    tps = params(5);
    tpn = params(6);
    alpha = params(7);

    len = length(x_s);
    PCAD = zeros(1, len);
    parfor i = 1:len
        PCAD(i) = PCAD_function(x_s(i), x_n(i), y_s(i), y_n(i), vx_s(i), vx_n(i), vy_s(i), vy_n(i), ax_s(i), ax_n(i), ay_s(i), ay_n(i), sigxs, sigys, sigxn, sigyn, tps, tpn, alpha);
    end
    PCAD = PCAD./max(PCAD).*10;
    cost_PCAD = sqrt(mean((PCAD - PR).^6));
    % cost_PCAD = sum((PCAD - PR).^2); % Sum of squared errors
%     SSres = sum((PR - PCAD).^2);
%     SStot = sum((PR - mean(PR)).^2);
%     cost = SSres / SStot; % actually r-square = 1- SSres / SStot;
end