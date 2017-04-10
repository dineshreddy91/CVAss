function [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate)
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate) computes and returns the
% new network parameters 'W' and 'b' with respect to the old parameters, the
% gradient updates 'grad_W' and 'grad_b', and the learning rate.

l = length(W);
for i=1:l
    W{i} = W{i} - learning_rate.*grad_W{i};
    b{i} = b{i} - learning_rate.*grad_b{i};
end

