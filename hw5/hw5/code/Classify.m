function [outputs] = Classify(W, b, data)
% [predictions] = Classify(W, b, data) should accept the network parameters 'W'
% and 'b' as well as an DxN matrix of data sample, where D is the number of
% data samples, and N is the dimensionality of the input data. This function
% should return a vector of size DxC of network softmax output probabilities.

act_h = data * W{1} + b{1}';
act_a = 1./(1+exp(-act_h));
out_all = act_a * W{2} + b{2}';
A = exp(out_all);
outputs = bsxfun(@rdivide,A,sum(A')');
end
