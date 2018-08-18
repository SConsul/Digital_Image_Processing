%% MyMainScript

tic;
%% Processing first image
% %reading input image1
  storedStructure = load('../data/lionCrop.mat');
  input = storedStructure.imageOrig;
%Sharpening image
  output = myUnsharpMasking(input,1.1,7,1.5);
  input_ls = mat2gray(myLinearContrastStretching(input,'g'));
  output_ls = mat2gray(myLinearContrastStretching(output,'g'));
    
%Displaying Images
  numberColours = 200;
  colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
  colormap(colorScale);
  daspect([1,1,1]);
  axis tight;
  figure(1);
  subplot(1,2,1);
  imshow(mat2gray(input_ls)),colorbar;
  title('Input image 1');
  subplot(1,2,2);
  imshow(output_ls),colorbar;
  title('Output image 2 (Sharpened)');     
toc;
%%Processing second image
%reading input image1
  storedStructure = load('../data/superMoonCrop.mat');
  input = storedStructure.imageOrig;
%Sharpening image
  output = myUnsharpMasking(input,1,7,1.9);
  input_ls = mat2gray(myLinearContrastStretching(input,'g'));
  output_ls = mat2gray(myLinearContrastStretching(output,'g'));
    
%Displaying Images
  numberColours = 200;
  colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
  colormap(colorScale);
  daspect([1,1,1]);
  axis tight;
  figure(2);
  subplot(1,2,1);
  imshow(mat2gray(input_ls)),colorbar;
  title('Input image 2');
  subplot(1,2,2);
  imshow(output_ls),colorbar;
  title('Output image 2 (Sharpened)');  
toc;

