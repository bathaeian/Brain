addpath D:\student\research\nifti\elayden-NIfTI-Studio-7f46b61
nifti_studio;
p1='E:\COBRE\Control\';
p2='E:\COBRE\AllData\10\Control\';
files = dir([p1 'swr*.nii']);
numFiles = numel(files);
numVol=150;
scanno=10;
for i = 1:numFiles
  S = load_untouch_nii([p1 files(i).name]);
  A = S.img;
  newImg3=[];
  k=1;
  for j=1:4:numVol
    newImg3(:,:,k)= A(:,:,scanno,j);
    k=k+1;
  end  ;
  newF= strrep(files(i).name,'.nii','.mat'); 
  save([p2 newF],"newImg3");
end;


files = dir([p2 'swr*.mat']);
load([p2 files(1).name], 'newImg3');
figure(1) 

filename = 'FMRI_GIF.gif'; 
NumV=size(newImg3,3);
for k = 1:NumV imshow(newImg3(:,:,k),[]) 
drawnow 
frame = getframe(1); 
im = frame2im(frame); 
[imind,cm] = rgb2ind(im,256); 
if k == 1; 
imwrite(imind,cm,filename,'gif', 'Loopcount',inf); else imwrite(imind,cm,filename,'gif','WriteMode','append'); 
end 
pause(.1) 
end

p1='E:\COBRE\Patient\';
p2='E:\COBRE\AllData\10\Patient\';
files = dir([p1 'swr*.nii']);
numFiles = numel(files);
numVol=150/2;
scanno=10;
for i = 1:numFiles
  S = load_untouch_nii([p1 files(i).name]);
  A = S.img;
  newImg3=[];
  k=1;
  for j=1:2:numVol
    newImg3(:,:,k)= A(:,:,scanno,j);
    k=k+1;
  end  ;
  newF= strrep(files(i).name,'.nii','.mat'); 
  save([p2 newF],"newImg3");
end;

