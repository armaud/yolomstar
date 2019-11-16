clear all
close all
clc
warning off
%% read all chips
imds = imageDatastore('Dataset\ChipsConverted',...
'IncludeSubfolders',true,'FileExtensions','.jpeg','LabelSource','foldernames')
imdsClutter = imageDatastore('Dataset\ClutterConverted',...
'IncludeSubfolders',true,'FileExtensions','.jpeg','LabelSource','foldernames')
%% read clutter
imageCounter =1;
for j = 1:length(imdsClutter.Files)
% j=1
clutter=imread(char(imdsClutter.Files(j)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
[r c] = size(clutter);
clutterCreator =1;
while(true)
r1 = randi([1,r]);
r2 = randi([1,r]);
c1 = randi(randi([1,c]));
c2 = randi([randi([1,c])]);

if ((abs(r2-r1)*abs(c2-c1))> 1500000)
% figure
%     imshow(clutter(min(r1,r2):max(r1,r2),min(c1,c2):max(c1,c2)))
currentClutter = clutter(min(r1,r2):max(r1,r2),min(c1,c2):max(c1,c2));
%% copy alogrithm
iterate = randi([5,length(unique(imds.Labels))+3]);
chip=[];
for i=1:iterate
    readChip=randi([1,length(imds.Files)]);
    label = {imds.Labels(readChip)};
    chip = [ label imds.Files(readChip);chip];
 end
chip;
[clutter1 list]= localHomogenity(currentClutter,chip,6);
list
% figure
% imshow(clutter1)
% pause(1)
% close all
img = cat(3,clutter1,clutter1,clutter1);
imwrite(img,['ImagesTraining\' num2str(imageCounter) '.jpg']);
% pause(0.1)
fid = fopen(['ImagesTraining\' num2str(imageCounter) '.txt'],'wt');
% dlmwrite(['Images\' num2str(imageCounter) '.txt'],list)
[lengthListr lengthListc]=size(list);
for ii = 1:lengthListr
% fwrite(fid,list)
    fprintf(fid,'%g\t',list(ii,:));
    fprintf(fid,'\n');
end
fclose(fid)
imageCounter = imageCounter+1
% pause(0.1)    
%%    
    clutterCreator = clutterCreator+1;
if clutterCreator > 35
break
end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% break
end
%% [location]=placeholder(clutter,chip1)
% chip1=imresize(imread('Dataset\ChipsConverted\BTR_60\HB03340.jpeg'),1);
% placeholder(clutter,chip1)