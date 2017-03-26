% Q2.7 - Todo:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

clear all;
close all;
clc;

load('../data/templeCoords.mat');
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');

I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
M = max(size(I1));
 
F = eightpoint( pts1, pts2, M);

for loop =1:size(x1,1)
    [x2(loop),y2(loop)]=epipolarCorrespondence(I1,I2,F,x1(loop),y1(loop));
end
E = essentialMatrix(F,K1,K2);
Possible_M2 = camera2(E);

M1 = [eye(3),[0;0;0]];

C1 = K1*M1;
min_error = inf;
p1 = [x1,y1];
p2 = [x2',y2'];
for loop = 1 :size(Possible_M2,3)
    C2 = K2*Possible_M2(:,:,loop);
    [P_check, error] = triangulate(C1,p1,C2,p2);
    error
    if error<min_error
        P = P_check;
        M2 = Possible_M2(:,:,loop)
        min_error = error
    end
end
scatter3(P(1,:),P(2,:),P(3,:));
%epipolarMatchGUI(I1, I2, F);
