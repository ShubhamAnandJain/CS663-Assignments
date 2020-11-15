%% Q6


%% DFT Calculation Code
clear;
k1 = [0 1 0;1 -4 1;0 1 0];
k2 = [-1 -1 -1;-1 8 -1;-1 -1 -1];
k1_fourier = fftshift(fft(fft(k1,201).',201).');
k2_fourier = fftshift(fft(fft(k2,201).',201).');
log_fourier_k1 = log(abs(k1_fourier)+1);
log_fourier_k2 = log(abs(k2_fourier)+1);

%% Filter 1 plot
Z1 = log_fourier_k1;
[X,Y] = meshgrid(-100:100);
s1 = surf(X,Y,Z1);
s1.EdgeColor = 'none';
colorbar
%% Filter 2 plot
Z2 = log_fourier_k2;
s2 = surf(X,Y,Z2);
s2.EdgeColor = 'none';
colorbar
%% Comparison between plots
% Both of these filters are negative discrete approximations of the Laplacian Filter
% used often as unsharp masks. 


