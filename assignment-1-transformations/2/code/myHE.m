function [orig_img, he_img] = myHE(pth)
    % read imgs
    orig_img = imread(pth);    
    he_img = zeros(size(orig_img));
    
    for channel = 1:3
    % calculate histogram
        [counts, ~] = imhist(orig_img(:,:,channel)); % ~ means ignore    
        % calculate cdf
        cdf = cumsum(counts)/sum(counts);
        % plot(cdf)    
        % index using CDF values
        flat = reshape(orig_img(:,:,channel), [], 1);
        he_img_flat = cdf(flat+1); % +1 due to indexing
        he_img(:,:,channel) = reshape(he_img_flat, size(orig_img(:,:,channel)));
    end
end