%% MyMainScript
clear
clc
tic;
%% Your code here
[orig, new] = myIntensitytxm('../data/underexposedimage.jpg');
[orig1, new1] = myHE('../data/underexposedimage.jpg');
subplot(3,2,1)
imshow(orig)
subplot(3,2,2)
plot(imhist(orig))
subplot(3,2,3)
imshow(new)
subplot(3,2,4)
plot(imhist(new))
subplot(3,2,5)
imshow(new1)
subplot(3,2,6)
plot(imhist(new1))
%% df
toc;