%% MyMainScript
clear
clc
tic;
%% Your code here
[orig, new] = myIntensitytxm('../data/nightsky.jpg');
[orig1, new1] = myHE('../data/nightsky.jpg');
subplot(1,3,1)
imshow(orig)
subplot(1,3,2)
imshow(new)
subplot(1,3,3)
imshow(new1)


%% whate
pth = '../data/canyon.png';
orig_img = imread(pth);
%alpha=double(median(orig_img,'all')/255);

he_img = zeros(size(orig_img));
for channel = 1:size(orig_img, 3)
% calculate histogram
    [counts, ~] = imhist(orig_img(:,:,channel)); % ~ means ignore
    alpha=double(median(orig_img(:,:,channel),'all'))/255;
    disp(alpha)
    % calculate cdf
    cut =floor(alpha*size(counts));
    mcdf1 = cumsum(counts(1:1:cut)).*(alpha/sum(counts(1:1:cut)));
    mcdf2 = alpha+cumsum(counts(cut+1:1:end)).*((1-alpha)/sum(counts(cut+1:1:end)));
    %f1 = mcdf1.*(sum(counts(1:1:cut))/sum(cdf1));
    %f2 = mcdf2.*(sum(counts(cut+1:1:end))/sum(cdf2));
    tfm=cat(1,mcdf1,mcdf2);
    plot(tfm);    
    % index using CDF values
    he_img(:,:,channel) = tfm(orig_img(:,:,channel)+1);
end
%% aom
for channel = 1:size(orig_img, 3)
% calculate histogram
    [counts, ~] = imhist(orig_img(:,:,channel)); % ~ means ignore  
    [counts1, ~] = imhist(he_img(:,:,channel));
    % calculate cdf
    cut =floor(alpha*size(counts));
    disp(cut);
    sum1 = sum(counts(1:1:cut));
    sum2 = sum(counts(cut+1:1:end));
    sum3 = sum(counts1(1:1:cut));
    sum4 = sum(counts1(cut+1:1:end));
    %disp(sum1);
    %disp(sum3);
    %disp(sum2);
    %disp(sum4); 
    
end
imshow(he_img);
%x = 1:length(tfm);
%plot(x,tfm);
%% plot
subplot(1,2,1)
imshow(he_img)
subplot(1,2,2)
imshow(orig_img)
%% df
toc;