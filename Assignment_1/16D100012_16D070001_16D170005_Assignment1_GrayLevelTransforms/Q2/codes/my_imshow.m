function my_imshow(input,name)
    numberColours = 200;
    colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
    figure('Name',name,'NumberTitle','off');
    imagesc(input);
    title(name);
    truesize;
    colormap(colorScale);
%    colormap jet
    daspect([1,1,1]);
    axis tight;
    colorbar
%     dest = cat(2,name,'.jpg')
%     imwrite(input,colormap(colorScale),dest,'jpg');
    