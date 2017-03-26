function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

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

%% Fundamental Matrices
F1 = reshape(V(:, 9), [3 3])';
F2 = reshape(V(:, 8), [3 3])';

l = sym('l', 'real');
lambda = double(real(vpa(solve(det((1-l)*F1+l*F2)))));

F = cell(length(lambda), 1);

T = [1/M 0 0; 0 1/M 0; 0 0 1];
for i=1:length(lambda)
        Fi = (1-lambda(i))*F1+lambda(i)*F2;
        Fi = T' * Fi * T;
        F{i} = refineF(Fi, pts1, pts2);

end
end

