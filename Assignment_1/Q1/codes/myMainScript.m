%% MyMainScript

tic;
%% Your code here
% reading input images
barbara = imread('../data/barbaraSmall.png');
concentricC_in=imread('../data/circles_concentric.png');

%Q1(a) Image Shrinking
shrunk2_cc = myShrinkImageByFactorD(concentricC_in,2);
shrunk3_cc = myShrinkImageByFactorD(concentricC_in,3);
my_imshow(concentricC_in, 'Original Concentric Circles');
my_imshow(shrunk2_cc, 'Concentric Circles shrunk by a factor of 2');
my_imshow(shrunk3_cc, 'Concentric Circles shrunk by a factor of 3');

%Q1(b) Image Enlargement using Bilinear Interpolation
my_imshow(barbara, 'Original Barbara');
op = myBilinearInterpolation(barbara);
my_imshow(op, 'Bilinearly Interpolated Barbara')

%Q1(c) Image Enlargement using Nearest Neighbor Interpolation
my_imshow(barbara, 'Original Barbara');
op = myNearestNeighborInterpolation(barbara);
my_imshow(op, 'Nearest Neighbour-Interpolated Barbara')
toc;
