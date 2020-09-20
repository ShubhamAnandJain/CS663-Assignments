%%References
% https://in.mathworks.com/matlabcentral/answers/13020-2d-gaussian-function
%% MyMainScript
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%%
% images = {'../data/barbara.mat', '../data/grass.png', '../data/honeyCombReal.png'};
images = {'../data/grass.png'};

for im = 1:length(images)
    path = images{im};
    input_im = 0;
    if (im ~= 1)
        input_im = load(path);
        input_im = cell2mat(struct2cell(input_im));
    else
        input_im = imread(path);
    end
    input_im = double(input_im);
    spread = range(input_im,'all');
    noise = (0.05*spread)*randn(size(input_im,1));
    
%     subplot(1,2,1), imagesc(input_im);
%     daspect ([1 1 1]);
%     title('Original Image');
%     colorbar;
%     colormap (myColorScale);
%     colormap gray;
    
    input_im = input_im + noise;
    
    subplot(1,2,1), imagesc(input_im);
    daspect ([1 1 1]);
    title('Corrupted Image');
    colorbar;
    colormap (myColorScale);
    colormap gray;
    
%     input_im = nlfilter(input_im, [5,5], @(x) GaussianBlurring(x));
%     input_im = myShrinkImageByFactorD(input_im, 2);
    
%     subplot(1,2,2), imagesc(input_im);
%     daspect ([1 1 1]);
%     title('Blurred Image');
%     colorbar;
%     colormap (myColorScale);
%     colormap gray;
    
    output_im = myPatchBasedFiltering(input_im);
%     imshow(output_im);
    subplot(1,2,2), imagesc(output_im);
    daspect ([1 1 1]);
    title('Output Image');
    colorbar;
    colormap (myColorScale);
    colormap gray;
    
end

%% Your code here

toc;
