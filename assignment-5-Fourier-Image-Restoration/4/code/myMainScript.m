%% MyMainScript
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% Your code here
barbara = imread('../data/barbara256.png');
padding = size(barbara)./2;
padded_barbara = barbara;
% padded_barbara = padarray(barbara, padding);
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
imagesc(log(abs(H)+1));
title('Low Pass Filter');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 40);
imagesc(gauss_barbara);
title('Filtered Image, sigma = 40');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Gaussian Filter');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
toc;
