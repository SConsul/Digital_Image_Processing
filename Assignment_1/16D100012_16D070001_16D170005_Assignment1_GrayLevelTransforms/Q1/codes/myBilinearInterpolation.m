function output = myBilinearInterpolation(input)
%%Image Enlargement using Bilinear Interpolation 
        [height, width] = size(input);
        output = zeros(3*height - 2 , 2*width - 1);
        output([1:3:end],[1:2:end]) = input;%Setting large image to original image values for every 3 in height and 2 elements in width
        output([1:3:end],[2:2:end]) = (output([1:3:end],[1:2:end-2]) + output([1:3:end],[3:2:end]) )/2;%Linear interpolation along width
        output([2:3:end],[1:end]) = (2*output([1:3:end-3],[1:end]) + output([4:3:end],[1:end]))/3;%Linear interpolation along height
        output([3:3:end],[1:end]) = (output([1:3:end-3],[1:end]) + 2*output([4:3:end],[1:end]))/3;%Linear interpolation along height
        
end