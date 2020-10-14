%% MyMainScript

tic;
%% Your code here
%sigmasp = 1;
%densp=1/(sigmasp*sqrt(2*pi));
%excoefsp= -1/(2*sigmasp^2);
%pad = 2;
%Gauss = zeros(2*pad+1,2*pad+1);
%for i = 1:2*pad+1
%    for j = 1:2*pad+1
%        Gauss(i,j)=exp(((i-pad-1)^2+(j-pad-1)^2)*excoefsp)*densp;
%    end
%end
%%
im = imread('../data/baboonColor.png');
%im = imread('../data/bird.jpg');
%smoothened = imfilter(im,Gauss,'conv');
smoothened = imgaussfilt(im,1);
subsamp = smoothened(1:2:end,1:2:end,:);

subplot(1, 3, 1)
imshow(im)
subplot(1, 3, 2)
imshow(smoothened)
subplot(1,3,3)
imshow(subsamp)
%% Meanshift
tic;
mnshf = myMeanShiftSegmentation(double(subsamp)./255,10,50,10,800,0.2);
subplot(1, 2, 1)
imshow(im)
subplot(1, 2, 2)
imshow(mnshf)
toc;
%%
subplot(1, 3, 1)
imshow(im)
subplot(1, 3, 2)
imshow(mnshf)
subplot(1,3,3)
imshow(subsamp)
%%
%im = imread('../data/bird.jpg');
%im = imread('../data/flower.jpg');
disp(subsamp(1,1,:));
%%
toc;
