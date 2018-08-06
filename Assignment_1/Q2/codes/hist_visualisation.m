function hist_visualisation()
global pad;
global win;
global fig;
global im_fig;
inp_data = imread('../data/TEM.png');
im_fig = figure('Name','data');
imshow(inp_data);
win = 231;
offset = floor(win/2);
fig = figure('Name','hist');
pad = padarray(inp_data , [offset offset], -1);

set (im_fig, 'WindowButtonMotionFcn', @mouseMove);
end

function mouseMove (object, eventdata)
global pad;
global win;
global fig;
global im_fig;
C = get(get(im_fig,'CurrentAxes'), 'CurrentPoint');

clf(fig);
title(gca, ['(X,Y) = (', num2str(C(1,1)), ', ',num2str(C(1,2)), ')']);

x = C(1,2);
y = C(1,1);
% size(pad)

if x > 0 && y > 0
    patch = pad(x:(min(x+win-1,size(pad,1))),y:min(y+win-1,size(pad,2)));
    size(patch)
    hist = histcounts(patch,0:1:256,'Normalization','probability');
%     hist = hist(1:255);
    figure(fig);
%     ylim([0 0.025]);
    bar(1:255,hist(2:256));
%     figure(im_fig);
end


end