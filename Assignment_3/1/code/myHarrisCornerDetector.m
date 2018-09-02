function output = myHarrisCornerDetector(input, k, patch_size,sigma_pre)
% Input arguements
% input (of range 0-1)
% k (should be between 0 and 0.25) - Tunable
% patch_size = size of patch about which structure tensor is computed
% sigma_pre = std. deviation of Gaussian Filter applied before computing gradients 
    [row, col] = size(input(:,:,1));
    %Same padding to ensure gradients at edge of image don't blow up and
    %rescale the colourbars
    input =  padarray(input, [patch_size,patch_size],'replicate', 'both');
    %smoothen image with gaussian to reduce noise before computing
    %gradients
    sm_input = imgaussfilt(input,sigma_pre);
    
    %Finding Ix
    filtx1 = [1;2;1];
    filtx2 = [-1 0 1];
    Ix = imfilter(sm_input,filtx2,'conv');
    Ix = imfilter(Ix,filtx1,'conv');

    %Finding Iy
    filty1 = [1;0;-1];
    filty2 = [1 2 1];
    Iy = imfilter(sm_input,filty2,'conv');
    Iy = imfilter(Iy,filty1,'conv');
    
    % Convolve about isometric patch to get structure tensor elements
    iso_G = fspecial('gaussian',patch_size, patch_size/6); 
    Ix2 = imfilter(Ix.*Ix,iso_G,'conv');
    Iy2 = imfilter(Iy.*Iy,iso_G,'conv');
    Ixy = imfilter(Ix.*Iy,iso_G,'conv');
    st = patch_size+1;
    en = size(sm_input,1)-patch_size;
    
    input = input(st:en,st:en);
    
    a = cat(3, Ix2(st:en,st:en), Ixy(st:en,st:en), Iy2(st:en,st:en) );
    % detA = a1.a3-a2^2, trace(A) = a1+a3
    P = a(:,:,1).*a(:,:,3) - a(:,:,2).*a(:,:,2); %detA is product of eigvals
    S = a(:,:,1) + a(:,:,3); %trace(A) is sum of eigvals

    eigval = zeros(row,col,2);
    eigval(:,:,1) = (S + sqrt(S.*S - 4*P) )/2;
    eigval(:,:,2) = (S - sqrt(S.*S - 4*P) )/2;
    my_imshow(eigval(:,:,1),{'Eigen Value-1',strcat('k= ',num2str(k),' patch\_size=', num2str(patch_size),' sigma\_pre=', num2str(sigma_pre))}); 
    my_imshow(eigval(:,:,2),{'Eigen Value-2',strcat('k= ',num2str(k),' patch\_size=', num2str(patch_size),' sigma\_pre=', num2str(sigma_pre))}); 

   cornerness = P - k*S.*S;
   corners = cornerness == ordfilt2(cornerness,25,ones(5,5)) & cornerness > 1e-4; %small margin to ensure robustness
   outputR = 0.3*input;
   output = 0.3*input(:,:,[1,1]);
   outputR(corners) = 1;
   output = cat(3,outputR,output);
   my_imshow(cornerness,{'Cornerness',strcat('k= ',num2str(k),' patch\_size=', num2str(patch_size),' sigma\_pre=', num2str(sigma_pre))}); 
   
  end
