close all
clear all
clc
chipSize = 5;
medianSizePre = 10;
medianSizePost = 5;
clutter = imread('Dataset\ClutterConverted\HB06195.jpeg');
chip1 = imread('Dataset\ChipsConverted\2S1\HB14934.jpeg');
chip2 = imread('Dataset\ChipsConverted\BTR_60\HB03341.jpeg');
chip3 = imread('Dataset\ChipsConverted\D7\HB14933.jpeg');
template = imread('template.jpeg');
%% median filter application
clutter = medfilt2(clutter,[medianSizePre medianSizePre]);
mat = clutter;
imshow(clutter)
% figure
% imshow(chip1)
image=medfilt2(clutter,[2 2]);
imshow(image)
M = mean(image(:))
figure
image(image<M*3) = 0;
imshow(image)

chip=medfilt2(chip,[2 2])
figure
M = mean(chip(:))
chip(chip<M*2) = 0;
imshow(chip)
for k =1:3
locations =[];
if k == 1
    chip = chip1
end    
if k == 2
    chip = chip2
end
if k == 3
    chip = chip3
end
%% chip median filter
chip=medfilt2(chip,[medianSizePre medianSizePre]);
% chip = imresize(chip,2)
window = size(chip)
loops = size(clutter)

meanClutter = mean(double(clutter(:)))
meanChip = mean(double(chip1(:)))
chip = chip + meanClutter - meanChip/2;

mean(double(chip(:)))
% figure
% imshow(uint8(chip))
% % % mat = clutter;
% % % % mat(loops(1)-window(1)+1:loops(1),loops(2)+1-window(2):loops(2)) = chip;
% % % figure
% % % imshow(uint8(mat))
%% sliding windows

    
for rows = 1:window(1)-1:loops(1)-window(1)
for columns = 1:window(2)-1:loops(2)-window(2)
% for rows = 1:loops(1)-window(1)
%     for columns = 1:loops(2)-window(2)
   im = clutter(rows:rows+window(1)-1,columns:columns+window(2)-1);
% size(im)
   locations(rows,columns) =abs(corr2(chip,im));
% pause(0.5)
    end
    rows
end
% mesh(locations)
[row column value] = find(locations==max(max(locations)))
%% place chip in clutter

% mat(row+window(1):row+window(1)+window(1)-1, column+window(2):column+window(2)+window(2)-1) =(mat(row+window(1):row+window(1)+window(1)-1, column+window(2):column+window(2)+window(2)-1) +chip)/2;
% mat(row+window(1):row+window(1)+window(1)-1, column+window(2):column+window(2)+window(2)-1) =chip1;
[r,c]=size(chip);

% chip = chip(round(r/2)-round(r/chipSize):round(r/2)+round(r/chipSize),round(c/2)-round(c/chipSize):round(c/2)+round(c/chipSize));
% [r c]= size(chip);
tempImg = mat(row+r:row+2*r-1, column:column+c-1);
meanTemp = mean(tempImg(:))
chip = chip + meanTemp - mean(chip(:))
mat(row+r:row+2*r-1, column:column+c-1) = chip;
end
figure
imshow(mat)
% imshow(medfilt2(mat,[medianSizePost medianSizePost]));
% imshow(imfilter(mat,ones(medianSizePost)))