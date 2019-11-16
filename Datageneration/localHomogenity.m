function [clutter , listChips] = localHomogenity(clutter,chipRead,factor)
% close all
% clear all
% clc
% clutter=imread('Dataset\ClutterConverted\HB06158.jpeg');
% chip=imresize(imread('Dataset\ChipsConverted\BTR_60\HB03340.jpeg'),1);
listChips=[];
% figure
% imshow(clutter)
%% read size of biggest chip
window=zeros(1,length(chipRead(:,1)));
for readLengthChip=1:length(chipRead(:,1))
window(readLengthChip) = prod(size(imread(char(string(chipRead(readLengthChip,2))))));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
ywindow=find(window==max(window));
window = size(imread(char(string(chipRead(ywindow(1,1),2)))));
%%%%%%%%%%%%%%%%%%%%%%%%%%%
loops = size(clutter);
locations=zeros(loops);
for rows = 1:window(1)-1:loops(1)-window(1)-1
for columns = 1:window(2)-1:loops(2)-window(2)-1
    homogeneityClutter = graycoprops(graycomatrix(clutter(rows:rows+window(1)-1,columns:columns+window(2)-1)), 'Homogeneity');
    locations(rows,columns) =homogeneityClutter.Homogeneity; 
end
end

%% insert code here
cluttermap = clutter;
cluttermap = medfilt2(cluttermap,[10 10]);
cluttermap(cluttermap<=mean(cluttermap(:)*2))=0;
cluttermap(cluttermap>0)=255;
cluttermap=logical(cluttermap);
cluttermap = bwareaopen(cluttermap,round(prod(window)/100));
% figure
% imshow(cluttermap)
cluttermap = imdilate(cluttermap, ones(50));
% figure
% imshow(cluttermap)
% close all
% imagesc(locations)
for rows = 1:window(1)-1:loops(1)-window(1)-1
for columns = 1:window(2)-1:loops(2)-window(2)-1
    tempWin = cluttermap(rows:rows+window(1)-1,columns:columns+window(2)-1);
    if mean(tempWin(:)) > 0
     locations(rows,columns) = 0;
    end
end
end

%%%%

distance=zeros(loops);
for iterateChips =1:length(chipRead(:,1))
chip = imread(char(string(chipRead(iterateChips,2))));
windows = size(chip);
tmp1=graycoprops(graycomatrix(chip(windows(1)-20:windows(1),windows(2)-20:windows(2))), 'Homogeneity');
tmp2=graycoprops(graycomatrix(chip(1:20,1:20)), 'Homogeneity');
homogeneityChip=mean([tmp1.Homogeneity tmp2.Homogeneity]);
% figure
% mesh(locations)

%% claculate distances of the indices

for i=1:loops(1)
    for j=1:loops(2)
        distance(i,j)=sqrt((locations(i,j))^2 + (homogeneityChip)^2);
        if (distance(i,j) <= homogeneityChip)
            distance(i,j)=0;
        end
    end
end
distance(distance<=homogeneityChip)= max(max(distance));
[x,y]=find(distance==min(min(distance)),1)
window = size(chip);
chip = imcrop(chip,[floor(window(1)/factor) , floor(window(2)/factor) ,ceil(window(1)/2+window(1)/factor) ceil(window(2)/2+window(2)/factor)]);
% x, y
windows = size(chip);
yf = floor(window(1)/factor);
xf = floor(window(2)/factor);
tempC=clutter(x+xf:x+xf+windows(1)-1,y+yf:y+yf+windows(2)-1);
% clutter(y+yf/2:y+yf/2+windows(1)-1,x+xf:x+xf+windows(2)-1)=(chip+mean(tempC(:))-mean(chip(:)));
tmp = chip(1:10,1:10);
tmp2 = chip(windows(1)-10-1:windows(1)-1,windows(2)-10-1:windows(2)-1);
meanValChip = mean([mean(tmp(:)) mean(tmp2(:))]); 
tmpMeanClutter = clutter(x+xf:x+xf+windows(1)-1,y+yf:y+yf+windows(2)-1);
if (mean(tmpMeanClutter(:))-meanValChip) > 5
clutter(x+xf:x+xf+windows(1)-1,y+yf:y+yf+windows(2)-1)=(chip+mean(tempC(:))-meanValChip);
else
    clutter(x+xf:x+xf+windows(1)-1,y+yf:y+yf+windows(2)-1)= chip;
    
end
%% occupy index

locations(x,y)=0;
% figure
% imshow(clutter)
% rectangle('Position',[y+yf x+xf windows(1)-1 windows(2)-1],'EdgeColor','r')
if char(string(chipRead(iterateChips,1)))== "2S1"
listChips=[1 y+yf x+xf windows(2) windows(1); listChips];
end
(chipRead(iterateChips,1))
if char(string(chipRead(iterateChips,1)))== "BRDM_2"
listChips=[2 y+yf x+xf windows(2) windows(1); listChips];
end
if char(string(chipRead(iterateChips,1)))== "BTR_60"
listChips=[3 y+yf x+xf windows(2) windows(1); listChips];
end
if char(string(chipRead(iterateChips,1)))== "D7"
listChips=[4 y+yf x+xf windows(2) windows(1); listChips];
end
% if char(string(chipRead(iterateChips,1)))== "SLICY"
% listChips=[5 y x windows(2) windows(1); listChips]
% end
if char(string(chipRead(iterateChips,1)))== "T62"
listChips=[5 y+yf x+xf windows(2) windows(1); listChips];
end
if char(string(chipRead(iterateChips,1)))== "ZIL131"
listChips=[6 y+yf x+xf windows(2) windows(1); listChips];
end
if char(string(chipRead(iterateChips,1)))== "ZSU_23_4"
listChips=[7 y+yf x+xf windows(2) windows(1); listChips];
end
iterateChips
end

% figure
% mesh(clutter)


end