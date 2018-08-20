%% MyMainScript

tic;
%% Processing first image
%reading input image1
  storedStructure = load('../data/lionCrop.mat');
  input = storedStructure.imageOrig;
  input = (input-min(input(:)))/(max(input(:))-min(input(:)));
% Sharpening Image
% Optimal parameters: sigma = 1.5, hsize=5, scale=2
  output = myUnsharpMasking(input,1.5,5,2);
  
  output = (output-min(output(:)))/(max(output(:))-min(output(:)));
  my_imshow(input,'Input Image',output,'Sharpened Image');
  save
    
toc;

%% Processing second image

%reading input image1
  storedStructure = load('../data/superMoonCrop.mat');
  input = storedStructure.imageOrig;
    input = (input-min(input(:)))/(max(input(:))-min(input(:)));
%Sharpening image
% Optimal parameters: sigma = 1, hsize=7, scale=2
  output = myUnsharpMasking(input,1,7,2);
    output = (output-min(output(:)))/(max(output(:))-min(output(:)));
  my_imshow(input,'Input Image',output,'Sharpened Image');
% toc;

