%% MyMainScript
close all
clear all
clc

im = im2double(imread('../data/barbara256.png'))*255;

%%  adding gaussian noise
sigma = 20;
im1_gaussian = im+rand(size(im)).*sigma;

%% Part (A)
tic;
im2_a = myPCADenoising1(im1_gaussian,[7 7],sigma);
rmse = norm((im2_a-im),2)/norm(im,2);
figure;
imshow(im/255);
title('Original image', 'Fontsize', 12, 'Fontname', 'Cambria');

figure;
imshow(im1_gaussian/255);
title('Noisy image', 'Fontsize', 12, 'Fontname', 'Cambria');

figure;
imshow(im2_a/255);
title('Denoised Image (part a)', 'Fontsize', 12, 'Fontname', 'Cambria');

%% Part (B)

%% Part (C)

%% Part (D)

% Image Acquisition with a sufficient exposure time
im1_poisson = poissonrnd(im);
figure;
imshow(im1_poisson/255.0); colorbar;
title('Image with Poisson Noise', 'Fontsize', 12, 'Fontname', 'Cambria');
im2_poisson = myPCADenoising1(sqrt(im1_poisson), [7,7], [31 31], 0.25);
figure;
imshow(im2_poisson.*im2_poisson/255.0); colorbar;
title('Denoised Image with Poisson Noise', 'Fontsize', 12, 'Fontname', 'Cambria');

% Image Acquisition with a lower exposure time
im1_poisson_le = poissonrnd(im/20);
figure;
imshow(im1_poisson_le/255.0); colorbar;
title('Image with Poisson Noise, with low exposure', 'Fontsize', 12, 'Fontname', 'Cambria');
im2_poisson_le = myPCADenoising1(sqrt(im1_poisson_le), [7,7], [31 31], 0.25);
figure;
imshow(im2_poisson_le.*im2_poisson_le/255.0); colorbar;
title('Denoised Image with Poisson Noise', 'Fontsize', 12, 'Fontname', 'Cambria');

toc;
