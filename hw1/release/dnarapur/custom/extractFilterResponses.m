function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here

if size(img,3)<3
	img = repmat(img,[1 1 3]);
end
img_lab = RGB2Lab(img);
for loop = 1:size(filterBank,1)
	size(filterBank{loop},1);
	filterResponses(:,:,:,loop) = imfilter(img_lab,filterBank{loop});
end


end
