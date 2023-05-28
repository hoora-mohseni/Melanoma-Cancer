
%% Computer aided Melanoma skin cancer detection using Image Processing

clc; 
clear; 
close all;


% Input Image of Skin Lesion
n=1; im=single(imread(['melanoma/',num2str(n),'.jpg'])); im=im./max(im(:));
imhsi=rgb2hsv(im); intensity=imhsi(:,:,3); in=zeros(size(intensity));

% Arithmetic mean filter on the intensity image
for i=1:size(intensity,1)
    for j=1:size(intensity,2)
        window=windowselection(intensity,15,i,j);
        in(i,j)=mean(window(:));
    end
end

imhsi(:,:,3)=in; im2=hsv2rgb(imhsi);
% Color segmentation
skin=mean([mean(im2(1,:,:)),mean(im2(end,:,:)),mean(im2(:,1,:)),mean(im2(:,end,:))]);

d=0; 
for j=1:3; d=d+(im2(:,:,j)-skin(j)).^2; end
R0=.25; % input('Desirable R0 for color segmentation (0 - 1) = ');
mask=zeros(size(im,1),size(im,2)); mask(:,:)=1-single(d<R0^2);
% Lesion connected component
X0=zeros(size(mask)); X1=zeros(size(mask)); X0(round(end/2),round(end/2))=1;
while 1; X1=min(imdilate(X0,ones(3)),mask); if X1==X0; break; end; X0=X1; end
% Morphological operations
se=strel('disk',10,0); mask2=X1; mask3=imclose(mask2,se);
% Border extraction
border=zeros(size(im)); border(:,:,3)=mask3-imerode(mask3,se);
imseg2=im+border; imseg2(imseg2>1)=1; imseg=mask2.*im;
% Feature extraction
if sum(mask2(:))>0
stats=regionprops(mask2,'MajorAxisLength','MinorAxisLength','Perimeter','FilledImage');
perimeter=stats.Perimeter; area=sum(mask(:)); GD=stats.MajorAxisLength; SD=stats.MinorAxisLength;
Features.Asymmetry(n)=1-sum(sum(stats.FilledImage.*fliplr(stats.FilledImage)))/area; Features.Circularity(n)=4*area*pi/perimeter^2;
Features.IrA(n)=perimeter/area; Features.IrB(n)=perimeter/GD; Features.IrC(n)=perimeter*(1/SD-1/GD);
% Imshow
figure; subplot(231); imshow(im); subplot(232); imshow(in); subplot(233); imshow(mask);
subplot(234); imshow(mask2); subplot(235); imshow(imseg2); subplot(236); imshow(imseg);
% Save Output Images
imwrite(imseg2,[num2str(n),'_N1.jpg']); imwrite(imseg,[num2str(n),'_N2.jpg']);
% Save Features
save('Features.mat','Features');
end