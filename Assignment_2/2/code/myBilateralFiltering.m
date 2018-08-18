function output = myBilateralFiltering(input,hsize,sigma_space,sigma_int)
%%Code for Bilateral filtering
    %Creating a gaussian weight in space common for all pixel windows
    [row_coord,column_coord] = meshgrid(-hsize:hsize,-hsize:hsize);
    gaussian_space = exp(-(row_coord.^2 + column_coord.^2)/(2*(sigma_space).^2));
    output =zeros(size(input));
    [height,width] = size(input);
    for i = 1:width
        for j = 1:height
            %Constraints on the window coordinates
            window_xmin = max(1,i-hsize);
            window_xmax = min(width,i+hsize);
            window_ymin = max(1,j-hsize);
            window_ymax = min(height, j + hsize);
            %Selecting the final window around pixel
            window = input(window_xmin:window_xmax, window_ymin:window_ymax);
            %Finding the intensity gaussian weights
            gaussian_int = exp(-(input(i,j)- window).^2/(2*(sigma_int).^2));
            %Adjusting the size of gaussian_space kernel
            gaussian_space_adj = gaussian_space(hsize+1-(i-window_xmin):hsize+1+(window_xmax-i),hsize+1-(j-window_ymin):hsize+1+(window_ymax-j));
            %calculating output pixel value
            numerator = sum(gaussian_int.*gaussian_space_adj.*window);
            denominator = sum(gaussian_int.*gaussian_space_adj);
            output(i,j) = numerator/denominator;
        end
    end
end
