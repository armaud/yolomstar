function [location clut]=placeholder(clutter,chip1)
% clear all
% close all
% clc
% % clutter
% clutter=imread('Dataset\ClutterConverted\HB06158.jpeg');
% chip1=imresize(imread('Dataset\ChipsConverted\BTR_60\HB03340.jpeg'),1);
% imshow(clutter)
chip = chip1;
image=medfilt2(clutter,[2 2]);
% imshow(image)
M = mean(image(:));
% figure
image(image<M*3) = 0;
% imshow(image)

chip=medfilt2(chip,[2 2]);
% figure
M = mean(chip(:));
chip(chip<M*2) = 0;
% imshow(chip)
window = size(chip);
loops = size(image);
locations=[];
for rows = 1:window(1)-1:loops(1)-window(1)
for columns = 1:window(2)-1:loops(2)-window(2)
    locations(rows,columns) = abs(corr2(chip,image(rows:rows+window(1)-1,columns:columns+window(2)-1)));
end
end
% mesh(locations)
[r c]=find(locations==max(max(locations)));
% imshow(clutter)
% rectangle('position',[r c window],'EdgeColor','r')
% figure
im = clutter(r:r+window(1)-1,c:c+window(2)-1);
meanIm = mean(im(:));
clutter(c:c+window(1)-1,r:r+window(2)-1)=chip1+meanIm-mean(chip1(:));
imshow(clutter)
rectangle('position',[r c window],'EdgeColor','r')
location = [c r window];
clut = clutter;
