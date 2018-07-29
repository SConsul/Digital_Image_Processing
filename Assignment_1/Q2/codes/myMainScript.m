%% MyMainScript

tic;
%% Your code here

%Q2(a) Image Enhancement by Linear Contrasting
church = imread('../data/church.png');
church_linstretch = myLinearContrastStretching(church);
imshow(church_linstretch);

%Q2(b) Image Enhancement using Independent channel Histogram Equalisation
HM = imread('../data/HMInputImage.png');
HM_he = myHE(HM);
imshow(HM_he);
toc;
