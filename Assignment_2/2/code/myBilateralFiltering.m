 function output = myBilateralFiltering(input,sigma_space,sigma_int)
%%Code for Bilateral filtering
    %Creating a gaussian weight in space common for all pixel windows
    hsize = floor(4*sigma_space);
    [row_coord,column_coord] = meshgrid(-hsize:hsize,-hsize:hsize);
    k1= sqrt(2*pi)*sigma_int;
    k2= sqrt(2*pi)*sigma_space;
    %gaussian_space = exp(-(row_coord.^2 + column_coord.^2)/(2*sigma_space^2))/k2;
    gaussian_space = fspecial('gaussian',[2*hsize+1,2*hsize+1],sigma_space);
    output =zeros(size(input));
    [height,width] = size(input);
    input1 =  padarray(input, [hsize hsize], inf);
    for i = 1+hsize:width+hsize
        for j = 1+hsize:height+hsize
            %Constraints on the window coordinates
%             window_xmin = max(1,i-hsize);
%             window_xmax = min(width,i+hsize);
%             window_ymin = max(1,j-hsize);
%             window_ymax = min(height, j + hsize);
            %Selecting the final window around pixel
%            window = input(window_xmin:window_xmax, window_ymin:window_ymax);
            window = input1( i-hsize:i+hsize, j-hsize:j+hsize);
            
            %Finding the intensity gaussian weights
            gaussian_int = exp(-(input1(i,j)- window).^2/(2*sigma_int^2))/k1;
            %Adjusting the size of gaussian_space kernel
            %gaussian_space_adj = gaussian_space(hsize+1-(i-window_xmin):hsize+1+(window_xmax-i),hsize+1-(j-window_ymin):hsize+1+(window_ymax-j));
            %calculating output pixel value
            window(window == inf) = 0;
            numerator = sum(gaussian_int.*gaussian_space.*window);
            denominator = sum(gaussian_int.*gaussian_space);
            output(i-hsize,j-hsize) = numerator/denominator;
        end
    end
 end
