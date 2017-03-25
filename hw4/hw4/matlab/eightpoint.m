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
load('../data/some_corresp.mat');
len = size(pts1,1);
u = pts1(:,1);
v = pts1(:,2);
x = pts2(:,1);
y = pts2(:,2);

A = [ u.*x, u.*y, u, v.*x, v.*y, v, x, y, ones(len, 1)];
%  size(A)    == len 9

[~, ~, V] = svd(A);
Fun = reshape(V(:, 9), [3 3])';

[FU, FD, FV] = svd(Fun);
FD(3,3) = 0;

F = FU*FD*FV'
end

