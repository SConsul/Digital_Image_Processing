function output = myHE_test(input,arg, varargin)
%Image Enhancement using Histogram Equalisation (independent channel)
    if(nargin==2) 
        s = size(input);
        mask = true(s(1), s(2));
    else
        mask = cell2mat(varargin(1,1));
    end
    
    output = input;
    
    if(arg=='g')
        cdf = CDF_gen(input(mask));
        output = cell2mat(arrayfun(@(z)CDF(cdf,z),input,'UniformOutput',false));
        output = output.*mask;
    else
          r_i = input(:,:,1);
          g_i = input(:,:,2);
          b_i = input(:,:,3);

          cdf_r = CDF_gen(r_i(mask));
          cdf_g = CDF_gen(g_i(mask));
          cdf_b = CDF_gen(b_i(mask));

          if(arg =='ind')
              r_he = cell2mat(arrayfun(@(z)CDF(cdf_r,z),r_i,'UniformOutput',false));
              g_he = cell2mat(arrayfun(@(z)CDF(cdf_g,z),g_i,'UniformOutput',false));
              b_he = cell2mat(arrayfun(@(z)CDF(cdf_b,z),b_i,'UniformOutput',false));
              
          elseif(arg =='avg')
              cdf_avg = (cdf_r + cdf_g + cdf_b)/3;
        %     cdf_w = 0.299*cdf_r + 0.587*cdf_g + 0.114*cdf_b; 
              r_he = cell2mat(arrayfun(@(z)CDF(cdf_avg,z),r_i,'UniformOutput',false));
              g_he = cell2mat(arrayfun(@(z)CDF(cdf_avg,z),g_i,'UniformOutput',false));
              b_he = cell2mat(arrayfun(@(z)CDF(cdf_avg,z),b_i,'UniformOutput',false));
          end
          
          output(:,:,1) = r_he.*mask;
          output(:,:,2) = g_he.*mask;
          output(:,:,3) = b_he.*mask;
    end
       
end

    function cdf = CDF_gen(ip)
        hist= imhist(ip);
        cdf = double(cumsum(hist))/double(sum(hist));
    end

    function op = CDF(cdf,ip)
        op = double(255)*cdf(ip+1,1);
    end