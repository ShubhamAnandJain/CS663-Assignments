function [radiusMask, final] = myPipeline(I, foregroundMask, alpha)
    
    foreground = bwareafilt(foregroundMask,1);    
    fprintf("Extracted largest contour\n");
    % find boundary of largets contour = foreground
    bd = edge(foreground,'Canny');
    [rows,cols] = find(bd);
    boundary = [cols, rows];
    fprintf("Found boundaries\n");
    % find radius map
    radiusMask = myRadiusMap(I, boundary, alpha);
    foreground = logical(foreground);
    radiusMask(foreground) = 0;
    fprintf("Found radius map\n");
    % blur
    final = uint8(myDiscBlur(I, radiusMask, alpha));

