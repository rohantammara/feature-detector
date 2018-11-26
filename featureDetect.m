clc;
clear;

% Load image
img = imread('table2.jpg');

% Convert image to grayscale
img = rgb2gray(img);
img = double(img);

% Detect features
out = fDetect(img);

% Display result
imshow(out);
