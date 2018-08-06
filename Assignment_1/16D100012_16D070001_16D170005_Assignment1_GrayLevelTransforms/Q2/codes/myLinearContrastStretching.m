function output = myLinearContrastStretching(input,arg)
%Linear Contrast Stretching
    output = input;
    if(arg=='g')
        minimum =min(min(input));
        maximum =max(max(input));
        output = cell2mat(arrayfun(@(z)pwl(minimum,maximum,z),input,'UniformOutput',false));
    else
        min_r =min( min(input(:,:,1)));
        max_r =max( max(input(:,:,1)));
        output(:,:,1) = cell2mat(arrayfun(@(z)pwl(min_r,max_r,z),input(:,:,1),'UniformOutput',false));

        min_g =min( min(input(:,:,2)));
        max_g = max(max(input(:,:,2)));
        output(:,:,2) =cell2mat( arrayfun(@(z)pwl(min_g,max_g,z),input(:,:,2),'UniformOutput',false));

        min_b =min( min(input(:,:,3)));
        max_b = max(max(input(:,:,3)));
        output(:,:,3) = cell2mat(arrayfun(@(z)pwl(min_b,max_b,z),input(:,:,3),'UniformOutput',false));
    end
end
function op_intensity = pwl(min,max,in_intensity)
        in_intensity = double(in_intensity);
        x1 = double(min);
        y1 = 0;
        x2 = double(max);
        y2 = 255;
        
        op_intensity = (in_intensity-x1)*((y2 - y1)./(x2 - x1)); 
end