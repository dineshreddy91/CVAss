from __future__ import absolute_import, division, print_function

import tflearn
import numpy as np


# input data
input = np.loadtxt("trainData.txt", delimiter=',') 
X = np.transpose(input[0:4200])
num = input[4200].astype(int)
Y = np.zeros([len(X),8])
for j in range(0,len(num)):
	Y[j][num[j]-1] = 1

# network architecture	
net = tflearn.input_data(shape=[None, 4200])
net = tflearn.fully_connected(net, 16)
#net = tflearn.fully_connected(net,32)
net = tflearn.fully_connected(net, 8, activation='softmax')
net = tflearn.regression(net, optimizer='adam', loss='categorical_crossentropy')
model = tflearn.DNN(net)
model.fit(X, Y, n_epoch=100)
model.save('my_model.tflearn')
#model.load('my_model.tflearn')
#print("\nTest prediction for x = 3.2, 3.3, 3.4:")

# test data
test = np.loadtxt("testData.txt", delimiter=',')
results = model.predict(np.transpose(test))
final = np.zeros(len(results))

for j in range(0,len(results)):
	a = 0
	for k in range(0,8):
		if results[j][k]> a:
			final[j] = k+1
			a = results[j][k]


np.savetxt('classification.txt',final)

print(final)

