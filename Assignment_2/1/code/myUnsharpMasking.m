function output = myUnsharpMasking(input,sigma,hsize,scale)
%Sharpening images using unsharp mask
    gaussian_filt = fspecial('gaussian',hsize,sigma);
    input_blur = imfilter(input,gaussian_filt,'replicate','conv');
    unsharp_input = input - input_blur;
    output = scale*unsharp_input + input;
end
    
    

    