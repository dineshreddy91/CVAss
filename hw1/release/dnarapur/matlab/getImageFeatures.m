function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

	% TODO Implement your code here
	h = zeros(dictionarySize,1);
	for x = 1 : size(wordMap,1)
		for y = 1 : size(wordMap,2)
			h(wordMap(x,y))=h(wordMap(x,y))+1;
		end
	end	
	assert(numel(h) == dictionarySize);
	%h = h/norm(h,1);
end
