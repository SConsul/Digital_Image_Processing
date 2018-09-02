function output = myMeanShiftSegmentation(ip, h_i, h_s, iter)
    %Mean Shift segmentation on downsampled image
        ip = imgaussfilt(double(ip),1.5);  % apply gaussian smoothening to the image to reduce noise
        ip = imresize(ip,0.5);           % downsampling image for faster computation
        [row, col] = size(ip(:,:,1));
        indexX = repmat((1:1:row)' ,1,col);
        indexY = repmat(1:1:col ,row, 1);
        space = cat(3, ip, indexX,indexY); %RGBXY space RxCx5

        for i = 1:iter
%             converting to list for finding k nearest neighbours
            list = reshape(space,row*col,5); %Nx5
           
%             randomly generating k
            rng(i)
            k = (randi([300,350],1));  
%             indices of k-nn for each pixel
            [I,~] = knnsearch(list,list,'k',k);
            
%             calculating difference between pixel value and its neighbours
            diff_nn = permute(reshape(list(I',:), k,row*col,5),[1,3,2]);%kx5xN
            diff_nn = diff_nn - repmat(diff_nn(1,:,:),k,1); % diff_nn = x-x_i
            
%             square of difference
            dist_nn = diff_nn.*diff_nn;
            
%             calculating gaussian kernel at each pixel for intensity and
%             space
            exp_nn_i = exp(-sum(dist_nn(:,1:3,:),2)/ h_i^2); %kx1xN
            exp_nn_s = exp(-sum(dist_nn(:,4:5,:),2)/ h_s^2); %kx1xN
            
%             calculating denominator
            den = repmat(exp_nn_i.*exp_nn_s,1,5,1); %kx5xN
%             calculating numerator
            grad = diff_nn.*den; %kx5xN
            
            den(1,:,:) = 0;
            den = sum(den,1); %1x5xN
%             calculating final normalised gradient
            grad = sum(grad,1)./ den; %1x5xN
            grad = permute(grad, [3,2,1]); %Nx5
            grad = reshape(grad, row, col, 5); %RxCx5
%             updating the pixel values
            space = space + grad;

        end    
    output = double(space(:,:,1:3))/255;
end