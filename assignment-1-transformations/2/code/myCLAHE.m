function [orig_img, clahe_img] = myCLAHE(pth, threshold, one_side_window)
%     threshold = 0.2;
%     one_side_window = 2; % half of the total window
%     pth = '../data/statue.png';
        
    orig_img = imread(pth);
%     orig_img = orig_img(1:2, 1:2, 1);
    num_rows = size(orig_img, 1);
    num_cols = size(orig_img, 2);
    clahe_img = zeros(size(orig_img));
    
    for channel = 1:size(orig_img, 3)
        cur_channel = orig_img(:,:,channel);
        % https://in.mathworks.com/help/images/ref/padarray.html
        % pad corners with 256 so that they can be removed later
        cur_channel_pad = padarray(cur_channel,[one_side_window, one_side_window],256,'both');
        
        for row = one_side_window+1:one_side_window+num_rows
            for col = one_side_window+1:one_side_window+num_cols
                l = row-one_side_window;
                r = row+one_side_window;
                t = col-one_side_window;
                b = col+one_side_window;
                chunk = cur_channel_pad(l:r,t:b);
                % calculate hist
                [counts, ~] = histcounts(chunk, 257); % ~ means ignore
                % remove padded 256s which are present in the 257th bin
                counts = counts(1:256);
                % pdf
                pdf = counts./sum(counts);
                % calculate total mass above threshold
                above_thresh = pdf > threshold;
                total_excess_mass = sum((pdf - threshold).*above_thresh);
                % redistribute it
                pdf = pdf + total_excess_mass/size(pdf, 1);
                % calculate cdf
                cdf = cumsum(pdf)/sum(pdf);
                % HE
                clahe_img(l:r, t:b, channel) = cdf(chunk+1);
            end
        end                  
%         plot(1:256, pdf);
%         hold on
    end
end