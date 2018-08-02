function [op]=myCLAHE(inp,N,thresh)
%% Using nlfilter function
    f = @(x) CLAHE_nlfilter(x,thresh);
    op = nlfilter(inp,[N N], f);
end

function op=CLAHE_nlfilter(A,thresh)
    edges = linspace(1,256,256);
    hist = histcounts(A,edges);
    clipped_hist = clip(hist, thresh);
    
    cdf = cumsum(clipped_hist)/sum(clipped_hist);
    center = uint8(floor(size(A,1)*0.5) + 1);
    op = uint8(cdf(A(center,center)+1)*255);
end

function clipped_hist = clip(hist, thresh)
    over = hist > thresh;
    excess = sum(over) - sum(over)*thresh;
    hist(over) = thresh;
    clipped_hist = hist + floor(excess/size(hist,1));
end