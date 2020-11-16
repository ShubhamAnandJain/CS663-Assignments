%% Q4
% References used for this problem:
%
% 1) https://in.mathworks.com/help/matlab/ref/fftshift.html
%
% 2) https://in.mathworks.com/help/matlab/ref/fft2.html
%
% 3) https://in.mathworks.com/help/matlab/ref/ifft2.html
%
% 4) https://in.mathworks.com/help/matlab/ref/ifftshift.html
%
% 5) https://in.mathworks.com/help/images/ref/padarray.html
%
%
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% a) Ideal Low Pass Filter
% D was taken to be 40, 60, 80
%
% We observe that, even though high frequency information is removed, the
% amount of ringing in the image has increased, and thus the image is not
% very pleasant to look at. Thus, this is clearly undesirable.
barbara = imread('../data/barbara256.png');
padding = size(barbara)./2;
padded_barbara = barbara;
padded_barbara = padarray(barbara, padding);
imagesc(padded_barbara);
title('Original Image');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[low_pass_barbara, H] = idealLowPassFilter(padded_barbara, 40);
% low_pass_barbara = low_pass_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(low_pass_barbara);
title('Filtered Image, D = 40');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[low_pass_barbara, H] = idealLowPassFilter(padded_barbara, 60);
% low_pass_barbara = low_pass_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(low_pass_barbara);
title('Filtered Image, D = 60');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[low_pass_barbara, H] = idealLowPassFilter(padded_barbara, 80);
% low_pass_barbara = low_pass_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(low_pass_barbara);
title('Filtered Image, D = 80');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Low Pass Filter Frequency plot, D = 80, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%% b) Gaussian Filter
% Sigma was taken to be 40, 60, 80
%
% Not much ringing is observed. There is smoothening of the image and
% blurring of the edges as in the previous attempt, and you can see some
% high frequency components in the face region and elsewhere, which were removed in the previous part.
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 40);
imagesc(gauss_barbara);
title('Filtered Image, sigma = 40');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 60);
imagesc(gauss_barbara);
title('Filtered Image, sigma = 60');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 80);
imagesc(gauss_barbara);
title('Filtered Image, sigma = 80');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Gaussian Filter Frequency plot, sigma = 80, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
toc;
