%% MyMainScript
close all
clear all
clc

im = double(imread('../data/barbara256-part.png'));

%%  adding gaussian noise
sigma = 20;
im1_gaussian = im+randn(size(im)).*sigma;

%% Part (A)
tic;
im2_a = myPCADenoising1(im1_gaussian,[7 7],sigma);
rmse = norm((im2_a-im),'fro')/norm(im,'fro');
disp('RMSE in Part A:');
disp(rmse);
figure;
imshow(im/255);
title('Original image', 'Fontsize', 12, 'Fontname', 'Cambria'); 
figure;
imshowpair(im1_gaussian/255, im2_a/255, 'montage');
title('Noisy image and Denoised Image using all patches', 'Fontsize', 12, 'Fontname', 'Cambria'); 

%% Part (B)
im2_b = myPCADenoising2(im1_gaussian,[7 7], [31,31], sigma, 200);
rmse = norm((im2_b-im),'fro')/norm(im,'fro');
disp('RMSE in Part B:');
disp(rmse);
figure;
imshowpair(im1_gaussian/255, im2_b/255, 'montage');
title('Noisy image and Denoised Image using 200 most similar patches', 'Fontsize', 12, 'Fontname', 'Cambria'); 

%% Part (C)
im2_c = myBilateralFiltering(im1_gaussian,5,sigma);
rmse = norm((im2_c-im),'fro')/norm(im,'fro');
disp('RMSE using Bilateral Filtering is:');
disp(rmse);
figure;
imshowpair(im1_gaussian/255, im2_c/255, 'montage');
title('Noisy image and Denoised Image (Part C)', 'Fontsize', 12, 'Fontname', 'Cambria'); 
%%

% As demonstrated above, Bilateral Filtering is not as effective in denoising
% the image compared to PCA. PCA is able to remove noise significantly,
% while bilateral filtering fails to restore the image without
% over-smoothening the image (by tuning the parameters). 
%
% Bilateral Filtering is not a denoising technique but an enhancement
% technique. 
%
%It is not as effective as PCA in denoising an image as:
%
% (i) bilateral Filtering does not take the noise statistics into account
%
% (2)bilateral filtering looks at pixel-level dissimilarity. PCA, however,
% finds similar patches and so is able to capture local texture
% infromation.
%% Part (D)

% Image Acquisition with a sufficient exposure time
im1_poisson = poissrnd(im);
im2_poisson = myPCADenoising2(sqrt(im1_poisson), [7,7], [31 31], 0.25, 200);
im2_poisson = im2_poisson.^2;
rmse = norm((im2_poisson-im1_poisson),'fro')/norm(im,'fro');
disp('RMSE for sufficient exposure time is:');
disp(rmse);
figure;
imshowpair(im1_poisson/255.0, im2_poisson/255.0, 'montage');
title('Noisy and Denoised Image with sufficient exposure time', 'Fontsize', 12, 'Fontname', 'Cambria');

% Image Acquisition with a lower exposure time
im1_poisson_le = poissrnd(im/20);
im2_poisson_le = myPCADenoising2(sqrt(im1_poisson_le), [7,7], [31 31], 0.25, 200);
im2_poisson_le = im2_poisson_le.^2;
rmse = norm((im2_poisson_le-im1_poisson),'fro')/norm(im,'fro');
disp('RMSE for low exposure time is:');
disp(rmse);
figure; 
imshowpair(im1_poisson_le/255.0, im2_poisson_le/255.0, 'montage');
title('Noisy and Denoised Image with low exposure', 'Fontsize', 12, 'Fontname', 'Cambria');

% In the low exposure image the Signal-to-Noise Ratio (mean of orignal image/standard deviation of noise) is 1/sqrt(20) of the
% previous image. 
%
% This makes denoising ineffective as the information of the original source image 
% is perturebed to such an extent that PCA is unable to distinguish between noise and
% true signal when extracting common features (eigen vectors of correlation matrix) in similar patches.
toc;
