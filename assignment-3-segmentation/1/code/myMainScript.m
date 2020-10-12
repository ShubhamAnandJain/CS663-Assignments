%% MyMainScript
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% Your code here

boat_im = load('../data/boat.mat');
boat_im = double(cell2mat(struct2cell(boat_im)));

boat_im_blur = nlfilter(boat_im, [5,5], @(x) myGaussianBlurring(x, 5, 0.6));

subplot(1,2,1), imagesc(boat_im);
daspect ([1 1 1]);
title('Original Image');
colorbar;
colormap (myColorScale);
colormap gray;

subplot(1,2,2), imagesc(boat_im_blur);
daspect ([1 1 1]);
title('Blurred Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
[partialX, partialY, grad_im, eigen_prim, eigen_second, cornerness_im] = myHarrisCornerDetector(boat_im_blur, 5, 0.3, 0.001);
%%
imagesc(partialX);
daspect ([1 1 1]);
title('Partial Derivative along X axis');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(partialY);
daspect ([1 1 1]);
title('Partial Derivative along Y axis');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(grad_im);
daspect ([1 1 1]);
title('Gradient Plot');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(eigen_prim);
daspect ([1 1 1]);
title('Principal Eigenvalue of Structure Tensor');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(eigen_second);
daspect ([1 1 1]);
title('Other Eigenvalue of Structure Tensor');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(cornerness_im);
daspect ([1 1 1]);
title('Harris Cornerness Measure');
colorbar;
colormap (myColorScale);
colormap gray;
%%
toc;