% function output = myHE(input)
%Image Enhancement using Histogram Equalisation 
    input = imread('../data/HMRefImage.png');
    size(input)
        [counts,hist]= imhist(input)
        hist = hist/sum(hist);
        cdf = cumsum(hist)/sum(hist);
        plot(hist);
        hold on;
        plot(cdf)
% end