function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.
W{1} = sqrt(1/layers(1)) * randn(layers(1),layers(2));
b{1}= randn(layers(2),1);
W{2} = sqrt(1/layers(2)) * randn(layers(2),layers(3));
b{2}= randn(layers(3),1);
end
