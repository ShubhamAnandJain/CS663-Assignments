%% MyMainScript

tic;
%% Your code here
clc
imstruct = load('../data/barbara.mat');
im = imstruct.imageOrig;
spread = range(im,'all');
noise = (0.05*spread).*randn(size(im,1));
ns = im + noise;
cleaned = myBilateralFiltering(ns,10,10);
subplot(1, 3, 1)
imshow(mat2gray(im))
subplot(1, 3, 2)
imshow(mat2gray(ns))
subplot(1, 3, 3)
imshow(mat2gray(cleaned))
%% error calc
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));
disp(rmsd);
disp(ogrmsd);
%% not my code here
toc;
