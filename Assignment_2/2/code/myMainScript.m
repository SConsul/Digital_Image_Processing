%% MyMainScript

tic;
%% Processing image 1
%images = {'barbara.mat','grassNoisy.mat','honeyCombReal_Noisy.mat'};
storedStructure = load('../data/barbara.mat');
input = storedStructure.imageOrig;
[height,width] = size(input);
noise = randn(size(input));
input_noise = input + 0.05*max(max(input))*noise;
output = myBilateralFiltering(input_noise,5,1.5,10.8);
RMSD = sqrt(1/(width*height)*sum(sum((output-input).^2)));
%Display mask used
hsize = 5;
[row_coord,column_coord] = meshgrid(-hsize:hsize,-hsize:hsize);
gaussian_space = exp(-(row_coord.^2 + column_coord.^2)/(2*(1.5).^2));
figure(1)
imshow(mat2gray(gaussian_space)),colorbar;
title('Gaussian space mask used');

%Display images
 numberColours = 200;
  colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
  colormap(colorScale);
  daspect([1,1,1]);
  axis tight;
  figure(2);
  subplot(1,3,1);
  imshow(mat2gray(input)),colorbar;
  title('Input image 1');
  subplot(1,3,2);
  imshow(mat2gray(input_noise)),colorbar;
  title('Input image 1 (corrupted)'); 
  subplot(1,3,3);
  imshow(mat2gray(output)),colorbar;
  title('Output image 1 (Filtered)'); 
  disp(RMSD);
toc;
%%Processing image 2

