clear all
clc

cdf_A = [1 2 3 4 6 7 8 10 11 19 20 50]; 
img = [2 4 6 8 10 10; 11 14 13 20 18 70];
[mem, mem] = ismember(img,cdf_A);

img
mem