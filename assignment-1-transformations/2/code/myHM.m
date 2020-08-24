function [ref_img, input_img, hm_img] = myHM(ref_pth, input_pth)
%     ref_pth = '../data/retina.png';
%     input_pth = '../data/retinaRef.png';
    % read images
    ref_img = imread(ref_pth);
    input_img = imread(input_pth);
    hm_img = zeros(size(input_img));
    
    for channel = 1:3
        % calculate histogram
        [ref_counts, ~] = imhist(ref_img(:,:,channel)); % ~ means ignore
        [input_counts, ~] = imhist(input_img(:,:,channel)); % ~ means ignore    
        % calculate cdf
        ref_cdf = cumsum(ref_counts)/sum(ref_counts);
        ref_cdf_uint8 = uint8(255*ref_cdf);
        % calculate inverse. Fill  0s with previous value
        inverse_ref_cdf = zeros(256, 1);
        inverse_ref_cdf(ref_cdf_uint8) = 1:256;
        inverse_ref_cdf(inverse_ref_cdf == 0) = NaN;
%         inverse_ref_cdf = fillmissing(inverse_ref_cdf, 'next');
%         inverse_ref_cdf = fillmissing(inverse_ref_cdf, 'previous'); % for final NaNs
        inverse_ref_cdf = fillmissing(inverse_ref_cdf, 'linear');
        % linear interpolation at boundaries may cause problems
        inverse_ref_cdf(inverse_ref_cdf > 255) = 255;
        inverse_ref_cdf(inverse_ref_cdf < 0) = 0;
                       
%         plot(1:256, inverse_ref_cdf(ref_cdf_uint8))
%         hold on

        % plot cdf and inverse to check visually
    %     plot(1:256, ref_cdf_uint8)
    %     hold on
    %     plot(1:256, inverse_ref_cdf)
    %     hold off

        input_cdf = cumsum(input_counts)/sum(input_counts);

        % index using CDF values
        input_flat = reshape(input_img(:,:,channel), [], 1);
        temp = uint8(255*input_cdf(input_flat+1)); % +1 due to indexing
        hm_img_flat = inverse_ref_cdf(temp);
        hm_img(:, :, channel) = reshape(hm_img_flat, size(input_img(:,:,channel)))/255;
    end   
end