function denoised_img=myPCADenoising1(img_noisy,patch_size,sigma)
    %% converting patches into column vectors to get the matrix P
    P = im2col(img_noisy,patch_size,'sliding');

    %% extracting eigenvectors of P*P'
    [V,~] = eig(P*P');
    eig_coeff = V'*P;

    %% estimating average eigen-coeff of original patch
    avg_sqr_coeff = max(0,mean(eig_coeff.*eig_coeff,2) - sigma^2);

    %% updating eigen coefficients
    denominator = 1 + ((sigma^2)./avg_sqr_coeff);
    denoised_eig_coeff = eig_coeff./denominator;

    %% reconstructing the image
    denoised_P = V*denoised_eig_coeff;
    s = size(img_noisy) - patch_size +1;
    denoised_img_distinct = col2im(denoised_P,patch_size,s.*patch_size,'distinct');
    denoised_img_temp = zeros([size(denoised_img_distinct,1),size(img_noisy,2)]);
    denoised_img = zeros(size(img_noisy));
    
    % calculating denominator for each pixel
    denom_row_temp = ones(1,size(denoised_img_distinct,2));
    denom_col_temp = ones(size(denoised_img_distinct,1),1);
    denom_row = zeros(1,size(img_noisy,2));
    denom_col = zeros(size(img_noisy,1),1);
    
    for i=1:s(2)
        denoised_img_temp(:,i:i+patch_size(2)-1) = denoised_img_temp(:,i:i+patch_size(2)-1) + denoised_img_distinct(:,(i-1)*patch_size(2)+1:i*patch_size(2));
        denom_row(1,i:i+patch_size(2)-1) = denom_row(1,i:i+patch_size(2)-1) + denom_row_temp(1,(i-1)*patch_size(2)+1:i*patch_size(2));
    end
    for i=1:s(1)
        denoised_img(i:i+patch_size(1)-1,:) = denoised_img(i:i+patch_size(1)-1,:) + denoised_img_temp((i-1)*patch_size(1)+1:i*patch_size(1),:);
        denom_col(i:i+patch_size(1)-1,1) = denom_col(i:i+patch_size(1)-1,1) + denom_col_temp((i-1)*patch_size(1)+1:i*patch_size(1),:);
    end
    
    denom = denom_col*denom_row;
    denoised_img = denoised_img./denom;

end