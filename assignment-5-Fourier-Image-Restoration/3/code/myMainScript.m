%% Q3
%%
% To remove the periodic noise, we apply a notch filter. The steps are
% given below:
%
% # Pad the HxW image to get a 2Hx2W image.
% # Calculate the 2D Fourier Transform.
% # Examine the log magnitude plot to find the noise frequency. Say bin (x, y) corresponds to the noise.
% # Apply a notch filter centred at (x,y). The notch filter has a one sided-window
% of length 7 such that the border pixels have an attenuation of $10^{-3}$
% and as we move in towards the centre, the attenuation of all 8 pixels
% which are equidistant from the centre gets multiplied by $10^{-3}$.
% # Since the image is real, the plot is symmetric about the centre frequency.
% hence, we need to apply the same filter to the pixel which is symmetrically located from
% (x,y), across the centre bin.
% # Calculate the inverse 2D DFT and crop out the central HxW portion. This
% is the final desired filtered image.
%
% Load noisy image
orig = load('../data/image_low_frequency_noise.mat').Z;
% pad and fourier
padding = size(orig)./2;
padded_image = padarray(orig, padding);
padded_fourier = fftshift(fft2(padded_image));
log_fourier = log(abs(padded_fourier)+1);
% imagesc(log_fourier);
% colorbar;
% apply filter
filtered_fourier = myNotchFilter(padded_fourier, 277, 266);
log_fil_fourier = log(abs(filtered_fourier)+1);
% imagesc(log_fil_fourier);
% colorbar;
% get back original image
filtered = real(ifft2(ifftshift(filtered_fourier)));
% crop
filtered = filtered(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2)); 
% imagesc(filtered);
%% Images
subplot(2,1,1), imagesc(orig);
daspect([1 1 1]);
title('Original');
subplot(2,1,2), imagesc(filtered);
daspect([1 1 1]);
title('Filtered');
%% Fourier plots
subplot(2,1,1), imagesc(log_fourier);
daspect([1 1 1]);
title('Original');
subplot(2,1,2), imagesc(log_fil_fourier);
daspect([1 1 1]);
title('Filtered');
% colorbar;

% without padding
% %% get FT
% orig_fourier = fftshift(fft2(orig));
% log_fourier = log(abs(orig_fourier)+1);
% imagesc(log_fourier);
% colorbar;
% %% zero out the components
% filtered_fourier = myNotchFilter(orig_fourier, 139, 134);
% log_fil_fourier = log(abs(filtered_fourier)+1);
% imagesc(log_fil_fourier);
% colorbar;
% %% reconstruct
% filtered = real(ifft2(ifftshift(filtered_fourier)));
% imagesc(filtered);
