addpath D:\student\research\nifti\elayden-NIfTI-Studio-7f46b61

p1='E:\COBRE\Control\';
p2='E:\COBRE\AllData\10\Control\';
files = dir([p1 'swr*.nii']);
numFiles = numel(files);
numVol=150;
scanno=10;
for i = 1:numFiles
  S = load_untouch_nii(files(i));
  A = S.img;
  newImg3=[];
  k=1;
  for j=1:4:numVol
    newImg(:,:,k)= A(:,:,scanno,j);
    k++;
  end  ;
end;