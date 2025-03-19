function cost_DRF = cost_function_DRF(params, delta_x, delta_y, vx_s, PR)
    tla = params(1);
    m = params(2);
    c = params(3);
    s = params(4);
    len = length(vx_s);
    % s = 0.15;
    parfor i = 1:len
        DRF(i) = DRF_cal(delta_x(i), delta_y(i), vx_s(i), s, tla, m, c);% DRF_cal(dx,dy,vx_s,s,tla,m,c)
    end
    DRF = DRF./max(DRF).*10;
    cost_DRF = sqrt(mean((DRF - PR).^6));
end