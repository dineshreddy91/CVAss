function mask = SubtractDominantMotion(image1, image2)
    
   [width,height] = size(image1);
    M = LucasKanadeAffine(image1, image2);
    
    warpimg = warpH(image1, M, [width height]);

    %[X, Y] = meshgrid(1:height, 1:width);
    
    %wx = M(1,1)*X + M(1,2)*Y + M(1,3);
    %wy = M(2,1)*X + M(2,2)*Y + M(2,3);
    %X = X(:);
    %Y = Y(:);
    %wimg = interp2(X, Y, image1, wx, wy);

    % compute m
    %m = zeros(width, height);
    %m = m | (wx >=1 & wx <= height);
    %m = m & (wy >=1 & wy <= width);
    
    delta_image = abs(image2 - warpimg);
    
    %histogram(delta_image(:))

    m = medfilt2(double(delta_image > 25 & delta_image < 256));

    se = strel('disk', 8);
    m = imdilate(m, se);
    m = imerode(m, strel('disk', 4));
    m = medfilt2(m);
    m = double(m);
    subimage = bwareaopen(m, 1000);
    mask = m - subimage;
end

function warp_im = warpH(im, H, out_size,fill_value)
%function warp_im = warpH(im, H, out_size,fill_value)
% warpH projective image warping
%   warp_im=warpA(im, A, out_size)
%   Warps a size (w,h,channels) image im using the  (3,3) homography H
%   producing an (out_size(1),out_size(2)) output image warp_im
%
%
%   warped_coords := H*source_coords
%
%   warp_im=warpH(im, A, out_size,fill_value)
%   Uses fill_value (scalar) to paint empty regions.



if ~exist('fill_value', 'var') || isempty(fill_value)
    fill_value = 0;
end

tform = maketform( 'projective', H'); 
warp_im = imtransform( im, tform, 'bilinear', 'XData', ...
	[1 out_size(2)], 'YData', [1 out_size(1)], 'Size', out_size(1:2), 'FillValues', fill_value*ones(size(im,3),1));
% warp_im = imtransform( im, tform, 'bilinear', 'XData', ...
% 	[1 out_size(1)], 'YData', [1 out_size(2)], 'Size', out_size(1:2), 'FillValues', fill_value*ones(size(im,3),1));
end
