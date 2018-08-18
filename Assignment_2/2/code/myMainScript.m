%% MyMainScript

tic;
%% Processing image 1

storedStructure = load('../data/barbara.mat');
input = storedStructure.imageOrig;
[height,width] = size(input);

noise = randn(size(input));
input_noise = input + 0.05*(max(max(input)) - min(min(input)))*noise;
input_noise = input_noise/(max(max(input_noise)) - min(min(input_noise)));

output = myBilateralFiltering(input_noise,0.81,0.63);
output = output/(max(max(output)) - min(min(output)));
input = input/(max(max(input)) - min(min(input)));


RMSD = sqrt(sum(sum((output-input).^2))/(width*height));
%Display mask used
hsize = floor(4*0.81);
% [row_coord,column_coord] = meshgrid(-hsize:hsize,-hsize:hsize);
% gaussian_space = exp(-(row_coord.^2 + column_coord.^2)/(2*(1.5).^2));
gaussian_space = fspecial('gaussian',[2*hsize+1,2*hsize+1],0.81);
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

  
%Computing non optimal RMSD
sigma_space =  [0.9,1.1,1,1];
sigma_int = [1,1,0.9,1.1];
for i =1:4
     output = myBilateralFiltering(input_noise,0.81*sigma_space(i),0.63*sigma_int(i));
     output = output/(max(max(output)) - min(min(output)));
     RMSD = sqrt(1/(width*height)*sum(sum((output-input).^2))); 
     disp(RMSD);

end
toc;

tic;
%% Processing image 2
storedStructure = load('../data/honeyCombReal_Noisy.mat');
input = storedStructure.imgCorrupt;
[height,width] = size(input);

noise = randn(size(input));
input_noise = input + 0.05*(max(max(input)) - min(min(input)))*noise;
input_noise = input_noise/(max(max(input_noise)) - min(min(input_noise)));

output = myBilateralFiltering(input_noise,0.62,1.1);
output = output/(max(max(output)) - min(min(output)));
input = input/(max(max(input)) - min(min(input)));


RMSD = sqrt(sum(sum((output-input).^2))/(width*height));
%Display mask used
hsize = floor(4*0.62);
gaussian_space = fspecial('gaussian',[2*hsize+1,2*hsize+1],0.62);
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

  
%Computing non optimal RMSD
sigma_space =  [0.9,1.1,1,1];
sigma_int = [1,1,0.9,1.1];
for i =1:4
     output = myBilateralFiltering(input_noise,0.62*sigma_space(i),1.1*sigma_int(i));
     output = output/(max(max(output)) - min(min(output)));
     RMSD = sqrt(1/(width*height)*sum(sum((output-input).^2))); 
     disp(RMSD);

end
toc;

tic;
%% Processing image 3
storedStructure = load('../data/grassNoisy.mat');
input = storedStructure.imgCorrupt;
[height,width] = size(input);

noise = randn(size(input));
input_noise = input + 0.05*(max(max(input)) - min(min(input)))*noise;
input_noise = input_noise/(max(max(input_noise)) - min(min(input_noise)));

output = myBilateralFiltering(input_noise,0.79,0.9);
output = output/(max(max(output)) - min(min(output)));
input = input/(max(max(input)) - min(min(input)));


RMSD = sqrt(sum(sum((output-input).^2))/(width*height));
%Display mask used
hsize = floor(4*0.62);
gaussian_space = fspecial('gaussian',[2*hsize+1,2*hsize+1],0.62);
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

  
%Computing non optimal RMSD
sigma_space =  [0.9,1.1,1,1];
sigma_int = [1,1,0.9,1.1];
for i =1:4
     output = myBilateralFiltering(input_noise,0.9*sigma_space(i),0.79*sigma_int(i));
     output = output/(max(max(output)) - min(min(output)));
     RMSD = sqrt(1/(width*height)*sum(sum((output-input).^2))); 
     disp(RMSD);

end
toc;
