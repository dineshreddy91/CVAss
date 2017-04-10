function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_a' and 'act_h' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

l = length(W);
y = exp(W{l}*act_h{l-1} + b{l});
grad_i = y./sum(y) - Y;
for i=l:-1:2
    [m,n] = size(W{i});
    grad_W{i} = repmat(grad_i,1,n).*repmat(act_h{i-1}',m,1);
    grad_b{i} = grad_i;
    grad_j = sum(repmat(grad_i,1,n).*W{i})';
    grad_i = grad_j.*(act_h{i-1}.*(1-act_h{i-1}));
end
[m,n] = size(W{1});
grad_W{1} = repmat(grad_i,1,n).*repmat(X',m,1);
grad_b{1} = grad_i;