function output = myHE(input)
%Image Enhancement using Histogram Equalisation (independent channel)
%         plot(hist/sum(hist));
%         hold on;
%         plot(cdf)
      r_he = input;
      g_he = input;
      b_he = input;
      output = input;
      
      cdf_r = CDF_gen(input(:,:,1));
      cdf_g = CDF_gen(input(:,:,2));
      cdf_b = CDF_gen(input(:,:,3));
     
      r_he(:,:,1) = arrayfun(@(z)CDF(cdf_r,z),input(:,:,1));
      g_he(:,:,2) = arrayfun(@(z)CDF(cdf_g,z),input(:,:,2));
      b_he(:,:,3) = arrayfun(@(z)CDF(cdf_b,z),input(:,:,3));
      
      output(:,:,1) = r_he(:,:,1);
      output(:,:,2) = g_he(:,:,2);
      output(:,:,3) = b_he(:,:,3);
      
%       subplot(1,2,1),imshow(input);
%       subplot(1,2,2),imshow(output);
%       subplot(1,5,3),imshow(r_he);
%       subplot(1,5,4),imshow(g_he);
%       subplot(1,5,5),imshow(b_he);

      
       
end

function [cdf] = CDF_gen(ip)
    hist= imhist(ip);
    cdf = cumsum(hist)/sum(hist);
end

function op = CDF(cdf,ip)
    op = floor(255*cdf(ip+1,1));
end