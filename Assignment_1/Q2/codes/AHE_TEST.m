% % Adaptive Histogram Equalisation`
tic;
my_imshow(canyon, "Original canyon");

he_canyon = myHE(canyon,'ind');
my_imshow(he_canyon, 'HE Canyon')
% canyon_ahe_3 = myAHE(canyon,3);
% my_imshow(canyon_ahe_3/255, 'Adaptive Histogram Equalised canyon - window size = 3');
% 
% canyon_ahe_23 = myAHE(canyon,23);
% my_imshow(canyon_ahe_23/255, 'Adaptive Histogram Equalised canyon - window size = 23');
% 
% canyon_ahe_51 = myAHE(canyon,51);
% my_imshow(canyon_ahe_51/255, 'Adaptive Histogram Equalised canyon - window size = 51');
% 
% canyon_ahe_81 = myAHE(canyon,81);
% my_imshow(canyon_ahe_81/255, 'Adaptive Histogram Equalised canyon - window size = 81');
% 
% canyon_ahe_121 = myAHE(canyon,121);
% my_imshow(canyon_ahe_121/255, 'Adaptive Histogram Equalised canyon - window size = 121');
% 
% canyon_ahe_151 = myAHE(canyon,151);
% my_imshow(canyon_ahe_151/255, 'Adaptive Histogram Equalised canyon - window size = 151');
% 
% canyon_ahe_201 = myAHE(canyon,201);
% my_imshow(canyon_ahe_201/255, 'Adaptive Histogram Equalised canyon - window size = 201');
% 
% canyon_ahe_251 = myAHE(canyon,251);
% my_imshow(canyon_ahe_251/255, 'Adaptive Histogram Equalised canyon - window size = 251');
% 
% canyon_ahe_303 = myAHE(canyon,303);
% my_imshow(canyon_ahe_303/255, 'Adaptive Histogram Equalised canyon - window size = 303');
% 
% canyon_ahe_347 = myAHE(canyon,347);
% my_imshow(canyon_ahe_347/255, 'Adaptive Histogram Equalised canyon - window size = 347');

canyon_ahe_421 = myAHE(canyon,421);
my_imshow(canyon_ahe_421, 'Adaptive Histogram Equalised canyon - window size = 421');

canyon_ahe_461 = myAHE(canyon,461);
my_imshow(canyon_ahe_461, 'Adaptive Histogram Equalised canyon - window size = 461');

canyon_ahe_521 = myAHE(canyon,521);
my_imshow(canyon_ahe_521, 'Adaptive Histogram Equalised canyon - window size = 521');

canyon_ahe_543 = myAHE(canyon,543);
my_imshow(canyon_ahe_543, 'Adaptive Histogram Equalised canyon - window size = 543');

canyon_ahe_625 = myAHE(canyon,625);
my_imshow(canyon_ahe_625, 'Adaptive Histogram Equalised canyon - window size = 625');

% my_imshow(canyon, 'Original canyon');
% canyon_ahe_51 = myAHE(canyon,51);
% my_imshow(canyon_ahe_51, 'Adaptive Histogram Equalised canyon - window size = 51');
% canyon_ahe_3 = myAHE(canyon,3);
% my_imshow(canyon_ahe_3, 'Adaptive Histogram Equalised canyon - window size = 3');
% canyon_ahe_201 = myAHE(canyon,201);
% my_imshow(canyon_ahe_201, 'Adaptive Histogram Equalised canyon - window size = 201');
% 
%
% my_imshow(canyon, 'Original Canyon');
% canyon_ahe_51 = myAHE(canyon,51);
% my_imshow((canyon_ahe_51)/255, 'Independent channel Adaptive Histogram Equalised Canyon- window size = 51');
% canyon_ahe_3 = myAHE(canyon,3);
% my_imshow((canyon_ahe_3)/255, 'Independent channel Adaptive Histogram Equalised Canyon- window size = 3');
% canyon_ahe_201 = myAHE(canyon,201);
% my_imshow((canyon_ahe_201)/255, 'Independent channel Adaptive Histogram Equalised Canyon- window size = 201');
toc;