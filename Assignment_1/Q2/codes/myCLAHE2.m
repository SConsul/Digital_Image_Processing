function [op]=myCLAHE2(inp,N,thresh)
%% Using nlfilter function
    inp = int16(inp) + int16(ones(size(inp)));
    inpt = inp';
    f = @(x) CLAHE2_nlfilter(x,thresh);
    op = nlfilter(inpt,[N N], f);
end

function op=CLAHE2_nlfilter(A,thresh)
    edges = 0:1:256;
    center = (floor(size(A,1)/2) + 1);
    A = A - int16(ones(size(A)));
    hist = histcounts(A,edges);
    hist = hist/sum(hist);
    hist = clip(hist, thresh);
    cdf = cumsum(hist);
    op = cdf(A(center,center)+1)*255;
end

function clipped_hist = clip(hist, thresh)
    over = hist > thresh;
    excess = sum(hist(over)-thresh);
    hist(over) = thresh;
    clipped_hist = hist + (excess/size(hist,2));
end