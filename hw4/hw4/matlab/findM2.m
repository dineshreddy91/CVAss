% Q2.5 - Todo:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q2_5.mat

clear all;
close all;
clc;

load('../data/some_corresp.mat');
load('../data/intrinsics.mat');

I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');
M = max(size(I1));
p1 = pts1;
p2 = pts2;
F = eightpoint(p1, p2, M);

E = essentialMatrix(F,K1,K2);

Possible_M2 = camera2(E);

M1 = [eye(3),[0;0;0]];

C1 = K1*M1;
min_error = inf;
for loop = 1 :size(Possible_M2,3)
    C2 = K2*Possible_M2(:,:,loop);
    [P_check, error] = triangulate(C1,p1,C2,p2);
    if error<min_error
        P = P_check;
        M2 = Possible_M2(:,:,loop);
        min_error = error; 
    end
end

save('q2_5.mat','M2','p1','p2','P');
