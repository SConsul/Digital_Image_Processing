function [op]=myCLAHE(inp,N,thresh)
%% Using nlfilter function
    f = @(x) CLAHE_nlfilter(x,thresh);
    op = nlfilter(inp,[N N], f);
end

function op=CLAHE_nlfilter(A,thresh)
    edges = linspace(1,256,256);
    hist = histcounts(A,edges);
    hist = clip(hist, thresh);
    cdf = cumsum(hist)/sum(hist);
    center = uint8(floor(size(A,1)*0.5) + 1);
    op = (cdf(A(center,center))*255);
end

function clipped_hist = clip(hist, thresh)
    over = hist > thresh;
    excess = sum(hist(over)) - sum(over)*thresh;
    hist(over) = thresh;
    clipped_hist = hist + (excess/size(hist,1));
end