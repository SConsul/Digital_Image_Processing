%% MyMainScript
% By 
% 
% Sarthak Consul (16D100012), 
% 
% Parthasarathi Khirwadkar (16D070001), 
% 
% Bhishma Dedhia(16D170005)
%% Your code here
%%
%reading in images
barbara = imread('../data/barbara.png');
TEM = imread('../data/TEM.png');
canyon = imread('../data/canyon.png');
retina = imread('../data/retina.png');
church = imread('../data/church.png');
%% 
% *Q2(a)* Image Enhancement by Linear Contrast Stretching
% 
% $$<math xmlns="http://www.w3.org/1998/Math/MathML" display="block"><mrow><msub><mrow><mi 
% mathvariant="italic">I</mi></mrow><mrow><mi mathvariant="normal">new</mi></mrow></msub><mo>=</mo><mfrac><mrow><mn>255</mn></mrow><mrow><msub><mrow><mi 
% mathvariant="italic">I</mi></mrow><mrow><mi mathvariant="normal">max</mi></mrow></msub><mo>?</mo><msub><mrow><mi 
% mathvariant="italic">I</mi></mrow><mrow><mi mathvariant="normal">min</mi></mrow></msub></mrow></mfrac><mo>×</mo><mrow><mo>(</mo><mrow><mi 
% mathvariant="italic">I</mi><mo>?</mo><msub><mrow><mi mathvariant="italic">I</mi></mrow><mrow><mi 
% mathvariant="normal">min</mi></mrow></msub></mrow><mo>)</mo></mrow></mrow></math>$$
% 
% where $<math xmlns="http://www.w3.org/1998/Math/MathML" display="inline"><mrow><msub><mrow><mi 
% mathvariant="italic">I</mi></mrow><mrow><mi mathvariant="normal">new</mi></mrow></msub><mtext>?
% </mtext></mrow></math>$is the pixel intensity after linear contrast stretching, 
% $<math xmlns="http://www.w3.org/1998/Math/MathML" display="inline"><mrow><msub><mrow><mi 
% mathvariant="italic">I</mi></mrow><mrow><mi mathvariant="normal">min</mi></mrow></msub></mrow></math>$ 
% and $<math xmlns="http://www.w3.org/1998/Math/MathML" display="inline"><mrow><msub><mrow><mi 
% mathvariant="italic">I</mi></mrow><mrow><mi mathvariant="normal">max</mi></mrow></msub></mrow></math>$ 
% are the minimum and maximum values of pixel intensity in the input image. For 
% coloured images, this is applied to each channel independently
%%
%Pseudo code:
%   a = input.min() //minimum pixel intensity of the input image
%   b=input.max()   //maximum pixel intensity of the input image
%   T = Linear mapping from [a,b] to [0,255]
%   (Hence T is a straight line from (a,0) to (b,255))
%
%   for pixel in input:
%       Output_intensity = T(pixel(intensity))
%   end for;
%% 
% `

%basic linear contrast stretching
tic;

tic;
barbara_linstretch = myLinearContrastStretching(barbara,'g');
my_imshow(barbara, 'Original Barbara');
my_imshow(barbara_linstretch, 'Linear Contrast Stretched Barbara');
toc;

tic;
TEM_linstretch = myLinearContrastStretching(TEM,'g');
my_imshow(TEM, 'Original TEM');
my_imshow(TEM_linstretch, 'Linear Contrast Stretched TEM');
toc;

tic;
canyon_linstretch = myLinearContrastStretching(canyon,'rgb');
my_imshow(canyon, 'Original Canyon');
my_imshow(canyon_linstretch, 'Linear Contrast Stretched Canyon');
toc;

tic;
church_linstretch = myLinearContrastStretching(church,'rgb');
my_imshow(church, 'Original Church');
my_imshow(church_linstretch, 'Linear Contrast Stretched Church');
toc;

toc;
%% 
% Linear contrast stretching is ineffective in improving contrast in the 
% church.png image. Linear contrast stretching aims to stretch the range of the 
% image to span the entire possible range i.e 0-255. However, the input image 
% contains pixel intensities of both 0 and 255 (or 1 in case of double) in all 
% 3 channels. Thus the transormation is an identity transform, with the output 
% identical to the input image.
% 
% *Q2(b)* Image Enhancement using Independent channel Histogram Equalisation
%%
%Histogram Equalisation
tic;

tic;
barbara_he = myHE(barbara,'g');
my_imshow(barbara, "Original Barbara");
my_imshow(barbara_he, 'Histogram Equalised Barbara');
toc;

tic;
TEM_he = myHE(TEM,'g');
my_imshow(TEM, 'Original TEM');
my_imshow(TEM_he, 'Histogram Equalised TEM');
toc;

%%
tic;
canyon_ind_he = myHE(canyon,'ind');
canyon_avg_he = myHE(canyon,'avg');
my_imshow(canyon, 'Original Canyon');
my_imshow(canyon_ind_he/255, 'Independent channel Histogram Equalised Canyon');
my_imshow(canyon_avg_he/255, 'Average Channel Histogram Equalised Canyon');
toc;
%%

tic;
church_ind_he = myHE(church,'ind');
chruch_avg_he = myHE(church,'avg');
my_imshow(church, 'Original Church');
my_imshow(church_ind_he/255, 'Independent channel Histogram Equalised Church');
my_imshow(chruch_avg_he/255, 'Average Channel Histogram Equalised Church');
toc;

tic;
my_imshow(retina, 'Original Retina');
retina_mask = imread('../data/retinaMask.png');
retina_ind_he = myHE(retina,'ind',retina_mask);
my_imshow(retina_ind_he/255, 'Independent channel Histogram Equalised Retina');
retina_avg_he = myHE(retina,'avg',retina_mask);
my_imshow(retina_avg_he/255, 'Averaged Channel Histogram Equalised Retina');
toc;

toc;
%% 
% Applying Historgram equaisation independently for each channel results 
% in a significant change in colour (as made abundantly clear for the retina image). 
% 
% A variation of the independent channel histogram equalisation is the average 
% channel histogram equalisation, where the average transform across channels 
% is applied to all channels. While the colour scheme is retained in this enhancement, 
% for certain applications (such as a pre-processing step before segmenting the 
% eye blood vessels), independent channel histogram equalisation maybe preferred.
% 
%  Comparing the performance of Histogram Equalisation and contrast stretching 
% for image(5), it is clear that historgram equalisation is much better in improving 
% contrast than linear contrast stretching. Linear contrast stretching's effects 
% is greatly diminished if the range of pixel values is large, regardless of the 
% number of such locations of extremely small or latge values. Histogram equalisation, 
% on the other hand, has sufficient non-linearity to not be weakened by such factors.
% 
% *Q2(c)* Histogram Matching
%%
% Histogram Matching
tic;
 retina_mask = imread('../data/retinaMask.png');
 retina_ref = imread('../data/retinaRef.png');
 retina_ref_mask = imread('../data/retinaRefMask.png');
 
 my_imshow(retina, 'Original Retina');
 my_imshow(retina_ref, 'Reference Retina');
[HM_int,HM_op] = myHM(retina,retina_mask, retina_ref,retina_ref_mask);
 my_imshow(HM_int, 'Histogram Equalised Retina');
my_imshow(HM_op, 'Histogram Matched Retina');
 toc;
%% 
% Simply applying histogram equalisation on mulit-channeled images (like 
% RGB images), changes the colouring of the image (eg the retina is white not 
% orange). This is an issue If we desired to only improve contrast, while maintaining 
% the colouring, Histogram equilisation on the other hand is able to ensure the 
% output image has better contrast without disturbing the colouring.
% 
% Masking is critical to ensure the best enhancement, else the black background 
% would result in a spike in the histogram and distort the transformation.
% 
% *Q2(d)* Adaptive Histogram Equalisation`
%%
% % Adaptive Histogram Equalisation`
tic;
%%
my_imshow(barbara, "Original Barbara");
tic;
barbara_ahe_151 = myAHE(barbara,151);
my_imshow(barbara_ahe_151, 'Adaptive Histogram Equalised Barbara - window size = 151');
toc;

tic;
barbara_ahe_3 = myAHE(barbara,3);
my_imshow(barbara_ahe_3, 'Adaptive Histogram Equalised Barbara - window size = 3');
toc;

tic;
barbara_ahe_501 = myAHE(barbara,501);
my_imshow(barbara_ahe_501, 'Adaptive Histogram Equalised Barbara - window size = 501');
toc;

my_imshow(TEM, 'Original TEM');
tic;
TEM_ahe_231 = myAHE(TEM,231);
my_imshow(TEM_ahe_231, 'Adaptive Histogram Equalised TEM - window size = 231');
toc;

tic;
TEM_ahe_3 = myAHE(TEM,3);
my_imshow(TEM_ahe_3, 'Adaptive Histogram Equalised TEM - window size = 3');
toc;

tic;
TEM_ahe_543 = myAHE(TEM,543);
my_imshow(TEM_ahe_543, 'Adaptive Histogram Equalised TEM - window size = 543');
toc;

% canyon_avg_ahe = myAHE(canyon,'avg');
my_imshow(canyon, 'Original Canyon');
tic;
canyon_ahe_421 = myAHE(canyon,421);
my_imshow((canyon_ahe_421)/255, 'Independent channel Adaptive Histogram Equalised Canyon- window size = 421');
toc;

tic;
canyon_ahe_23 = myAHE(canyon,23);
my_imshow((canyon_ahe_23)/255, 'Independent channel Adaptive Histogram Equalised Canyon- window size = 23');
toc;

tic;
canyon_ahe_721 = myAHE(canyon,721);
my_imshow((canyon_ahe_721)/255, 'Independent channel Adaptive Histogram Equalised Canyon- window size = 721');
toc;

toc;
%% 
% The optimum window size for best contrast is dependent on the image. Clearly, 
% the small window size amplifies noise a lot. In its extreme, the output resembles 
% noise (eg. Applying AHE with window size=3 for canyon). For coloured images, 
% smaller window sizes also distorts the colour scheme.
% 
%  On the flip side if the window size is too large, the transformation is 
% simlar to that of vanilla Histogram Equalisation and contrast improvement is 
% lower. This is explained by the fact that to improve contrast, local pixel intensity 
% is of importanct, if the window is too large, the histogram obtained is less 
% sensitive to the pixel intensties in the immediate neighbourhood of the pixel.
% 
% 
% 
% *Q2(e)* Contrast-limited Adaptive Histogram Equalisation`
%%
% Contrast-limited Adaptive Histogram Equalisation`
tic;
%%
my_imshow(barbara, "Original Barbara");
barbara_thresh = 0.01;
tic;
barbara_clahe_full = myCLAHE(barbara,151,barbara_thresh);
my_imshow(barbara_clahe_full, cat(2,'CL-Adaptive Histogram Equalised Barbara, h=',num2str(barbara_thresh)));
toc;

tic;
barbara_clahe_half = myCLAHE(barbara,151,barbara_thresh/2);
my_imshow(barbara_clahe_half, cat(2,'CL-Adaptive Histogram Equalised Barbara, h=',num2str(barbara_thresh/2)));
toc;
%%

my_imshow(TEM, 'Original TEM');
TEM_thresh = 0.008;
tic;
TEM_clahe_full = myCLAHE(TEM,51,TEM_thresh);
my_imshow(TEM_clahe_full, cat(2,'CL-Adaptive Histogram Equalised TEM, h=',num2str(TEM_thresh)));
toc;

tic;
TEM_clahe_half = myCLAHE(TEM,51,TEM_thresh/2);
my_imshow(TEM_clahe_half, cat(2,'CL-Adaptive Histogram Equalised TEM, h=',num2str(TEM_thresh/2)));
toc;
%%

my_imshow(canyon, 'Original Canyon');
canyon_thresh = 0.01;
tic;
canyon_clahe_full = myCLAHE(canyon,301,canyon_thresh);
my_imshow((canyon_clahe_full)/255, cat(2,'Independent channel CL-Adaptive Histogram Equalised TEM, h=',num2str(canyon_thresh)));
toc;

tic;
canyon_clahe_half = myCLAHE(canyon,301,canyon_thresh/2);
my_imshow((canyon_clahe_half)/255, cat(2,'Independent channel CL-Adaptive Histogram Equalised TEM, h=',num2str(canyon_thresh/2)));
toc;
%%

toc;
%% 
% The histogram-threshold parameter governs the behavior of the CLAHE transform. 
% If h is very small, the output would be very similar to the input while if h 
% is large, the output would match that of AHE, for the same window size.
% 
% 
% 
% For better contrast, we desire to use smaller window sizes for AHE, however 
% this also applifies noise. CLAHE enables us to use smaller windows, with lesser 
% noise in the output. 
% 
% This is best highlighted by the fact that for TEM, we had to resort to 
% using a larger window size of 231 for AHE, but CLAHE can give similar enhancement 
% with a window size of just 51.