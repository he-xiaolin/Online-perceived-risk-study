function d_dot = d_dot_cal(s_x, s_vx, s_y, s_vy, n_x, n_vx, n_y, n_vy)
    % Input: position and velocity values of subject (s) and neighboring (n) vehicles
    % Output: the dot product of the distance vectors (d_dot)

    % Define positions of subject and neighboring vehicles
    pi = [s_x; s_y];
    pj = [n_x; n_y];

    % Define velocities of subject and neighboring vehicles
    vi = [s_vx; s_vy];
    vj = [n_vx; n_vy];

    % Calculate the distance between the subject and the neighboring vehicle
    d = sqrt((pi - pj)' * (pi - pj));

    % Compute the dot product of the distance vectors (d_dot)
    d_dot = (1 / d) * (pi - pj)' * (vi - vj);
end
