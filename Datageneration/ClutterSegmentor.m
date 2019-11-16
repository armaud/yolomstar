clc
close all
clear all

%% read directory for images
dirList = dir('Dataset/ClutterConverted')
imageCounter = 0;
reset = 1;
image = [];
for i=3:length(dirList)
    clutter = imread(char(string(['Dataset/ClutterConverted/' dirList(i).name])));
    [r c] = size(clutter)
    if reset == 1
        image = clutter(1:ceil(r/2),1:ceil(c/2));
        reset = reset + 1;
        imageCounter=imageCounter + 1;
%         img = cat(3,image,image,image);
        imwrite(image,char(string(['SubClutters/' num2str(imageCounter) '.jpeg'])));
    end
    if reset == 2
        image = clutter(floor(r/2):end,1:ceil(c/2));
        reset = reset + 1;
        imageCounter=imageCounter + 1;
%         img = cat(3,image,image,image);
        imwrite(image,char(string(['SubClutters/' num2str(imageCounter) '.jpeg'])));
    end
    if reset == 3
        image = clutter(1:ceil(r/2),floor(c/2):end);
        reset = reset + 1;
        imageCounter=imageCounter + 1;
%         img = cat(3,image,image,image);
        imwrite(image,char(string(['SubClutters/' num2str(imageCounter) '.jpeg'])));
    end
    if reset == 4
        image = clutter(floor(r/2):end,floor(c/2):end);
        reset = 1;
        imageCounter=imageCounter + 1; 
%         img = cat(3,image,image,image);
        imwrite(image,char(string(['SubClutters/' num2str(imageCounter) '.jpeg'])));
    end
    
    imageCounter
end