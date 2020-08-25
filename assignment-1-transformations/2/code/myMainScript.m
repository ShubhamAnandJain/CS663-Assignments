%% MyMainScript
clear
clc

%2a
% [image, mask, foreground] = myForegroundMask('../data/statue.png');
% subplot(1, 3, 1)
% imshow(image)
% subplot(1, 3, 2)
% imshow(mask)
% subplot(1, 3, 3)
% imshow(foreground)

%2b
% [original, new] = myLinearContrastStretching('../data/retina.png');
% subplot(1, 2, 1)
% imagesc(original)
% subplot(1, 2, 2)
% imagesc(new)

%2c
% [orig, new] = myHE('../data/church.png');
% subplot(1, 2, 1)
% imshow(orig)
% subplot(1, 2, 2)
% imshow(new)

%2d
% [ref_img, input_img, hm_img] = myHM('../data/retina.png', '../data/retinaRef.png');
% subplot(1, 3, 1)
% imshow(ref_img)
% subplot(1, 3, 2)
% imshow(input_img)
% subplot(1, 3, 3)
% imshow(hm_img)

%2e
[orig, clahe] = myCLAHE('../data/barbara.png', 10);
subplot(1, 2, 1)
imshow(orig)
subplot(1, 2, 2)
imshow(clahe)
