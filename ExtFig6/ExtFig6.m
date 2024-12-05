%% Mapping GSR to PR, obtain the PR-time data
clear; clc;close all
addpath('Functions')
% Given data points
% Raw perceived risk data
y_data = [-3.685210312, -3.294436906, -2.545454545, -1.50339213, -0.298507463, 0.710990502, 1.579375848, 2.295793758, 3.001356852, 2.675712347, 1.94843962, -0.928086839, 0.233378562, 1.134328358, -2.903663501];
% GSR data
x_data = [0.243587886, 0.253770863, 0.332349725, 0.420993005, 0.587503787, 0.75377745, 0.939297335, 1.114924056, 1.34879003, 1.241598714, 1.027123869, 0.479943618, 0.665819183, 0.822252374, 0.293080054];
% rescale perceived risk data
y_data = (y_data - min(y_data))/(max(y_data) - min(y_data)).*10;
% Plot the given data points
scatter(x_data, y_data, 'blue', 'DisplayName', 'Data Points');
hold on;

% Perform polynomial fitting (degree = 2)

p2 = polyfit(x_data, y_data, 2);
% Generate fitted curve points
x_fit = linspace(min(x_data), max(x_data), 100);

y_fit2 = polyval(p2, x_fit);
% Plot the fitted curve
plot(x_fit, y_fit2, 'b', 'DisplayName', 'Fitted Curve');
% Labels and title
xlabel('GSR');
ylabel('Perceived risk');
title('Data Fitting using Polynomial Curve');
legend;

% Show grid
grid on;

time_GSR_data = [
    0.012446594  0.206299213;
    1.050810353  0.197440945;
    2.031556594  0.187992126;
    3.011054392  0.198031496;
    3.999745267  0.364566929;
    4.965850681  0.583661417;
    5.97882944   0.671062992;
    6.979399436  0.652165354;
    7.982390654  0.595472441;
    8.967601023  0.516338583;
    9.991777934  0.428937008;
    10.99575277  0.356889764;
    11.99942496  0.289566929;
    12.96367663  0.237598425;
    14.02197763  0.217519685;
    15.02224498  0.203346457;
    16.00340737  0.187401575;
    17.02289316  0.173228346;
    18.00367723  0.163188976;
    19.00341493  0.157283465;
    19.98329105  0.161417323;
    20.98215862  0.169094488;
    22.00032031  0.175590551;
    23.01833067  0.184448819;
    24.01742523  0.188582677;
    24.99764183  0.187401575;
    25.9778206   0.186811024;
    26.99643626  0.186220472;
    27.99594698  0.183858268;
    28.99485238  0.190944882;
    29.97438801  0.200393701;
];
y_mapping_GSR_PR = polyval(p2, time_GSR_data(:,2))+1;

figure;
hold on;
scatter(time_GSR_data(:,1), y_mapping_GSR_PR, 'filled', 'DisplayName', 'Data Points');
xlabel('Time [s]');
ylabel('Perceived risk');
title('Data and Fitted Splines');
legend();
grid on;
hold off;
generateddata=[time_GSR_data(:,1), y_mapping_GSR_PR];
%% Compare linear, quadratic, cubic, and power function. 

% Define perceived risk data
PR_data = y_mapping_GSR_PR; 

x_data = time_GSR_data(:, 1);

y_data = PR_data;

train_idx = [1 7 13 19 25 31];
% train_idx = 1:31;

x_train = x_data(train_idx);
y_train = y_data(train_idx);

% Points where you want to evaluate the spline
x_eval = linspace(min(x_data), max(x_data), 500);

%% Linear Spline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_linear = interp1(x_train, y_train, x_eval, 'linear');

%% Quadratic Spline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize matrices for solving the system
n = length(x_train) - 1; % Number of spline segments
A = zeros(2*n, 3*n); % Coefficient matrix
b = zeros(2*n, 1); % Right-hand side vector

% Fill in A and b for spline through each point
for i = 1:n
    A(2*i-1, (3*i-2):(3*i)) = [x_train(i)^2, x_train(i), 1]; % Spline passes through start of segment
    b(2*i-1) = y_train(i);
    A(2*i, (3*i-2):(3*i)) = [x_train(i+1)^2, x_train(i+1), 1]; % Spline passes through end of segment
    b(2*i) = y_train(i+1);
end

% Identify peaks and troughs
peaks = find((y_train(2:end-1) > y_train(1:end-2)) & (y_train(2:end-1) > y_train(3:end))) + 1;
troughs = find((y_train(2:end-1) < y_train(1:end-2)) & (y_train(2:end-1) < y_train(3:end))) + 1;

% Prioritize peaks over adjacent troughs
for i = 1:length(peaks)
    peak = peaks(i);
    % Apply zero derivative condition at the peak for segments before and after the peak
    if peak > 1 % Segment before the peak
        A = [A; zeros(1, size(A,2))];
        A(end, (3*(peak-1)-2):(3*(peak-1))) = [2*x_train(peak), 1, 0];
        b = [b; 0];
    end
    if peak < n % Segment after the peak
        A = [A; zeros(1, size(A,2))];
        A(end, (3*peak-2):(3*peak)) = [2*x_train(peak), 1, 0];
        b = [b; 0];
    end
end

for i = 1:length(troughs)
    trough = troughs(i);
    % Check if adjacent to a peak with higher priority
    if ~ismember(trough-1, peaks) && ~ismember(trough+1, peaks)
        % Apply zero derivative condition at the trough for segments before and after the trough
        if trough > 1 % Segment before the trough
            A = [A; zeros(1, size(A,2))];
            A(end, (3*(trough-1)-2):(3*(trough-1))) = [2*x_train(trough), 1, 0];
            b = [b; 0];
        end
        if trough < n % Segment after the trough
            A = [A; zeros(1, size(A,2))];
            A(end, (3*trough-2):(3*trough)) = [2*x_train(trough), 1, 0];
            b = [b; 0];
        end
    end
end

% Solve for coefficients
coeffs = A \ b;


% Evaluate the spline at x_eval
y_quad = zeros(size(x_eval));
for i = 1:n
    idx = find(x_eval >= x_train(i) & x_eval <= x_train(i + 1));
    x_range = x_eval(idx);
    a = coeffs(3*(i-1) + 1);
    b = coeffs(3*(i-1) + 2);
    c = coeffs(3*(i-1) + 3);
    y_quad(idx) = a * x_range.^2 + b * x_range + c;
end

%% Cubic Spline %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 
[maxima, idx_max] = findpeaks(y_train);
[minima, idx_min] = findpeaks(-y_train);
poles = sort([idx_min; idx_max]);


% Combine the poles with the first and last points to define segments
differences = abs(diff(y_train));
idx_point = find(differences < 1);
idx_pairs = [idx_point', idx_point'+1];
segment_indices = unique([1, length(y_train), poles', idx_pairs]);

% Initialize cell arrays to store spline data
x_spline_segments = {};
y_spline_segments = {};

% Loop over each segment to create cubic splines
for i = 1:length(segment_indices) - 1
    start = segment_indices(i);
    last = segment_indices(i + 1);  % Include the end index

    x_segment = x_train(start:last);
    y_segment = y_train(start:last);


    cs_segment{i} = csape(x_segment, y_segment, 'clamped', [0, 0]);

    x_eval = linspace(min(x_data), max(x_data), 500);

    if i==length(segment_indices) - 1
        x_spline = x_eval(x_eval>=x_segment(1)&x_eval<=x_segment(end));
    else
         x_spline = x_eval(x_eval>=x_segment(1)&x_eval<x_segment(end));
    end
    y_spline = ppval(cs_segment{i}, x_spline);


    x_spline_segments{end+1} = x_spline;
    y_spline_segments{end+1} = y_spline;
end
y_cubic = cell2mat(y_spline_segments);
%% Cubic spline PCHIP

% Evaluate the spline over a grid
x_eval = linspace(min(x_train), max(x_train), 500);
y_cubic_pchip = pchipNew(x_train, y_train, x_eval);
%%
% Plotting the data and the splines
figure;
hold on;
scatter(x_data, y_data, 'filled', 'DisplayName', 'Data Points');
plot(x_eval, y_linear, '--', 'DisplayName', 'Linear Spline');
plot(x_eval, y_quad, '-.', 'DisplayName', 'Quadratic Spline');
plot(x_eval, y_cubic, '-', 'DisplayName', 'Cubic Spline (natural)');
plot(x_eval, y_cubic_pchip, 'r-', 'DisplayName', 'Cubic Spline (pchip)');
xlabel('Time [s]');
ylabel('Perceived risk');
title('Data and Fitted Splines');
legend();
grid on;
hold off;
%% Performance test
% Prepare test data (the points not included in the training set)
test_idx = setdiff(1:length(x_data), train_idx);
x_test = x_data(test_idx);
y_test = y_data(test_idx);

% Initialize y-values for the splines at test points

% Evaluate the linear spline at test points%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_linear_test = interp1(x_train, y_train, x_test, 'linear');

% Evaluate the quadratic spline at test points
y_quad_test = zeros(size(x_test));
for i = 1:n
    idx = find(x_test >= x_train(i) & x_test <= x_train(i + 1));
    x_range_test = x_test(idx);
    a = coeffs(3*(i-1) + 1);
    b = coeffs(3*(i-1) + 2);
    c = coeffs(3*(i-1) + 3);
    y_quad_test(idx) = a * x_range_test.^2 + b * x_range_test + c;
end

% Evaluate the cubic spline at test points
y_cubic_segments = {};
for i = 1:length(cs_segment)

    x_range_test = x_test(x_test>=x_spline_segments{i}(1));
    x_range_test = x_range_test(x_range_test<=x_spline_segments{i}(end));
    y_range_test = ppval(cs_segment{i}, x_range_test);

    y_cubic_segments{end+1} = y_range_test';
end
y_cubic_test = cell2mat(y_cubic_segments)';
% y_cubic_test = ppval(cs, x_test);

y_cubic_pchip_test = pchipNew(x_train, y_train, x_test);

% Calculate RMSE for each spline type
rmse_linear = sqrt(mean((y_test - y_linear_test).^2));
rmse_quad = sqrt(mean((y_test - y_quad_test).^2));
rmse_cubic = sqrt(mean((y_test - y_cubic_test).^2));
rmse_cubic_pchip = sqrt(mean((y_test - y_cubic_pchip_test).^2));


% Display RMSE
fprintf('Root Mean Squared Error for Linear Spline: %f\n', rmse_linear);
fprintf('Root Mean Squared Error for Quadratic Spline: %f\n', rmse_quad);
fprintf('Root Mean Squared Error for Cubic Spline: %f\n', rmse_cubic);
fprintf('Root Mean Squared Error for Cubic pchip Spline: %f\n', rmse_cubic_pchip);

function cs_segment = create_sub_spline(x, y)
    cs_segment = csape(x, y, 'clamped', [0, 0]);
end