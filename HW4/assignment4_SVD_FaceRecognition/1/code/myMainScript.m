% References:
% 1. https://in.mathworks.com/help/matlab/ref/eig.html
% 2. 

clear
clc
% input matrix
r = randi([1 100],2,1);
A = rand(r(1), r(2));
% A = eye(3);


% get result
[U, S, V] = mySVD(A);

% check
reconstructed = U*S*V';
norm(A-reconstructed)