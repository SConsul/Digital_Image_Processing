clear all
clc

input = imread('../data/HMInputImage.png');
input_ref = imread('../data/HMRefImage.png');

op_intermediate = im2double(myHE(input));
figure(1);
subplot(2,1,1), imshow(input);
subplot(2,1,2),imshow(op_intermediate,[]);
%  r_he = op_intermediate(:,:,1);
%  g_he = op_intermediate(:,:,2);
%  b_he = op_intermediate(:,:,3);
  total = op_intermediate;

  cdf_r = CDF_gen(input_ref(:,:,1));
  cdf_g = CDF_gen(input_ref(:,:,2));
  cdf_b = CDF_gen(input_ref(:,:,3));  

  r_he = cell2mat(arrayfun(@(z)CDF_inv(cdf_r,z),op_intermediate(:,:,1),'UniformOutput',false));
  g_he = cell2mat(arrayfun(@(z)CDF_inv(cdf_g,z),op_intermediate(:,:,2),'UniformOutput',false));
  b_he = cell2mat(arrayfun(@(z)CDF_inv(cdf_b,z),op_intermediate(:,:,3),'UniformOutput',false));
  total(:,:,1) = r_he;
  total(:,:,2) = g_he;
  total(:,:,3) = b_he;
  output = total;
%   subplot(3,1,3),
  my_imshow(output, 'op')

function cdf = CDF_gen(ip)
    hist= imhist(ip);
    hist = + ones(size(hist)); % to ensure invertibility
    cdf = cumsum(hist)/sum(hist);
end

function op_value = CDF_inv(cdf,ip)
    ip = double(ip);
    [c, index_1] = min(min(abs(cdf-ip)));
    index_2 = index_1 +sign(ip-cdf(index_1));
    op_value = (cdf(index_1)*index_2 + cdf(index_2)*index_1 )/(cdf(index_1)+ cdf(index_2));
end