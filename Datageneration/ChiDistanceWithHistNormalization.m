function [countChips ,clutter , listChips] = ChiDistanceWithHistNormalization(clutter,chipRead)
%close all
%clear all
%clc
%warning off
%cRlutter=imread('Dataset/ClutterConverted/HB06158.jpeg');
%chip=imresize(imread('Dataset/ChipsConverted/ZIL131/HB14979.jpeg'),1);
listChips=[];
countChips = 0;
% figure
% imshow(clutter) 
%% read size of biggest chip
window=zeros(1,length(chipRead(:,1)));
for readLengthChip=1:length(chipRead(:,1))
window(readLengthChip) = prod(size(imread(char(string(chipRead(readLengthChip,2))))));
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%
ywindow=find(window==max(window));
window = size(imread(char(string(chipRead(ywindow(1,1),2)))));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%
%window = size(chip);

for iterateChips = 1 : length(chipRead(:,1))
    chip = imread(char(chipRead(iterateChips,2)));
loops = size(clutter);
locations=zeros(loops);
windows = size(chip);
for rows = 1:window(1)-1:loops(1)-window(1)-1
for columns = 1:window(2)-1:loops(2)-window(2)-1
    histClutter = imhist(clutter(rows:rows+window(1)-1,columns:columns+window(2)-1));
    cropChip = [chip(:,1:10);chip(:,windows(2)-10:windows(2)-1)];
    histChip = imhist(cropChip);
    locations(rows,columns) = distChiSq(histClutter',histChip'); 
end
end
if (locations(locations>0)>0)
[x,y] = find(locations==min(locations(locations>0)));
% mesh(locations)
% figure
% subplot(2,1,1)
cropClutter = clutter(x:window(1)+x,y:window(2)+y);
% imshow(cropClutter)
%subplot(2,1,2)
%imshow(chip-mean(chip(:))+mean(cropClutter(:)))
% figure
clutterShow = clutter;
clutterShow1 = clutter;
clutterShow(x:windows(1)+x-1,y:windows(2)+y-1) = chip;
% imshow(clutterShow)
% figure
MeanChip = mean([mean(reshape(chip(1:10,1:10),1,[])) mean(reshape(chip(windows(1)-10:windows(1),windows(2)-10:windows(2)),1,[]))]);
if (MeanChip-mean(cropClutter(:)))>10 
clutterShow1(x:windows(1)+x-1,y:windows(2)+y-1) = chip-MeanChip+mean(cropClutter(:));
else
    clutterShow1(x:windows(1)+x-1,y:windows(2)+y-1) = chip;
end
% figure
% imshow(clutterShow1)
%%
cluttermap = clutter;
cluttermap = medfilt2(cluttermap,[10 10]);
cluttermap1 = medfilt2(cluttermap,[10 10]);
cluttermap(cluttermap1<mean(cluttermap1(:))/2)=255;
cluttermap(cluttermap<=mean(cluttermap(:)*2))=0;
cluttermap(cluttermap>0)=255;

cluttermap=logical(cluttermap);
%cluttermap = bwareaopen(cluttermap,round(prod(windows)/50));
% figure
% imshow(cluttermap)
cluttermap = imdilate(cluttermap, ones(15));

% figure
% imshow(cluttermap)
% % % % % % close all
% % % % % % imagesc(locations)
for rows = 1:window(1)-1:loops(1)-window(1)-1
for columns = 1:window(2)-1:loops(2)-window(2)-1
    tempWin = cluttermap(rows:rows+window(1)-1,columns:columns+window(2)-1);
    if mean(tempWin(:)) > 0
     locations(rows,columns) = 0;
    end
end
end
% figure
if (locations(locations>0)>0)
[x,y] = find(locations==min(locations(locations>0)));
%mesh(locations)
%figure
cropClutter = clutter(x:windows(1)+x,y:windows(2)+y);
MeanChip = mean([mean(reshape(chip(1:10,:),1,[])) mean(reshape(chip(1:10,1:10),1,[])) mean(reshape(chip(windows(1)-10:windows(1),windows(2)-10:windows(2)),1,[]))]);
clutterShow2 = clutter;
factor=6;
 yf = floor(windows(1)/factor);
 xf = floor(windows(2)/factor);
 chip = imcrop(chip,[floor(windows(1)/factor) , floor(windows(2)/factor) ,ceil(windows(1)/2+windows(1)/factor) ,ceil(windows(2)/2+windows(2)/factor)]);
windows = size(chip);

MeanChip
mean(cropClutter(:))
if abs(MeanChip-mean(cropClutter(:)))<=3

% if abs(MeanChip-mean(cropClutter(:)))>8
%clutterShow2(w+yf/2:w+yf/2+windows(1)-1,h+xf:h+xf+windows(2)-1) = chip+(abs(-MeanChip+mean(cropClutter(:))/2));
%else
    clutterShow2(x+yf/2:x+yf/2+windows(1)-1,y+xf:y+xf+windows(2)-1) = chip;
%end
% figure
% imshow(clutterShow2)
clutter = clutterShow2;
%%%%%%%%%%%%


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
disp('chip placed')
countChips = countChips+1;
%imshow(clutter)
else
    disp('chip not placed')
end
clutter = clutterShow2;
end
if (locations(locations>0)<=0)
break
end
end
end



end