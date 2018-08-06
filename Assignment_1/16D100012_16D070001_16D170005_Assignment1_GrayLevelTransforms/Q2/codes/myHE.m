function output = myHE(input,arg, varargin)
% Image Enhancement using Histogram Equalisation (independent channel)
% arg == 'g' for greyscale images
% arg == 'avg' for RGB images, average channels' histogram CDF before equalisation
% arg == 'ind' for treating each channel of RGB image independently

    % If mask is not provided, take a default of all ones (no masking)
    if(nargin==2) 
        s = size(input);
        mask = true(s(1), s(2));
    else
        mask = cell2mat(varargin(1,1));
    end
    
    output = zeros(size(input));
    
    if(arg=='g')
        cdf = CDF_gen(input(mask));
        output = cell2mat(arrayfun(@(z)CDF(cdf,z),input,'UniformOutput',false));
        output = output.*mask;
    else %input is RGB image
        
          %extracting each channel of input
          r_i = input(:,:,1);
          g_i = input(:,:,2);
          b_i = input(:,:,3);
          
          %finding CDF for each channel of input
          cdf_r = CDF_gen(r_i(mask));
          cdf_g = CDF_gen(g_i(mask));
          cdf_b = CDF_gen(b_i(mask));
        
          if(arg =='ind')
              %Map each channel to respective channel CDF 
              r_he = cell2mat(arrayfun(@(z)CDF(cdf_r,z),r_i,'UniformOutput',false));
              g_he = cell2mat(arrayfun(@(z)CDF(cdf_g,z),g_i,'UniformOutput',false));
              b_he = cell2mat(arrayfun(@(z)CDF(cdf_b,z),b_i,'UniformOutput',false));
              
          elseif(arg =='avg')
              %Average the 3 CDFs
              cdf_avg = (cdf_r + cdf_g + cdf_b)/3; 
              %Map to the averaged CDF
              r_he = cell2mat(arrayfun(@(z)CDF(cdf_avg,z),r_i,'UniformOutput',false));
              g_he = cell2mat(arrayfun(@(z)CDF(cdf_avg,z),g_i,'UniformOutput',false));
              b_he = cell2mat(arrayfun(@(z)CDF(cdf_avg,z),b_i,'UniformOutput',false));
          end
          
          %Mask the the output to ensure black mask is unchanged.
          output(:,:,1) = r_he.*mask;
          output(:,:,2) = g_he.*mask;
          output(:,:,3) = b_he.*mask;
    end
       
end

    function cdf = CDF_gen(ip)
    %Obtain normalised histogram
        hist = histcounts(ip,linspace(0,256,257),'Normalization','probability');
    %Obtain CDF
        cdf = cumsum(hist);
    end

    function op = CDF(cdf,ip)
    %Map input pixel value to corresponding CDF, Scaled up to range of 0-255
      op = double(255*cdf(floor(ip)+1));
        
    end