function my_imshow(varargin)

    numberColours = 200;
    colorScale = [[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]',[0:1/(numberColours-1):1]'];
    figure('NumberTitle','off', 'position', [50, 50, 1200, 400]);

    num = nargin/2;
    for k = 1:num
        subplot(1,num,k);
        imagesc(varargin{2*k-1});
        title(varargin{2*k}, 'Fontsize', 12, 'Fontname', 'Cambria');
        % truesize;
        colormap(colorScale);
        daspect([1,1,1]);
        axis tight;
        colorbar;

    end
end
    