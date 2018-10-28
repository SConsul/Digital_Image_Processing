%% MyMainScript
close all
clear all
clc
tic;
%% 
I = zeros(300,300);
I(50:50+69, 50:50+49) = 255;
% Image J is a shifted version of I. Shift = (x_o, y_o)
J = zeros(300,300);
J( 120:120+69, 20:20+49)=255;

% Calculating the Fourier Transforms of the images O(NlogN)
FT_I = fftshift(fft2(I));
FT_J = fftshift(fft2(J));

% Calculating the Cross Power Spectrum O(N^2)
CP = (FT_I.*conj(FT_J))./(1e-5 + abs(FT_I).*abs(FT_J));
CP_FT_plot = log(1+abs(fftshift(fft2(CP))));

% Finding the IFT of the Cross Power Spectrum O(NlogN)
disp = ifft2(ifftshift(CP));

% Repeat with Noise added to images
noisy_I = I + 20*randn(300);

% Image J is a shifted version of I. Shift = (x_o, y_o)
noisy_J = J + 20*randn(300);

% Calculating the Fourier Transforms of the images O(NlogN)
FT_I_noisy = fftshift(fft2(noisy_I));
FT_J_noisy = fftshift(fft2(noisy_J));

% Calculating the Cross Power Spectrum O(N^2)
CP_noisy = (FT_I_noisy.*conj(FT_J_noisy))./(1e-5 + abs(FT_I_noisy).*abs(FT_J_noisy));
CP_noisy_FT_plot = log(1+abs(fftshift(fft2(CP_noisy))));

% Finding the IFT of the Cross Power Spectrum O(NlogN)
disp_noisy = ifft2(ifftshift(CP_noisy));

%Display results
figure;
imshowpair(I,J);
title('Images I and J', 'Fontsize', 12, 'Fontname', 'Cambria');
% figure;
% subplot(1,2,1), imshow(I);
% subplot(1,2,2), imshow(J);
figure;
imshowpair(noisy_I,noisy_J);
title('Noisy Images I and J', 'Fontsize', 12, 'Fontname', 'Cambria');
% figure;
% subplot(1,2,1), imshow(I);
% subplot(1,2,2), imshow(J);

figure;
imagesc(CP_FT_plot, [min(min(CP_FT_plot)), max(max(CP_FT_plot))]); colormap(jet); colorbar;
title('Log Fourier Transform of magnitude of Cross Power Spectrum', 'Fontsize', 12, 'Fontname', 'Cambria');
figure;
imagesc(CP_noisy_FT_plot, [min(min(CP_noisy_FT_plot)), max(max(CP_noisy_FT_plot))]); colormap(jet); colorbar;
title('Log Fourier Transform of magnitude of Noisy Cross Power Spectrum', 'Fontsize', 12, 'Fontname', 'Cambria');

figure;
imshow(disp,[min(min(disp)), max(max(disp))]); colormap(gray); colorbar;
title('Inverse Fourier Transform of Cross Power Spectrum', 'Fontsize', 12, 'Fontname', 'Cambria');
% As we have taken the conjugate of the original image, I in the numerator
% of CP, CP = exp{j2pi(ux_o + vy_o) and so the IFT of CP would be a delta centred at (-x_o, -y_o)
% disp is a black image with a solitary white point at [X Y] = [31 231].
% This corresponds to a shift of -31 in the x direction and -231==69 in the
% y direction. 
figure;
imshow(disp_noisy,[min(min(disp_noisy)), max(max(disp_noisy))]); colormap(gray); colorbar;
title('IFT of Noisy Cross Power Spectrum', 'Fontsize', 12, 'Fontname', 'Cambria');

%% Time Complexity Analysis
% Time Complexity using FFT-based image registration: O(NlogN + N^2) =
% O(N^2)
%
% Time Complexity using pixel wise comparison for image registration:
% O(N^4) (because every pixel of the first image has to be compared to every pixel of the second image) 
toc;