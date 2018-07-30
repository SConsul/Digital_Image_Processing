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
[HM_he,HM_avg,HM_w] = myHE(HM);
figure(2);
subplot(3,1,1),imshow(HM);
% subplot(4,1,2),imshow(HM_he);
subplot(3,1,2),imshow(HM_avg);
subplot(3,1,3),imshow(HM_w);
toc;
