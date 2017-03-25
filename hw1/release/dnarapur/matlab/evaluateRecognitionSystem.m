function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
	source = '../data/';
	ConMatrix = zeros(8,8);
	for loop = 1 : length(test_imagenames)
		visualImageName = [source, strrep(test_imagenames{loop},'.jpg','.mat')];
        load(visualImageName);
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        ConMatrix(test_labels(loop),train_labels(nnI))=ConMatrix(test_labels(loop),train_labels(nnI)) + 1;
	end
ConMatrix
accuracy = trace(ConMatrix)/ sum(ConMatrix(:))	* 100 
end
