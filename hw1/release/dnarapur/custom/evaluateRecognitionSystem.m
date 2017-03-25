function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

	% TODO Implement your code here
	source = '../data/';
	ConMatrix = zeros(8,8);
	dlmwrite('trainData.txt',[train_features ; train_labels']):

	test_features = [];
	for i=1:length(test_imagenames)
		visualImageName = [source, strrep(test_imagenames{i},'.jpg','.mat')];
		load(visualImageName);
		test_features = cat(2,test_features,getImageFeaturesSPM( 3 , ...
		    wordMap, size(dictionary,2)));
    	end
	dlmwrite('testData.txt',test_features);
	system('python train.py');
	results = dlmread('classification.txt');

for loop=1:length(test_imagenames)
 ConMatrix(test_labels(loop),results(loop))=ConMatrix(test_labels(loop),results(loop)) + 1;
end

ConMatrix
accuracy = trace(ConMatrix)/ sum(ConMatrix(:))	* 100 
end
