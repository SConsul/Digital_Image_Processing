function output = myRandomPatchBasedFilter(input,ps,ws,a,h,num_samples)
% Patch based filtering
% Neumann Boundary Padding
P = (ps-1)/2;
W = (ws-1)/2;
pad = P+W;
padded_input = padarray(input, [pad pad], 'replicate', 'both');

iso_gaussian = fspecial('gaussian', ps, a);
iso_gaussian = iso_gaussian/sum(iso_gaussian(:));
sigma = ws/3;
output = zeros(size(input));
    for i = pad+1 : pad+size(input,1)
        for j = pad+1: pad+size(input,2)
            weights = zeros(ws,ws);
            centre_patch = padded_input( (i-P : i+P),(j-P : j+P) );
            iso_centre_patch = centre_patch.*iso_gaussian;
            
            coords = randn([num_samples,2])*sigma;
            coords(:,1) = coords(:,1)+i;
            coords(:,2) = coords(:,2)+j;
            denom = 0;
            nr = 0;
            for n = 1:num_samples
               a = abs(coords(n,:)-[i,j]);
               if abs(coords(n,1)-i) < W
                   if abs(coords(n,2)-j) < W
                   x=floor(coords(n,1));
               y=floor(coords(n,2));
               patch = padded_input( (x-P : x+P),(y-P : y+P) );
               iso_patch = patch.*iso_gaussian;
               weight = exp(-1*sum(sum((iso_patch - iso_centre_patch).^2))/(2*h^2) );
               denom = denom+weight;
               nr = nr+weight*padded_input(x,y);
                   end
               end
               
              end
            
            output(i-pad,j-pad) =  nr/denom;
        end
    end
end

