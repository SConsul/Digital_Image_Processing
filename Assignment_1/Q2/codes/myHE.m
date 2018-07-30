function [output,avg,w] = myHE(input)
%Image Enhancement using Histogram Equalisation (independent channel)
%         plot(hist/sum(hist));
%         hold on;
%         plot(cdf)
      r_i = input(:,:,1);
      g_i = input(:,:,2);
      b_i = input(:,:,3);
      
      output = input;
      avg = input; 
      w = input;
      
      cdf_r = CDF_gen(r_i);
      cdf_g = CDF_gen(g_i);
      cdf_b = CDF_gen(b_i);
      
      cdf_avg = (cdf_r + cdf_g + cdf_b)/3;
      cdf_w = 0.299*cdf_r + 0.587*cdf_g + 0.114*cdf_b; 
      
      r_he = arrayfun(@(z)CDF(cdf_r,z),r_i);
      g_he = arrayfun(@(z)CDF(cdf_g,z),g_i);
      b_he = arrayfun(@(z)CDF(cdf_b,z),b_i);
      
      r_avg = arrayfun(@(z)CDF(cdf_avg,z),r_i);
      g_avg = arrayfun(@(z)CDF(cdf_avg,z),g_i);
      b_avg = arrayfun(@(z)CDF(cdf_avg,z),b_i);
      
      r_w = arrayfun(@(z)CDF(cdf_w,z),r_i);
      g_w = arrayfun(@(z)CDF(cdf_w,z),g_i);
      b_w = arrayfun(@(z)CDF(cdf_w,z),b_i);
      
      output(:,:,1) = r_he;
      output(:,:,2) = g_he;
      output(:,:,3) = b_he;
      
      avg(:,:,1) = r_avg;
      avg(:,:,2) = g_avg;
      avg(:,:,3) = b_avg;
      
      w(:,:,1) = r_avg;
      w(:,:,2) = g_avg;
      w(:,:,3) = b_avg;
      
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