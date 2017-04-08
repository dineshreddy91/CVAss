function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
output = Classify(W, b, data);
loss = -sum(log(dot(output,labels)));
[out out_label] = max(output');
[gt gt_label] = max(labels');
A = out_label-gt_label;
accuracy = sum(A(:)==0)/size(gt_label,2);
end
