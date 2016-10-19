%% Ploar scanning algorithm test code

% setting things up
clc, clear all, close all

%% Loading image
% comment/uncomment below depending on what image you'd like to use

% test image - 1
% img = imread('data/calib-1.png'); 
% center = [385, 427]; r_max = 155;
% a0 = 10; b0 = 10;

% test image - 2
% img = imread('data/calib-2.png'); 
% center = [385, 427]; r_max = 160;
% a0 = 10; b0 = 10;

% test image - 3
img = imread('data/test-1.png'); 
center = [385, 427]; r_max = 180;
a0 = 10; b0 = 10;

% test image - 4
% img = imread('data/rings-1.png'); 
% center = [485, 485]; r_max = 400;
% a0 = 10; b0 = 10;

tic
%% Finding points
segments = 24;
[points, r_cell] = intersection_points(img, center, segments, 1);

theta = 0:360/segments:359.9;
theta = round(theta);

% Constructing r_matrix
r_matrix = zeros(segments, r_max);
for i = 1:segments
    r_matrix(i, r_cell{i}) = 1;
end


% Plotting the points
figure, hold on
for i = 1:length(r_cell)
    plot(i, r_cell{i}, 'b.')
end
xlabel('theta_k'), ylabel('r (distance from center)')

%% Applying polar scanning algorithm for ring labelling

% Assuming no break in first ring
r_contour0 = zeros(1, segments);
for i = 1:segments
    r_contour0(i) = min(r_cell{i});
end

[r_rings, no_of_rings] = psa(r_cell, center, r_contour0, r_max, 1);
% figure, imagesc(img_lb)

%% Plotting r_rings

figure, hold on
for i = 1:length(r_cell)
    plot(i, r_cell{i}, '.')
end
for i = 1:length(r_rings)
    plot(1:segments, r_rings{i}, 'r-')
end
xlabel('theta_k'), ylabel('r (distance from center)')
toc