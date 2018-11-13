clc;

% Convert image to grayscale
img = rgb2gray(table);

% Harris threshold
threshold_h = 1e+7;
% Shi-Tomasi threshold
threshold_st = 5e+2;
% k-value for Harris
k = 0.05;

% Sobel operators to compute partial derivative w.r.t. x and y
Gx = [-1 0 1; -2 0 2; -1 0 1];
Gy = [-1 -2 -1; 0 0 0; 1 2 1];

% Calculate Intensity gradient (Approx. by convolution with Sobel operators)
Ix = conv2(double(img), double(Gx));
Iy = conv2(double(img), double(Gy));

Ix_2 = Ix.^2;
Iy_2 = Iy.^2;
Ixy = Ix.*Iy;
[m, n] = size(Ix);

% Initialize Corner matrices
C_h = zeros(m, n);
C_st = zeros(m, n);

% Calculate R-value and check if greater than threshold
for i = 1:m
    for j = 1:n
        % Gradient Matrix
        M = [Ix_2(i, j) Ixy(i, j);Ixy(i, j) Iy_2(i, j)];
        % Harris R-value
        R_h = abs(det(M) - k*(trace(M)^2));
        % Shi-Tomasi R-value
        R_st = min([M(1, 1) M(2, 2)]);
        % Check for corner
        if R_h > threshold_h
            C_h(i, j) = 1;
        end
        if R_st > threshold_st
            C_st(i, j) = 1;
        end
    end
end
imshowpair(C_h, C_st, 'montage');