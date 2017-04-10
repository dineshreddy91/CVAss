%given a random input, W and b compare the gradients w.r.t network we
%implemnted earlier (softmax output with sigmoid activations)

% if difference between any randomly picked numerical and analytical gradient is
% more than 'th', counts as an error

%random input vector
classes = 26;
layers = [32*32, 400, classes];

load('../data/nist26_train.mat', 'train_data', 'train_labels');
X = train_data(100,:)';
Y = train_labels(100,:)';
eps = 1e-4;
th = 5e-5;
% How many random indices to check for in each weight matrix and bias?
checkmat = 100;
checkbias = 10;
count = 0;  %above threshold count

[W, b] = InitializeNetwork(layers);
[~, act_h, act_a] = Forward(W, b, X);
[grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);

l = length(W);
J = W;
h = b;
for i=1:l
    [m,n] = size(J{i});
    ind = randperm(m*n,checkmat);
    for k=1:length(ind)
        J{i}(ind(k)) = W{i}(ind(k)) + eps;
        [~,loss1] = ComputeAccuracyAndLoss(J, b, X', Y');
        J{i}(ind(k)) = W{i}(ind(k)) - eps;
        [~,loss2] = ComputeAccuracyAndLoss(J, b, X', Y');
        if abs(grad_W{i}(ind(k)) - ((loss1-loss2)/(2*eps)))>th
            count = count+1;
            abs(grad_W{i}(ind(k)) - ((loss1-loss2)/(2*eps)))
            fprintf('weight \n');
        end
    end
    ind = randperm(length(b{i}),checkbias);
    for k=1:length(ind)
        h{i}(ind(k)) = b{i}(ind(k)) + eps;
        [~,loss1] = ComputeAccuracyAndLoss(W, h, X', Y');
        h{i}(ind(k)) = b{i}(ind(k)) - eps;
        [~,loss2] = ComputeAccuracyAndLoss(W, h, X', Y');
        if abs(grad_b{i}(ind(k)) - ((loss1-loss2)/(2*eps)))>th
            count = count+1;
            abs(grad_b{i}(ind(k)) - ((loss1-loss2)/(2*eps)))
            fprintf('bias \n');
        end
    end
end
if count == 0
    fprintf('Gradient check successful!\n');
else
    fprintf('Check if threshold isnt too low, else error: count = %d\n',count);
end