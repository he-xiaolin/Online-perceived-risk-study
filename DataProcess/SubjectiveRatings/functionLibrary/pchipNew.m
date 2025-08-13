
function yq = pchipNew(x, y, xq)
    % Check and adjust input data
    [x, y, sizey] = chckxy(x, y);

    % Compute slopes
    h = diff(x);
    m = prod(sizey);
    delta = diff(y, 1, 2) ./ repmat(h, m, 1);
    slopes = zeros(size(y));
    for r = 1:m
        if isreal(delta)
            slopes(r, :) = modifiedPchipSlopes(h, delta(r, :));
        else
            realSlopes = modifiedPchipSlopes(h, real(delta(r, :)));
            imagSlopes = modifiedPchipSlopes(h, imag(delta(r, :)));
            slopes(r, :) = complex(realSlopes, imagSlopes);
        end
    end

    % Compute piecewise cubic Hermite interpolant for those values and slopes
    yq = pwch(x, y, slopes, h, delta);
    yq.dim = sizey;

    if nargin == 3
        % Evaluate the piecewise cubic Hermite interpolant
        yq = ppval(yq, xq);
    end
end

function d = modifiedPchipSlopes(h, del)
    n = numel(h) + 1;
    d = zeros(1, n); % Initialize all slopes to zero

    % Explicitly set the first and last slopes to 0
    d(1) = 0;
    d(n) = 0;

    % Compute slopes for the remaining points
for j = 2:n-1
    % Check if the signs of successive slopes (delta values) are the same
    if sign(del(j-1)) == sign(del(j))
        w1 = 2*h(j) + h(j-1);
        w2 = h(j) + 2*h(j-1);
        d(j) = (w1 + w2) / (w1 / del(j-1) + w2 / del(j));
    else
        d(j) = 0;
    end
end

end

