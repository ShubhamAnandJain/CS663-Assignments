%% MyMainScript

tic;
%% Your code here
im = imread('../data/circles_concentric.png');
figure,imshow(im);
y = myShrinkImageByFactorD(im,10);
figure,imshow(y);
%% Part b
bar = imread('../data/barbaraSmall.png');
disp(bar);
biliterp = myBilinearInterpolation(bar);
figure,imshow(bar);
figure,imshow(biliterp);
%% Part c
NNiterp = myNearestNeighborInterpolation(bar);
figure,imshow(bar);
figure,imshow(NNiterp);

%% Part d

%% Part e

%% Part f
myImageRotation
%% Reference for ColorMap
%myNumOfColors = 200;
%myColorScale = [ [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
%imagesc (single (y)); % phantom is a popular test image
%colormap (myColorScale);
%colormap jet;
%daspect ([1 1 1]);
%axis tight;
%colorbar

%% new section
toc;