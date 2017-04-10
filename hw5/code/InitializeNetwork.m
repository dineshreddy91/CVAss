function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN1, HIDDEN2, ..., OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and in between are the number of hidden units in each of the layers.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

l = length(layers)-1;
W = cell(1,l);
b = cell(1,l);
%weights towards one neuron: zero mean, sqrt(2/n) gaussian
for i=1:l
    n = layers(i);
    k = layers(i+1);
    % weight towards one neuron
    W{i} = sqrt(2/n).*randn(n,k)';
    %b{i} = 0.01*sqrt(2/n).*randn(k,1);
    b{i} = zeros(k,1);
end
