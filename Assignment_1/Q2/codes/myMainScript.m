%% MyMainScript

tic;
%% Your code here

%Q2(a) Image Enhancement by Linear Contrasting
church = imread('../data/church.png');
% church_linstretch = myLinearContrastStretching(church);
% figure(1);
% my_imshow(church_linstretch);

%Q2(b) Image Enhancement using Independent channel Histogram Equalisation
HM = imread('../data/HMInputImage.png');
[HM_he,HM_avg] = myHE(HM);
% figure(2);
% subplot(3,1,1),
my_imshow(HM, 'HM');
% subplot(3,1,2),
my_imshow(HM_he, 'independent channel HM');
% subplot(3,1,3),
my_imshow(HM_avg, 'avg HM' );
toc;
