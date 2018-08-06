function output = myAHE(input,N)
% Adaptive Histogram Equalisation

    offset = floor(N/2);
%   padding the input array by -1 to handle edge cases 
    padded = padarray(int16(input),[offset offset 0], -1);
    output = zeros(size(input));

    for iter = 1: size(input,3) % iterating over individual channels
    pad = padded(:,:,iter);
       for j=1:size(input,2)
           % generating histogram for the NxN window around the first pixel of each column
           hist = histcounts(pad(1:N,j:min(j+N-1,size(pad,2))),0:1:256);
           for i=1:size(input,1)
               % normalising histogram
               norm_hist = hist/sum(hist);
               
               output(i,j,iter) = applyAHE(norm_hist,pad(i+offset,j+offset));
               
               % calculating histogram of the first row of the window
               hist_prev = histcounts(pad(i,j:min(j+N-1,size(pad,2))),0:1:256);
               
               % calculating histogram of the row just below the window
               hist_next = histcounts(pad(min(i+N,size(pad,1)),j:min(j+N-1,size(pad,2))),0:1:256);
               
               % histogram for the next pixel (below current pixel) is given by following method 
               hist = hist - hist_prev;
               hist = hist + hist_next;
           end
       end 
    end
end

function op = applyAHE(hist,pixel_value)
    cdf = cumsum(hist);
    op = (cdf(pixel_value+1)*255);
end