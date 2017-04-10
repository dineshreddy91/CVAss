clear all;
close all;
clc;
%load('nist26_model_intialize_0.01.mat');
%load('nist26_model_0.01.mat');
%load('nist36_model.mat');
load('../data/nist26_model_60iters.mat');
load('../data/nist36_test.mat', 'test_data', 'test_labels');
layer = W{1};
for i = 1:size(W{1},1)
    im = reshape(W{1}(i,:),[32,32]);
    images(:,:,:,i) = double2rgb(im,jet);
end
montage(images)
outputs= Classify(W, b, test_data);
[c,cm,ind,per] =confusion(test_labels',outputs');
%imagesc(cm);