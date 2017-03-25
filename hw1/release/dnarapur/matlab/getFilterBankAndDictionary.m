function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

    filterBank  = createFilterBank();
    alpha = 100;
    K = 200;
    filter_responses = zeros(length(imPaths)*alpha , 3*length(filterBank));
    %parpool('local',16);
    
    for i = 1:length(imPaths)
		disp(i);
        img = imread(imPaths{i});
		filter_resp = extractFilterResponses(img,filterBank);
		for pointsIndex = 1:alpha
			x = randi([1,size(img,1)]);
			y = randi([1,size(img,2)]);
			filter_responses(alpha*(i-1) + pointsIndex,:,:) = reshape(filter_resp (x, y, : ,:),1,3 *length(filterBank)); 
		end
    end
    [~,dictionary] = kmeans(filter_responses, K,'EmptyAction', 'drop');

end
