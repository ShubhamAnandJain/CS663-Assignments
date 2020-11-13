%% Q3
%% Load noisy image
orig = load('../data/image_low_frequency_noise.mat').Z;
%% get FT
orig_fourier = fftshift(fft2(orig));
log_fourier = log(abs(orig_fourier)+1);
imagesc(log_fourier);
colorbar;
%% zero out the components
filtered_fourier = myNotchFilter(orig_fourier, 139, 134);
log_fil_fourier = log(abs(filtered_fourier)+1);
imagesc(log_fil_fourier);
colorbar;
%% reconstruct
filtered = real(ifft2(ifftshift(filtered_fourier)));
imagesc(filtered);


%% reconstruct with padding
padding = size(orig)./2;
padded_image = padarray(orig, padding);
padded_fourier = fftshift(fft2(padded_image));
log_fourier = log(abs(padded_fourier)+1);
% imagesc(log_fourier);
% colorbar;
filtered_fourier = myNotchFilter(padded_fourier, 277, 266);
log_fil_fourier = log(abs(filtered_fourier)+1);
% imagesc(log_fil_fourier);
% colorbar;
filtered = real(ifft2(ifftshift(filtered_fourier)));
% crop
filtered = filtered(padding(1):end-padding(1), padding(2):end-padding(2)); 
imagesc(filtered);
%% plot images
subplot(1,2,1), imagesc(orig);
daspect([1 1 1]);
title('Original');
subplot(1,2,2), imagesc(filtered);
daspect([1 1 1]);
title('Filtered');
%% plot fourier
subplot(1,2,1), imagesc(log_fourier);
daspect([1 1 1]);
title('Original');
subplot(1,2,2), imagesc(log_fil_fourier);
daspect([1 1 1]);
title('Filtered');
% colorbar;