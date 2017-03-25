function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image


out_size = [1500,3000];

[nr, nc, ~] = size(img2);
img2cor = [1,1,1;nc,1,1;1,nr,1;nc,nr,1];

imTrans = (H2to1*img2cor')';
lambda = imTrans(:,3);
imTrans = imTrans ./ (lambda*[1,1,1]);


W = max(max(imTrans(:,1)), size(img1,2)) - min(min(imTrans(:,1)), 1);
H = max(max(imTrans(:,2)), size(img1,1)) - min(min(imTrans(:,2)), 1);
scal = out_size(2)/W;
out_size(1) = round(scal*H);

WTran = abs(min(min(imTrans(:,1)), 0)) ;
HTran = abs(min(min(imTrans(:,2)), 0));

M = [scal, 0, WTran * scal;
    0, scal, HTran * scal;
    0, 0, 1];

H2to1 = M*H2to1;

panoImg = imageStitching(img1, img2,M, H2to1);
end



