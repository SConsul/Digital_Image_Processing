 function output = myBilateralFiltering(input,sigma_space,sigma_int)
%%Code for Bilateral filtering
    %Creating a gaussian weight in space common for all pixel windows
    hsize = floor(4*sigma_space);
    c1= sqrt(2*pi)*sigma_int;
    gaussian_space = fspecial('gaussian',[2*hsize+1,2*hsize+1],sigma_space);
    output =zeros(size(input));
    [height,width] = size(input);
    input1 =  padarray(input, [hsize hsize], inf);%Infinite to avoid interference in intensity weights due to padding
    for i = 1+hsize:width+hsize
        for j = 1+hsize:height+hsize
            window = input1( i-hsize:i+hsize, j-hsize:j+hsize);
            %Finding the intensity gaussian weights
            gaussian_int = exp(-(input1(i,j)- window).^2/(2*sigma_int^2))/c1;
            %calculating output pixel value
            window(window == inf) = 0;%Setting padding to 0 while accounting for weights
            numerator = sum(gaussian_int.*gaussian_space.*window);
            denominator = sum(gaussian_int.*gaussian_space);
            output(i-hsize,j-hsize) = numerator/denominator;
        end
    end
 end
