function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here

weight_0 = 2^(-layerNum+1);
h = getImageFeatures(wordMap,dictionarySize)*weight_0;
iter = 1;

% loop over pyramid
while(iter < layerNum)
	weight_layer = 2^(iter - layerNum);
	divisions = 2^iter;
	h_layer = compute_histogram(wordMap,divisions)*weight_layer;
	h = cat(1,h,h_layer);
	iter = iter+1;
end

%compute histogram for a pyramid
function [h] = compute_histogram(wordMap,Divisions)
	[rows cols] = size(wordMap);
	blockRowLength = floor(rows/Divisions);
	blockColLength = floor(cols/Divisions);
	
	wholeBlockRows = floor(rows / blockRowLength);
        blockVectorR = [blockRowLength * ones(1, wholeBlockRows), rem(rows, blockRowLength)];

        wholeBlockCols = floor(cols / blockColLength);
        blockVectorC = [blockColLength * ones(1, wholeBlockCols), rem(cols, blockColLength)];

        blocksData = mat2cell(wordMap, blockVectorR, blockVectorC);
	h=[];
		
	for rowIndex = 1 : Divisions
            for colIndex = 1: Divisions
		h = cat(1,h, getImageFeatures(blocksData{rowIndex,colIndex},dictionarySize).*rowIndex);
            end
        end
end
end
