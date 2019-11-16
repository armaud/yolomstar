clc
close all
clear all

image = (imread('Dataset/ChipsConverted/2S1/HB14931.jpeg'));
figure
imshow(image)

%% lowpass and highpass filter section

% filt = 1/9*[1 1 1 ; 1 1 1; 1 1 1];
% lowPassImage = imfilter(image,filt);
% lowpassImage=lowPassImage/max(max(lowPassImage))*255;
% highPassImage = image-lowPassImage;
% figure
% subplot(1,3,1),imshow(image),subplot(1,3,2),imshow(lowPassImage),subplot(1,3,3),imshow(highPassImage)
% 
% imwrite(image,'/home/sabih/Desktop/Thesis/writeup/Images/lowpassimage11.jpeg')
% imwrite(lowPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/lowpassimage22.jpeg')
% imwrite(highPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/lowpassimage33.jpeg')
% 
% filt = 1/36*[1 1 1 1 1 1 ; 1 1 1 1 1 1; 1 1 1 1 1 1];
% lowPassImage = imfilter(image,filt);
% lowpassImage=lowPassImage/max(max(lowPassImage))*255;
% highPassImage = image-lowPassImage;
% figure
% subplot(1,3,1),imshow(image),subplot(1,3,2),imshow(lowPassImage),subplot(1,3,3),imshow(highPassImage)
% imwrite(image,'/home/sabih/Desktop/Thesis/writeup/Images/lowpassimage44.jpeg')
% imwrite(lowPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/lowpassimage55.jpeg')
% imwrite(highPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/lowpassimage66.jpeg')

%%% gaussian filter

% lowPassImage = medfilt2(image,[2 2]);
% lowpassImage=lowPassImage/max(max(lowPassImage))*255;
% highPassImage = image-lowPassImage;
% figure
% subplot(1,3,1),imshow(image),subplot(1,3,2),imshow(lowPassImage),subplot(1,3,3),imshow(highPassImage)
% 
% imwrite(image,'/home/sabih/Desktop/Thesis/writeup/Images/medfilt1.jpeg')
% imwrite(lowPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/medfilt2.jpeg')
% imwrite(highPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/medfilt3.jpeg')
% 
% lowPassImage = medfilt2(image,[5 5]);
% lowpassImage=lowPassImage/max(max(lowPassImage))*255;
% highPassImage = image-lowPassImage;
% figure
% subplot(1,3,1),imshow(image),subplot(1,3,2),imshow(lowPassImage),subplot(1,3,3),imshow(highPassImage)
% imwrite(image,'/home/sabih/Desktop/Thesis/writeup/Images/medfilt4.jpeg')
% imwrite(lowPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/medfilt5.jpeg')
% imwrite(highPassImage,'/home/sabih/Desktop/Thesis/writeup/Images/medfilt6.jpeg')
% 
% figure
% % [cA,cH,cV,cD] = dwt2(X,'sym4');
% [cA,cH,cV,cD] = dwt2(image,'haar','mode','per');
% 
% subplot(1,4,1)
% imshow(uint8((cA/max(max(cA)))*255))
% subplot(1,4,2)
% imshow(uint8((cH/max(max(cH)))*255))
% subplot(1,4,3)
% imshow(uint8((cV/max(max(cV)))*255))
% subplot(1,4,4)
% imshow(uint8((cD/max(max(cD)))*255))
% imwrite(uint8((cA/max(max(cA)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/haar1.jpeg')
% imwrite(uint8((cA/max(max(cH)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/haar2.jpeg')
% imwrite(uint8((cA/max(max(cV)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/haar3.jpeg')
% imwrite(uint8((cA/max(max(cH)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/haar4.jpeg')
% figure
% [cA,cH,cV,cD] = dwt2(image,'db2','mode','per');
% 
% subplot(1,4,1)
% imshow(uint8((cA/max(max(cA)))*255))
% subplot(1,4,2)
% imshow(uint8((cH/max(max(cH)))*255))
% subplot(1,4,3)
% imshow(uint8((cV/max(max(cV)))*255))
% subplot(1,4,4)
% imshow(uint8((cD/max(max(cD)))*255))
% imwrite(uint8((cA/max(max(cA)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/db1.jpeg')
% imwrite(uint8((cA/max(max(cH)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/db2.jpeg')
% imwrite(uint8((cA/max(max(cV)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/db3.jpeg')
% imwrite(uint8((cA/max(max(cH)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/db4.jpeg')
% figure
% [cA,cH,cV,cD] = dwt2(image,'sym2','mode','per');
% 
% subplot(1,4,1)
% imshow(uint8((cA/max(max(cA)))*255))
% subplot(1,4,2)
% imshow(uint8((cH/max(max(cH)))*255))
% subplot(1,4,3)
% imshow(uint8((cV/max(max(cV)))*255))
% subplot(1,4,4)
% imshow(uint8((cD/max(max(cD)))*255))
% imwrite(uint8((cA/max(max(cA)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/sym1.jpeg')
% imwrite(uint8((cA/max(max(cH)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/sym2.jpeg')
% imwrite(uint8((cA/max(max(cV)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/sym3.jpeg')
% imwrite(uint8((cA/max(max(cH)))*255),'/home/sabih/Desktop/Thesis/writeup/Images/sym4.jpeg')