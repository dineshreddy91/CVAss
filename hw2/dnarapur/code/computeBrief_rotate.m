function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary

 
patchWidth = 9;
locs = [];
desc = [];

for i=1:size(locsDoG,1)
     X = locsDoG(i,2);
     Y = locsDoG(i,1);
     Z = locsDoG(i,3);
     Radius = ceil((patchWidth-1)/2);
     
     if X-Radius >= 1 && X+Radius <= size(im,1) && Y-Radius >= 1 && Y+Radius <= size(im,2)
         Localpatch = GaussianPyramid(X-Radius:X+Radius,Y-Radius:Y+Radius,Z);  
         [Grad,Goriet] = imgradient(Localpatch);
         hist = histc(reshape(Goriet,[1,9*9]),0:10:360);
         [~,num] = max(hist);
         patch = imrotate(Localpatch,(num-1)*10);
         %keyboard;
         desc = [desc; (patch(compareA)>patch(compareB))'];
         locs = [locs;locsDoG(i,:)];
     end
end
