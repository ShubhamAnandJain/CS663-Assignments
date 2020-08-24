function [img, new_val] = myLinearContrastStretching(path)
    % read images
    img = double(imread(path))/255;
    % broadcasting is used. No need of iterating over channels
    img_max = max(img, [], [1 2]);
    img_max(1, 1, :) = img_max;
    img_min = min(img, [], [1 2]);
    img_min(1, 1, :) = img_min;
    new_val = (img-img_min)./(img_max-img_min);
    
end

% piecewise linear
% slope1 = 0.5;
% pt1 = 64;
% slope2 = 1.5;
% pt2 = 128;
% slope3 = 0.5;
% pt3 = 64;
% % ensure range
% assert(slope1*pt1 + slope2*pt2 + slope3*pt3 == 256);
% % calculate new image
% new_val = (img*slope1).*uint8(img < pt1);
% new_val = new_val + ((img-pt1)*slope2+pt1*slope1).*uint8(img<pt2 & img>=pt1);
% new_val = new_val + ((img-pt1-pt2)*slope3+pt2*slope2+pt1*slope1).*uint8(img >= pt1+pt2);