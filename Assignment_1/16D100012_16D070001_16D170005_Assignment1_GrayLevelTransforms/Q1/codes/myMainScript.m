%% MyMainScript
%Members: 
    %Bhishma Dedhia (16D170005)
    %Sarthak Consul(16D100012)
    %Parthasarathi Khirwadkar(16D070001)

tic;

% reading input images
barbara = imread('../data/barbaraSmall.png');
concentricC_in=imread('../data/circles_concentric.png');
toc;
%% Q1(a) Image Shrinking
tic;
shrunk2_cc = myShrinkImageByFactorD(concentricC_in,2);
shrunk3_cc = myShrinkImageByFactorD(concentricC_in,3);
my_imshow(concentricC_in, 'Original Concentric Circles');
my_imshow(shrunk2_cc, 'Concentric Circles shrunk by a factor of 2');
my_imshow(shrunk3_cc, 'Concentric Circles shrunk by a factor of 3');
toc;
%% Q1(b) Image Enlargement using Bilinear Interpolation
tic;
my_imshow(barbara, 'Original Barbara');
op = myBilinearInterpolation(barbara);
my_imshow(op, 'Bilinearly Interpolated Barbara')
toc;

%% Q1(c) Image Enlargement using Nearest Neighbor Interpolation
tic;
my_imshow(barbara, 'Original Barbara');
op1 = myNearestNeighborInterpolation(barbara);
my_imshow(op1, 'Nearest Neighbour-Interpolated Barbara')
toc;
