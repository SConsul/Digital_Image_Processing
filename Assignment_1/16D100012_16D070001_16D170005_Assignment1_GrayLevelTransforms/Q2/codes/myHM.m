function [op_intermediate,output] = myHM(input,input_mask,ref,ref_mask)
%Histogram Matching
    
%op_intermediate is the histogram equalised input
    op_intermediate = myHE(input,'ind',input_mask)/255;
    output =zeros(size(input));
    
    %CDF of reference is calculated independently for each channel
    ref_r = ref(:,:,1);
    ref_g = ref(:,:,2);
    ref_b = ref(:,:,3);
    
    %Mask reference image to ensure black boundary does not distort the CDF
    cdf_r = CDF_gen(ref_r(ref_mask));
    cdf_g = CDF_gen(ref_g(ref_mask));
    cdf_b = CDF_gen(ref_b(ref_mask));
   
    %Apply the inverse of reference CDF on each HE'd pixel
    r_hm = cell2mat(arrayfun(@(z)CDF_inv(cdf_r,z),op_intermediate(:,:,1),'UniformOutput',false));
    g_hm = cell2mat(arrayfun(@(z)CDF_inv(cdf_g,z),op_intermediate(:,:,2),'UniformOutput',false));
    b_hm = cell2mat(arrayfun(@(z)CDF_inv(cdf_b,z),op_intermediate(:,:,3),'UniformOutput',false));
    
    % Ensure that masked portion stays black
    output(:,:,1) = r_hm.*ref_mask;
    output(:,:,2) = g_hm.*ref_mask;
    output(:,:,3) = b_hm.*ref_mask;
    output = output/255;
end

function cdf = CDF_gen(ip)
    %Find the CDF of input image/array
    hist= imhist(ip);
    %Adding ones to histogram ensure invertibility of CDF
    hist = hist + ones(size(hist));
    %Obtain normalised CDF
    cdf = double(cumsum(hist))/double(sum(hist));
end

function op_value = CDF_inv(cdf,ip)
    %find closest value of ref_CDF to input intensity
    [c, index_1] = min(abs(cdf-ip));
    %using linear interpolation to get the inverse mapping
    index_2 = index_1 + sign(ip-cdf(index_1));
    if(index_2 < 1)
        index_2 = 1;
    elseif(index_2 > 256)
        index_2 = 256;
    end
    y2 = cdf(index_2);
    y1 = cdf(index_1);
    if(index_2~=index_1)
        op_value = double(index_2 - index_1)/(y2 - y1)*(ip - y1) + index_1 ;
    else
        op_value = y1;
    end
  
end