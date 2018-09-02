%% MyMainScript for Mean Shift Segmentation
% By Sarthak Consul (16D100012)
%
% -- Parthsarathi Khirwadkar (16D070001)
%
% -- Bhishma Dedhia (16D170005)
%% Optimum Parameters:
%   Intensity bandwidth = 60
%   Spatial bandwidth = 5
%   Iterations = 20
%   K in K-NN = 300 to 350
input = imread('../data/baboonColor.png');
H_i = 60;
H_s = 5;

output = myMeanShiftSegmentation(input,H_i(i),H_s(j),20); 
 %% Results
% figure(1)
% title('Input Image')
input = imresize(input,0.5);
my_imshow(input,'Input Image');

% figure(2)
my_imshow(output,'Output Image');
imshow(output);
%%  Plotting scatter plot
% figure(3)
title('Scatter plot of input image')
[row_ip, col_ip] = size(input(:,:,1));
li = double(reshape(input,row_ip*col_ip,3))/255;
scatter3(li(:,1), li(:,2), li(:,3),ones(row_ip*col_ip,1), li);

% figure(4)
title('Scatter plot of output image')
[row_op, col_op] = size(output(:,:,1));
lo = double(reshape(output,row_op*col_op,3))/255;
scatter3(lo(:,1), lo(:,2), lo(:,3),ones(row_op*col_op,1), lo);

%% Notes on Implementation
% Following the seminal paper of Mean Shift Segmentation, we realised that
% the update rule is not strictly Newton-Raphson. 
% We highly vectorised the code and avoided loops as far as possible


