function output = myCLAHE(input,N,thresh)
    offset = floor(N/2);
    padded = padarray(int16(input),[offset offset 0], -1);
    output = zeros(size(input));

    for iter = 1: size(input,3)
    pad = padded(:,:,iter);
       for j=1:size(input,2)
           hist = histcounts(pad(1:N,j:min(j+N-1,size(pad,2))),0:1:256);
           for i=1:size(input,1)
               norm_hist = hist/sum(hist);
               output(i,j,iter) = applyCLAHE(norm_hist,pad(i+offset,j+offset),thresh);
               hist_prev = histcounts(pad(i,j:min(j+N-1,size(pad,2))),0:1:256);
               hist_next = histcounts(pad(min(i+N,size(pad,1)),j:min(j+N-1,size(pad,2))),0:1:256);
               hist = hist - hist_prev;
               hist = hist + hist_next;
           end
       end 
    end
end

function op = applyCLAHE(hist,pixel_value,thresh)
    hist = clip(hist, thresh);
    cdf = cumsum(hist);
    op = (cdf(pixel_value+1)*255);
end

function clipped_hist = clip(hist, thresh)
    over = hist > thresh;
    excess = sum(hist(over)-thresh);
    hist(over) = thresh;
    clipped_hist = hist + (excess/size(hist,2));
end