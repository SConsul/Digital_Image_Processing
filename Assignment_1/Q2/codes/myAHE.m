function output = myAHE(input,N)
   offset = floor(N/2);
   padded = padarray(int16(input),[offset offset], -1);
   f = @get_hist;
   hist_init = 
%    shape = size(input
   for i=1:size(input,1)
       for j=1:size(input,1)
           
       end
   end
       
end

function op = applyHE(hist,pixel_value)
    cdf = cumsum(hist)/sum(hist);
    op = uint8(cdf(pixel_value+1)*255);
end

function [hist_cols]=get_hist(inp,x,y,x_offset,y_offset)
    inp = int16(inp);
    hist_cols = histcounts(inp(x-x_offset:x+x_offset,y-y_offset:y+y_offset),linspace(0,256,257));
end