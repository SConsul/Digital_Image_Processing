function output = myAHE(input,N,thresh)
    offset = floor(N/2);
    padded = padarray(int16(input),[offset offset 0], -1);
    output = zeros(size(input));

    for iter = 1: size(input,3)
    pad = padded(:,:,iter);
       for j=1:size(input,2)
           hist = histcounts(pad(1:N,j:min(j+N-1,size(pad,2))),0:1:256);
           for i=1:size(input,1)
               norm_hist = hist/sum(hist);
               output(i,j,iter) = applyAHE(norm_hist,pad(i+offset,j+offset));
               hist_prev = histcounts(pad(i,j:min(j+N-1,size(pad,2))),0:1:256);
               hist_next = histcounts(pad(min(i+N,size(pad,1)),j:min(j+N-1,size(pad,2))),0:1:256);
               hist = hist - hist_prev;
               hist = hist + hist_next;
           end
       end 
    end
end

function op = applyAHE(hist,pixel_value)
    cdf = cumsum(hist);
    op = (cdf(pixel_value+1)*255);
end

% function output = myAHE(input,N)
%        offset = floor(N/2);
%        padded = padarray(int16(input),[offset offset 0], -1);
%        output = zeros(size(input));
% 
%     for iter = 1: size(input,3)
%     pad = padded(:,:,iter);
%        for j=1:size(input,2)
%            hist = get_hist(pad,offset+1,j+offset,offset,offset);
%            for i=1:size(input,1)
%                output(i,j,iter) = applyHE(hist,pad(i+offset,j+offset));
%                hist_prev = get_hist(pad,i,j+offset,0,offset);
%                hist_next = get_hist(pad,min(i+N,size(pad,1)),j+offset,0,offset);
%                hist = hist - hist_prev + hist_next;
%            end
%        end 
%     end
% end
% 
% % function ouput=myAHE_vect(input,N)
% %    offset = floor(N/2);
% %    padded = padarray(int16(input),[offset offset], -1);
% %    output = zeros(size(input));
% % %    for j=1:size(input,2)
% %     hist_init = arrayfun(@(z)get_hist(padded,offset+1,z+offset,offset,offset);
% % %        for i=1:size(input,1)
% % %            output(i,j) = applyHE(hist,padded(i+offset,j+offset));
% % %            hist_prev = get_hist(padded,i,j+offset,0,offset);
% % %            hist_next = get_hist(padded,min(i+N,size(padded,1)),j+offset,0,offset);
% % %            hist = hist - hist_prev + hist_next;
% % %       end
% % %    end  
% % end
% 
% function op = applyHE(hist,pixel_value)
%     cdf = cumsum(hist)/sum(hist);
%     op = (cdf(pixel_value+1)*255);
% end
% 
% function [hist]=get_hist(inp,x,y,x_offset,y_offset)
%     inp = int16(inp);
%     hist = histcounts(inp(x-x_offset:x+x_offset,y-y_offset:y+y_offset),linspace(0,256,257));
% end