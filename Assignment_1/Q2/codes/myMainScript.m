%% MyMainScript

tic;
%% Your code here

% %Q2(a) Image Enhancement by Linear Contrasting
% church = imread('../data/church.png');
% % church_linstretch = myLinearContrastStretching(church);
% % figure(1);
% % my_imshow(church_linstretch);
% 
% %Q2(b) Image Enhancement using Independent channel Histogram Equalisation
% HM = imread('../data/HMInputImage.png');
% [HM_he,HM_avg] = myHE(HM);
% % figure(2);
% % subplot(3,1,1),
% my_imshow(HM, 'HM');
% % subplot(3,1,2),
% my_imshow(HM_he, 'independent channel HM');
% % subplot(3,1,3),
% my_imshow(HM_avg, 'avg HM' );
% toc;
% 
% % Q2(c) Histogram Matching
% HM_ref = imread('../data/HMRefImage.png');
% HM_op = myHM(HM, HM_ref);
% my_imshow(HM_op, 'Histogram matched');

% Q2(d) Adaptive Histogram Equalisation`
TEM = imread('../data/TEM.png');
my_imshow(TEM, 'AHE_in');
TEM_op = myAHE2(TEM, 50);
my_imshow(TEM, 'AHE_g');
my_imshow(TEM_op, 'AHE');

% Q2(e) Contrast-limited Adaptive Histogram Equalisation`
% TEM = imread('../data/TEM.png');
my_imshow(TEM, 'CLAHE_in');
TEM_clahe = myCLAHE(TEM, 50, 100);
my_imshow(TEM_clahe, 'CLAHE');