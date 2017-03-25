function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

	% TODO create train_features
	% TODO create train_features
	dictionary=dictionary';
    source = '../data/';
    train_features = [];
    for i=1:length(train_imagenames)
        visualImageName = [source, strrep(train_imagenames{i},'.jpg','.mat')];
        load(visualImageName);
        train_features = cat(2,train_features,getImageFeaturesSPM( 3, ...
            wordMap, size(dictionary,2)));
    end
	
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');
	
end

