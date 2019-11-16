clear all
close all
clc
warning off
%% read all chips
imds = imageDatastore('Dataset/ChipsConverted45',...
'IncludeSubfolders',true,'FileExtensions','.jpeg','LabelSource','foldernames')
imdsClutter = imageDatastore('SubClutters',...
'IncludeSubfolders',true,'FileExtensions','.jpeg','LabelSource','foldernames')
%% read clutter
imageCounter =1;
assignChips = 0;
for j = 1:length(imdsClutter.Files)
% j=20
clutter=imread(char(imdsClutter.Files(j)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555
[r c] = size(clutter);
clutterCreator =1;
while(true)

currentClutter = clutter;
iterate = randi([45,length(unique(imds.Labels))+45]);
chip=[];
for i=1:iterate
    readChip=randi([1,length(imds.Files)]);
    label = {imds.Labels(readChip)};
    chip = [ label imds.Files(readChip);chip];
 end
assignChips = assignChips + size(chip(:,1));
[countChips clutter1 list]= ChiDistanceWithHistNormalization(currentClutter,chip);
% list
img = cat(3,clutter1,clutter1,clutter1);
% imshow(clutter1)
% imshow(img)
imwrite(img,['Images45/' num2str(imageCounter) '.jpg']);
% pause(0.1)
fid = fopen(['Images45/' num2str(imageCounter) '.txt'],'wt');
[lengthListr lengthListc]=size(list);
for ii = 1:lengthListr
    fprintf(fid,'%g\t',list(ii,:));
    fprintf(fid,'\n');
end
fclose(fid)
imageCounter = imageCounter+1
% pause(0.1)    
%%    
    clutterCreator = clutterCreator+1;
if clutterCreator > 5
break
end
end


end
assignChips
countChips
