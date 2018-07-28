%% MyMainScript

tic;
%% Your code here
%Q1(a) Image Shrinking
concentricC_in=imread('../data/circles_concentric.png');
shrunk2_cc = myShrinkImageByFactorD(concentricC_in,2);
shrunk3_cc = myShrinkImageByFactorD(concentricC_in,3);
% subplot(1,3,1),imshow(concentricC_in);
% subplot(1,3,2),imshow(shrunk2_cc);
% subplot(1,3,3),imshow(shrunk3_cc);
% size(concentricC_in)
% size(shrunk2_cc)
% size(shrunk3_cc)

%Q1(b) Image Enlargement using Bilinear Interpolation
barbara_in = imread('../data/barbaraSmall.png');
% imshow(barbara_in);
op = myBilinearInterpolation(barbara_in);
imshow(mat2gray(op))

%Q1(c) Image Enlargement using Nearest Neighbor Interpolation
barbara_in = imread('../data/barbaraSmall.png');
% imshow(barbara_in);
op = myNearestNeighborInterpolation(barbara_in);
imshow(mat2gray(op))
toc;
