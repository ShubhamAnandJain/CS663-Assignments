function [orig_img, he_img] = myIntensitytxm(pth)
    orig_img = imread(pth);
    %alpha=double(median(orig_img,'all')/255);
    he_img = zeros(size(orig_img));
    for channel = 1:size(orig_img, 3)
    % calculate histogram
        [counts, ~] = imhist(orig_img(:,:,channel)); % ~ means ignore    
        % calculate cdf
        alpha=double(median(orig_img(:,:,channel),'all'))/255;
        disp(alpha);
        cut =floor(alpha*size(counts));
        mcdf1 = cumsum(counts(1:1:cut)).*(alpha/sum(counts(1:1:cut)));
        mcdf2 = alpha+cumsum(counts(cut+1:1:end)).*((1-alpha)/sum(counts(cut+1:1:end)));
        tfm=cat(1,mcdf1,mcdf2);
        plot(tfm);    
        % index using CDF values
        he_img(:,:,channel) = tfm(orig_img(:,:,channel)+1);
    end
end