%% MyMainScript

tic;
%% Your code here
imstruct = load('../data/barbara.mat');
im = imstruct.imageOrig;
spread = range(im,'all');
noise = (0.05*spread).*randn(size(im,1));
ns = im + noise;
cleaned = myBilateralFiltering(ns,0.5,0.6);
subplot(1, 3, 1)
imshow(mat2gray(im))
subplot(1, 3, 2)
imshow(mat2gray(ns))
subplot(1, 3, 3)
imshow(mat2gray(cleaned))
%% not my code here
toc;
