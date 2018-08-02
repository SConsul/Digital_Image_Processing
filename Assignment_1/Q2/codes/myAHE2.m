function [op]=myAHE2(inp,N)
%% Using nlfilter function
    f = @AHE_nlfilter;
    op = nlfilter(inp,[N N], f);
end

function op=AHE_nlfilter(A)
    edges = linspace(1,256,256);
    hist = histcounts(A,edges);
    cdf = cumsum(hist)/sum(hist);
    center = uint8(floor(size(A,1)*0.5) + 1);
    op = cdf(A(center,center))*255;
end
