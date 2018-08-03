% function clipped_hist = clip(hist, thresh)
    hist = [0, 1, 4, 10, 90, 130, 190, 255]
    thresh = 100
    over = hist > thresh
    excess = sum(hist(over)) - sum(over)*thresh
    hist(over) = thresh
    clipped_hist = hist + floor(excess/size(hist,2))
% end