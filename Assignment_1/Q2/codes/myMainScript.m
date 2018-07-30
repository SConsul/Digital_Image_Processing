%% MyMainScript

tic;
%% Your code here

%Q2(a) Image Enhancement by Linear Contrasting
church = imread('../data/church.png');
% church_linstretch = myLinearContrastStretching(church);
% figure(1);
% imshow(church_linstretch);

%Q2(b) Image Enhancement using Independent channel Histogram Equalisation
HM = imread('../data/HMInputImage.png');
HM_he = myHE(HM);
figure(2);
subplot(2,1,1),imshow(HM);
subplot(2,1,2),imshow(HM_he);
toc;
