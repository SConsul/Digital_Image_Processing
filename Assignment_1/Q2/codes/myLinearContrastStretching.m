%function output = myLinearContrastStretching(input)
%%Linear contrasting 
input= imread('../data/church.png');
clc

output = input;
output = arrayfun(@pwl,input);

outputr = input;
outputr(:,:,1) = arrayfun(@pwl,input(:,:,1));

outputg = input;
outputg(:,:,2) = arrayfun(@pwl,input(:,:,2));

outputb = input;
outputb(:,:,3) = arrayfun(@pwl,input(:,:,3));

figure(1);
subplot(2,2,1),imshow(output)
subplot(2,2,2),imshow(outputr)
subplot(2,2,3),imshow(outputg)
subplot(2,2,4),imshow(outputb)

x=linspace(0,255,256);
y=arrayfun(@pwl,x);
figure(2);
plot(x,y)  
hold on; 
plot(x,x);
ylim([0,255])
%end

function op_intensity = pwl(in_intensity);
        x1 = 64;
        y1 = 150;
        x2 = 192;
        y2 = 224;
        if ((in_intensity >= 0 && in_intensity <= x1))
            op_intensity = in_intensity*(y1/x1);
            
        elseif ((in_intensity>x1 && in_intensity<= x2))
            op_intensity = y1 + (y2 - y1)*(in_intensity-x1)/(x2-x1);
            
        else
            op_intensity = y2 + (255 - y2)*(in_intensity-x2)/(255-x2);
        end
        
end