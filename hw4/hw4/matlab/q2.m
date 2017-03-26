clear all;
close all;
clc;

load('../data/some_corresp.mat');
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
M = max(size(I1));
 
F = eightpoint( pts1, pts2, M);

load('../data/some_corresp_noisy.mat');
F = ransacF( pts1, pts2, M);
epipolarMatchGUI(I1, I2, F)

save('q2_1.mat','F','M','pts1','pts2');

displayEpipolarF(I1, I2, F{2});