num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_test.mat', 'test_data', 'test_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')

[W, b] = InitializeNetwork(layers);
save('nist26_model_intialize_0.01.mat', 'W', 'b')
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
save('nist26_model_0.01.mat', 'W', 'b')
