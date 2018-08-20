function output = myPatchBasedFiltering(input,ps,ws,a,h)
% Patch based filtering
% Neumann Boundary Padding
P = (ps-1)/2;
W = (ws-1)/2;
pad = P+W;
padded_input = padarray(input, [pad pad], 'replicate', 'both');

prob_Gaussian = fspecial('gaussian', ws, 1.6); 
iso_gaussian = fspecial('gaussian', ps, a);
iso_gaussian = iso_gaussian/sum(iso_gaussian(:));

output = zeros(size(input));
    for i = pad+1 : pad+size(input,1)
        for j = pad+1: pad+size(input,2)
            weights = zeros(ws,ws);
            centre_patch = padded_input( (i-P : i+P),(j-P : j+P) );
            iso_centre_patch = centre_patch.*iso_gaussian;
%             window = padded_input( (i-(ws-1)/2 : i+(ws-1)/2),(j-(ws-1)/2 : j+(ws-1)/2) );
            for m = i-W:i+W-1
                for n = j-W:j+W-1
                    if(prob_Gaussian(m+1+W-i,n+1+W-j) >(5e-6)*rand())
                        % randomly selecting patches from spatial Gaussian Isotropic (slide 44)
                        % Constant tuned to ensure enough patches, 
                        % while keeping compute time low

                        %finding patch around (m,n)
                        patch = padded_input( (m-P : m+P),(n-P : n+P) );
                        iso_patch = patch.*iso_gaussian;
                        weights(m-i+W+1,n-j+W+1) = exp(-1*sum(sum((iso_patch - iso_centre_patch).^2))/(2*h^2) ); 
                    end
                end
            end
             
            weight = double(weights)/double(sum(weights(:)));
            window = padded_input((i-W:i+W),(j-W:j+W));

             output(i-pad,j-pad) = sum(sum(window.*weight));
        end
    end
end
