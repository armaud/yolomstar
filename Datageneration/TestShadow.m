close all
clear all
clc
clutter=imread('Dataset\ClutterConverted\HB06166.jpeg');
[r c] = size(clutter);
clutterCreator =1;
while(true)
r1 = randi([1,r])
r2 = randi([1,r])
c1 = randi(randi([1,c]))
c2 = randi([randi([1,c])])

if ((abs(r2-r1)*abs(c2-c1))> 1000000)
figure
    imshow(clutter(min(r1,r2):max(r1,r2),min(c1,c2):max(c1,c2)))
%% copy alogrithm
    
%%    
    clutterCreator = clutterCreator+1;
if clutterCreator == 15
break
end
end
end