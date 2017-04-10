num_epoch = 5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')

[Wi, bi] = InitializeNetwork(layers);
%use trained layers for 1st set of weights
load('../data/nist26_model_60iters.mat', 'W', 'b');

W{2} = Wi{2};
b{2} = bi{2};
 
accuracy_ForPlot = [];
loss = [];
for j = 1:num_epoch
    [W, b] = Train(W, b, train_data, train_labels, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    accuracy_ForPlot(:,j) = [train_acc;valid_acc];
    loss(:,j) = [train_loss;valid_loss];

    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f\n -aaaaaaaa', j, train_acc, valid_acc, train_loss, valid_loss)
end
figure,plot(accuracy_ForPlot(1,:),'r');
hold;
plot(accuracy_ForPlot(2,:),'b');
title('accuracy');
xlabel('Epochs');
ylabel('accuracy');
legend('Train','Validation');
figure,plot(loss(1,:),'r');
hold;
plot(loss(2,:),'b');
ylabel('Cross-entropy loss');
xlabel('Epochs');
title('Cross-entropy loss');
legend('Train','Validation');
save('nist36_model.mat', 'W', 'b')
