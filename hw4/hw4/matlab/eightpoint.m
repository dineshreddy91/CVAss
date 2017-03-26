function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

%% input
%load('../data/some_corresp.mat');
len = size(pts1,1);
u = pts1(:,1)/M;
v = pts1(:,2)/M;
x = pts2(:,1)/M;
y = pts2(:,2)/M;

%% SVD
A = [ u.*x, u.*y, u, v.*x, v.*y, v, x, y, ones(len, 1)];
[~, ~, V] = svd(A);
F = reshape(V(:, 9), [3 3])';

%% Fundamental Metrix
[U, S, V] = svd(F);
S(3,3) = 0;
F = U*S*V';

%% renormalization
T = [1/M 0 0; 0 1/M 0; 0 0 1];
F = T' * F * T;

%% Refine
F =refineF(F,pts1,pts2);
end

