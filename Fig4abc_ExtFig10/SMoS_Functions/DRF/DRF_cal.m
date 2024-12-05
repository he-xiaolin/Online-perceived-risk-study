function DRF = DRF_cal(dx,dy,vx_s,s,tla,m,c)
% vx_s=27.78;
dx(dx>vx_s.*tla)=abs(vx_s.*tla);

F=@(x,y) s.*(x-vx_s.*tla).^2.*exp(-(y.^2)./(2.*(m.*x+c).^2));

dx=abs(dx);dy=abs(dy);

% Define the grid parameters
x_min = min(dx(:))-1; % minimum x value
x_max = max(dx(:))+1; % maximum x value
y_min = min(dy(:))-1; % minimum y value
y_max = max(dy(:))+1; % maximum y value
step = 0.1; % grid spacing

% Create the grid
[x,y] = meshgrid(x_min:step:x_max, y_min:step:y_max);

% Evaluate the function over the grid
F_vals = F(x(:), y(:));

% Reshape the values back into a grid
F_grid = reshape(F_vals, size(x));

% Compute the sum of the function values over the grid
DRF = sum(F_grid(:));

% Scale the result by the cost
cost=2500;
DRF=DRF*cost;
end