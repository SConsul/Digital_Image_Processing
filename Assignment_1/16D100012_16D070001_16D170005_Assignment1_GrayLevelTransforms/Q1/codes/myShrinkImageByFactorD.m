function output = myShrinkImageByFactorD(input, D)
% Shrinks the input image by a factor of D
    output = input([1:D:end],[1:D:end]);%Sampling for every Dth element in the array
    
end