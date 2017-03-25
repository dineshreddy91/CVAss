function [panoImg] = imageStitching(img1, img2, M, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image


out_size = [1500,3000];

warp_img1 = warpH(img1,M, out_size);
warp_img1 = im2double(warp_img1);

warp_img2 = warpH(img2, H2to1, out_size);
warp_img2 = im2double(warp_img2);

mask1 = maskForWarp(img1);
warp_mask1 = warpH(mask1, M, out_size);

mask2 = maskForWarp(img2);
warp_mask2 = warpH(mask2, H2to1, out_size);

panoImg = (warp_img1.*warp_mask1 + warp_img2.*warp_mask2)./( warp_mask1 + warp_mask2 );

panoImg = im2uint8(panoImg);
end


function mask = maskForWarp(img)
mask = zeros(size(img,1),size(img,2));
mask(1,:) = 1; mask(end,:) = 1; mask(:,1) = 1; mask(:,end) = 1;
mask = bwdist(mask, 'city');
mask = mask/max(mask(:));
end

