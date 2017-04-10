function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
outputs = Classify(W, b, data);
loss = -sum(log(sum(outputs.*labels,2)))/size(labels,1);
max_prob = (repmat(max(outputs')',1,size(labels,2)) == outputs);
accuracy = sum(sum(max_prob.*labels))*100/size(labels,1);
end
