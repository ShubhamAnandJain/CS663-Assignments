%% Q1: Image Sharpening using Unsharp Masking

% Let F be the original image, G be the Gaussian filter. Steps:
%%
% # F*G (F convolved with G) gives a low-pass version of the image.
% # Subtracting this low-pass version of F from F i.e. F - F*G can be
% considered as the high-pass version of F since the low-pass components
% have been subtracted.
% # Adding a scaled version of this high-pass version i.e. F + s(F - F*G)
% enhances the edges since they can be considered as the high-pass
% components of an image. s is a scaling factor which needs to be tuned.

%% Image 1

% Parameters:
%%
% * Standard deviation of Gaussian: 3
% * Scaling factor: 0.6

clc
imstruct = load('../data/lionCrop.mat');
im = imstruct.imageOrig;
filter_len = 25;
sigma = 3;
scaling = 0.6;
[orig, sharp, mask] = myUnsharpMasking(im, filter_len, sigma, scaling);
f = figure('visible', 'on');
subplot(1, 2, 1)
imshow(mat2gray(orig))
title("Original Image");
subplot(1, 2, 2)
imshow(mat2gray(sharp))
title("Sharp Image");
%%
f = figure('visible', 'on');
subplot(1, 1, 1)
imshow(mat2gray(imresize(mask, 0.5)))
title("High-pass version which is added");

%% Image 2

% Parameters:
%%
% * Standard deviation of Gaussian: 6
% * Scaling factor: 0.2

clc
imstruct = load('../data/superMoonCrop.mat');
im = imstruct.imageOrig;
filter_len = 20;
sigma = 6;
scaling = 0.2;
[orig, sharp, mask] = myUnsharpMasking(im, filter_len, sigma, scaling);
f = figure('visible', 'on');
subplot(1, 2, 1)
imshow(mat2gray(orig))
title("Original Image");
subplot(1, 2, 2)
imshow(mat2gray(sharp))
title("Sharp Image");
%%
f = figure('visible', 'on');
subplot(1, 1, 1)
imshow(mat2gray(imresize(mask, 0.5)))
title("High-pass version which is added");