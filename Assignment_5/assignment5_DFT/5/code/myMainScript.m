%% MyMainScript
im = im2double(imread('../data/barbara256.png'))*255;
figure;
imshow(im/255);
%%  adding gaussian noise
sigma = 20;
img_noisy = im+rand(size(im)).*sigma;
figure;
imshow(img_noisy/255);
%% Your code here
tic;
im2 = myPCADenoising2(img_noisy,[7 7],[31 31],sigma,200);
toc;
figure;
imshow(im2/255);
% rmse = norm((im2-im),2)/norm(im,2);
