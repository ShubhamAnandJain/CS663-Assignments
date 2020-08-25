%% MyMainScript

%needed for correct plotting of images
%keeping number of colours per intensity to be 200
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% Your code here
circle_concentric_1 = imread('../data/circles_concentric.png');

%shrink the image by different factors
circle_concentric_2 = myShrinkImageByFactorD(circle_concentric_1,2);
circle_concentric_3 = myShrinkImageByFactorD(circle_concentric_1,3);

%plot the images side-by-side
subplot(1,3,1), imagesc(circle_concentric_1);
daspect ([1 1 1]);
colorbar;
subplot(1,3,2), imagesc(circle_concentric_2);
daspect ([1 1 1]);
colorbar;
subplot(1,3,3), imagesc(circle_concentric_3);
daspect ([1 1 1]);
colorbar;
axis tight;
colormap (myColorScale);
colormap gray;

%% Part b
bar = imread('../data/barbaraSmall.png');
bar = double(bar)/255;
[row_bar, col_bar] = size(bar);
output_dim = [row_bar*3-2, col_bar*2-1];

% phi_x[i][j], phi_y[i][j] represents where position (i,j) in output
% image comes from - value will be some real valued x and real valued y
% in the input image
[phi_y, phi_x] = meshgrid(1:output_dim(2),1:output_dim(1));

%make the correct phi_x, phi_y for resizing
phi_x = (phi_x + 2) / 3;
phi_y = (phi_y + 1) / 2;

%do the interpolation
biliterpbar = myBilinearInterpolation(bar, phi_x, phi_y);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,2,1), imagesc(single(biliterpbar)); % phantom is a popular test image
daspect ([103/307 103/205 1]);
colorbar
subplot(1,2,2), imagesc(single(bar));
daspect ([1 1 1]);
colorbar

%% Part c
NNiterpbar = myNearestNeighborInterpolation(bar, phi_x, phi_y);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,2,1), imagesc(single(NNiterpbar)); % phantom is a popular test image
daspect ([103/307 103/205 1]);
colorbar
subplot(1,2,2), imagesc(single(bar));
daspect ([1 1 1]);
colorbar

%% Part d
bicubic_iterp_bar = myBicubicInterpolation(bar, phi_x, phi_y);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,2,1), imagesc(single(bicubic_iterp_bar)); % phantom is a popular test image
daspect ([103/307 103/205 1]);
colorbar
subplot(1,2,2), imagesc(single(bar));
daspect ([1 1 1]);
colorbar
%% Part e
%We just show Barbara's head, smoothed using different methods
barbara_face = bar(1:50,54:103);

[face_phi_y, face_phi_x] = meshgrid(1:100,1:100);
face_phi_x = (face_phi_x + 1) / 2;
face_phi_y = (face_phi_y + 1) / 2;

barbara_face_NN = myNearestNeighborInterpolation(barbara_face, face_phi_x, face_phi_y);
barbara_face_bilinear = myBilinearInterpolation(barbara_face, face_phi_x, face_phi_y);
barbara_face_bicubic = myBicubicInterpolation(barbara_face, face_phi_x, face_phi_y);

axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,4,1), imagesc(single(barbara_face)); % phantom is a popular test image
daspect ([1 1 1]);
colorbar
subplot(1,4,2), imagesc(single(barbara_face_NN));
daspect ([1/2 1/2 1]);
colorbar
subplot(1,4,3), imagesc(single(barbara_face_bilinear));
daspect ([1/2 1/2 1]);
colorbar
subplot(1,4,4), imagesc(single(barbara_face_bicubic));
daspect ([1/2 1/2 1]);
colorbar
%% Part f
padded_bar = zeros(140,140);
padded_bar(20:122,20:122) = bar;
final = myImageRotation(padded_bar, 30);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,2,1), imagesc(bar);
daspect ([1 1 1]);
colorbar
subplot(1,2,2), imagesc(final);
daspect ([1 1 1]);
colorbar

%% new section
toc;