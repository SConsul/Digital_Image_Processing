function denoised_img=myPCADenoising2(img_noisy,patch_size,n_size,sigma,k)
    %% looping over every patch
    denoised_img = zeros(size(img_noisy));
    for r = 1:size(img_noisy,1)-patch_size(1)+1
        for c = 1:size(img_noisy,2)-patch_size(2)+1
            q_ref = img_noisy(r:r+patch_size(1)-1,c:c+patch_size(2)-1);
            offset = floor(n_size/2);
            neighbourhood = img_noisy(max(r-offset(1),1):min(size(img_noisy,1),r+offset(1)), ...
                                      max(r-offset(2),1):min(size(img_noisy,2),r+offset(2)));
            neighbor_col = im2col(neighbourhood,patch_size,'sliding');
            [idx,~] = knnsearch(neighbor_col',q_ref(:)','K',min(k,size(neighbor_col,2)));
            P = neighbor_col(:,idx);
%             assert(sum(neighbor_col(:,1)-q_ref(:))==0);
            %% extracting eigenvectors of P*P'
            [V,~] = eig(P*P');
            eig_coeff = V'*P;

            %% estimating average eigen-coeff of original patch
            avg_sqr_coeff = max(0,mean(eig_coeff.*eig_coeff,2) - sigma^2);

            %% updating eigen coefficients
            denominator = 1 + ((sigma^2)./avg_sqr_coeff);
            eig_coeff_P = V'*q_ref(:);
            denoised_eig_coeff_P = eig_coeff_P./denominator;
            
            %% reconstructing the Patch
            denoised_P_col = V*denoised_eig_coeff_P;
            denoised_P = reshape(denoised_P_col,size(q_ref));
            denoised_img(r:r+patch_size(1)-1,c:c+patch_size(2)-1) = denoised_img(r:r+patch_size(1)-1,c:c+patch_size(2)-1) + denoised_P;
        end
    end    
    % calculating denominator for each pixel
    num_patches = size(img_noisy) - patch_size + 1;
    denom_row_temp = ones(1,num_patches(2).*patch_size(2));
    denom_col_temp = ones(num_patches(1).*patch_size(1),1);
    denom_row = zeros(1,size(img_noisy,2));
    denom_col = zeros(size(img_noisy,1),1);

    for i=1:num_patches(2)
        denom_row(1,i:i+patch_size(2)-1) = denom_row(1,i:i+patch_size(2)-1) + denom_row_temp(1,(i-1)*patch_size(2)+1:i*patch_size(2));
    end
    for i=1:num_patches(1)
        denom_col(i:i+patch_size(1)-1,1) = denom_col(i:i+patch_size(1)-1,1) + denom_col_temp((i-1)*patch_size(1)+1:i*patch_size(1),:);
    end

    denom = denom_col*denom_row;
    denoised_img = denoised_img./denom;
    
end