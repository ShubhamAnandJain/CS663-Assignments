%% Q2: Edge-preserving Smoothing using Bilateral Filtering.

tic;
%% Image 1
%Optimized value of Sigma was found empirically to be 1.4 along space and
%10 along intensity axis. Note that exact values depend on the run as the
%random seed is not fixed.
imstruct = load('../data/barbara.mat');
im = imstruct.imageOrig;
spread = range(im,'all');
noise = (0.05*spread).*randn(size(im,1));
ns = im + noise;
cleaned = myBilateralFiltering(ns,1.0*1.4,0.9*10);
subplot(1, 3, 1)
imshow(mat2gray(im))
title("Original Image of Barbara");
subplot(1, 3, 2)
imshow(mat2gray(ns))
title("Corrupted Image of Barbara");
subplot(1, 3, 3)
imshow(mat2gray(cleaned))
title("Filtered Image of Barbara");
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));
%% 
%Denoised RMSD values for different (spatial sigma, intensity sigma) around optimal pair (1.4,10) are as follows-
%Without Filtering - 4.9991
%(1.4,10) - 3.2945 
%(0.9*1.4,10)- 3.3000 
%(1.1*1.4,10) - 3.2960
%(1.4,0.9*10) - 3.3185
%(1.4,1.1*10) - 3.3079

%% Second Image
%Optimized value of Sigma was found empirically to be 0.65 along space and 132 along intensity axis
im = imread('../data/grass.png');
im = double(im);
imstruct = load('../data/grassNoisy.mat');
ns = imstruct.imgCorrupt*255;
cleaned = myBilateralFiltering(ns,0.65*1.0,132*1.0);
subplot(1, 3, 1)
imshow(mat2gray(im))
subplot(1, 3, 2)
imshow(mat2gray(ns))
subplot(1, 3, 3)
imshow(mat2gray(cleaned))
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));
%% 
%Denoised RMSD values for different (spatial sigma, intensity sigma) around optimal pair (0.65,132) are as follows-
%Without Filtering - 21.9742
%(0.65,132) - 19.3553 
%(0.9*0.65,132)- 19.4379
%(1.1*0.65,132) - 19.4007
%(0.65,0.9*132) - 19.3597
%(0.65,1.1*132) - 19.3568
%% Third Image
%Optimized value of Sigma was found empirically to be 1.1 along space and 33 along intensity axis
im = imread('../data/honeyCombReal.png');
im = double(im);
imstruct = load('../data/honeyCombReal_Noisy.mat');
ns = imstruct.imgCorrupt*255;
cleaned = myBilateralFiltering(ns,1.1*1.0,33*1.0);
subplot(1, 3, 1)
imshow(mat2gray(im))
subplot(1, 3, 2)
imshow(mat2gray(ns))
subplot(1, 3, 3)
imshow(mat2gray(cleaned))
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));
%% 
%Denoised RMSD values for different (spatial sigma, intensity sigma) around optimal pair (1.1,33) are as follows-
%Without Filtering - 20.3205
%(1.1,33) - 17.5259 
%(0.9*1.1,33)- 17.5300 
%(1.1*1.1,33) - 17.5602
%(1.1,0.9*33) - 17.5521
%(1.1,1.1*33) - 17.5284

toc;
