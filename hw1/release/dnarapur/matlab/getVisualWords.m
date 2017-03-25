function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
filter_resp = extractFilterResponses(img,filterBank);
[h w p] = size(img);

wordMap = zeros(h,w);
for x = 1:size(img,1)
	for y = 1:size(img,2)
		Dist = pdist2(permute(filter_resp(x,y,:),[1 3 2]),dictionary);
            	[M I] = min(Dist);
            	wordMap(x,y) = I;
           
        end
end
end
