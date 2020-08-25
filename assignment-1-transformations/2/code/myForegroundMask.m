function [original, mask, foreground] = myForegroundMask(pth)
    original = imread(pth);
    threshold = 11;
    mask = uint8(original > threshold);
    foreground = original.*mask;    
end
