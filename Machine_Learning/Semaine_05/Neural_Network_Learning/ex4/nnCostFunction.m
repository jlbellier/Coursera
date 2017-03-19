function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

%fprintf("\nsize(Theta1) = %d %d",size(Theta1,1), size(Theta1,2));
%fprintf("\nsize(Theta2) = %d %d",size(Theta2,1), size(Theta2,2));
%fprintf("\nsize(X) = %d %d",size(X,1), size(X,2));
%fprintf("\nsize(y) = %d %d",size(y,1), size(y,2));

% In this step; we implement the successive forward computations of a2 and a3. 
a1 = [ones(m,1) X];
%fprintf("\nsize(a1) = %d %d",size(a1,1), size(a1,2));
z2 = a1*Theta1';
a2 = [ones(size(z2,1),1) sigmoid(z2)];
%fprintf("\nsize(a2) = %d %d",size(a2,1), size(a2,2));

z3 = a2*Theta2';
a3 = sigmoid(z3);
%fprintf("\nsize(a3) = %d %d",size(a3,1), size(a3,2));
% hypothesis function is the result of the third layer
h = a3;

%fprintf("\nsize(h) = %d %d",size(h,1), size(h,2));
% Here we transform the original vector y to a matrix Y with the corresponding value of y is mapped to 1, the other  to 0 
% This matrix has the same size of the matrix X
Y = zeros(m,num_labels);
for i = 1:num_labels
	Y(:,i) = (y == i);
end


% The function J is computed using the product of matrix Y and h using the sigmoid function. The product is done element by element 
% and then we sum up all the result
J = sum(sum(-log(h).*Y - (1-Y).*log(1-h)))/m; 

% Implement regularization :
% In this step we use the regularization coefficient lambda anf the matrices Theta1 and Theta2, but without the first column
Theta1bis = Theta1(:,2:end);
Theta2bis = Theta2(:,2:end);

J = J + lambda*(sum(sum(Theta1bis.*Theta1bis)) + sum(sum(Theta2bis.*Theta2bis)))/(2*m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here we implement backpropagation. The goal is to compute the partial derivatives Theta1_grad and Theta2_grad of the cost function 
% with respect to Theta1 and Theta2. 
% 

 delta3 = a3.-Y;
 delta2 = (delta3*Theta2(:,2:end)).*sigmoidGradient(z2); 
 % remove first element of delta2
 %delta2 = delta2(:,2:end);
 fprintf("\nsize(delta2) = %d %d",size(delta2,1), size(delta2,2));
 % Accumulate gradients to Delta2 and Delta1
 
 Delta3 = delta3'*a2;
 Delta2 = delta2'*a1;
fprintf("\nsize(Delta3) = %d %d",size(Delta3,1), size(Delta3,2));
fprintf("\nsize(Delta2) = %d %d",size(Delta2,1), size(Delta2,2));

% calculate regulaired gradient
p1 = (lambda/m)*[zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
p2 = (lambda/m)*[zeros(size(Theta2, 1), 1) Theta2(:, 2:end)];
Theta1_grad = Delta2/m + p1;
Theta2_grad = Delta3/m +p2;


% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
