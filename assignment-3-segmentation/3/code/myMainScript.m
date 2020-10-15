%% Q3: Background blur

%% Image of a flower
%  Gaussian kernel bandwidth for the color feature : 200
%  Gaussian kernel bandwidth for the spatial feature : 40
%  Number of Iterations : 20
clc
img = imread('../data/flower.jpg');
alpha = 20;
downsample_fac = 1;
I = imresize(img, downsample_fac);
tic;
% foregroundMask = myForegroundMask(double(I),30,40,30,200,0.1);
% imwrite(foregroundMask, '/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/flower_foreground.png');
foregroundMask = imread('/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/flower_foreground.png');

[radiusMask, final] = myPipeline(I, foregroundMask, alpha);
subplot(1, 3, 1)
imshow(I)
title("Original Image");
subplot(1, 3, 2)
imshow(radiusMask./max(radiusMask));
title("Radius of blurring");
subplot(1, 3, 3)
imshow(final);
title("Final Image");
toc;

%% Image of a bird
%  Gaussian kernel bandwidth for the color feature : 40
%  Gaussian kernel bandwidth for the spatial feature : 30
%  Number of Iterations : 20
clc
img = imread('../data/bird.jpg');
alpha = 40;
downsample_fac = 0.25;
I = imresize(img, downsample_fac);
tic;
% foregroundMask = myForegroundMask(double(I),30,40,30,200,0.1);
% imwrite(foregroundMask, '/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/bird_foreground.png');
foregroundMask = imread('/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/bird_foreground.png');
[radiusMask, final] = myPipeline(I, foregroundMask, alpha);
subplot(1, 3, 1)
imshow(I)
title("Original Image");
subplot(1, 3, 2)
imshow(radiusMask./max(radiusMask));
title("Radius of blurring");
subplot(1, 3, 3)
imshow(final);
title("Final Image");
toc;

%% trial rectangles
% clc
% alpha = 20;
% img = zeros(100, 150);
% b = [(31:45)', 31*ones(15,1)];
% t = [(31:45)', 45*ones(15,1)];
% l = [31*ones(15,1), (31:45)'];
% r = [45*ones(15,1), (31:45)'];
% boundary = [b; t; l; r];
% for i = 1:size(boundary, 1)
%     img(boundary(i, 1), boundary(i, 2)) = 255;
% end
% subplot(1, 3, 1)
% imshow(img)
% y = myRadiusMap(img, boundary, alpha);
% subplot(1, 3, 2)
% imshow(y./max(y))
% z = myDiscBlur(img, y, alpha);
% subplot(1, 3, 3)
% imshow(z)