function [grad_W, grad_b] = Backward(W, b, X, Y, act_a, act_h)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_a, act_h) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_a' and 'act_h' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

E = Y - act_h{2};
grad_W{2} = (act_a{1})' * (E.*act_a{2}).*(1-act_a{2});
grad_b{2} = (E.*act_a{2}).*(1-act_a{2});
E = (E.*(act_a{2}).*(1-act_a{2}))*W{2}';
grad_W{1} = X' * (E.*act_a{1}).*(1-act_a{1});
grad_b{1} = (E.*act_a{1}).*(1-act_a{1});
end

