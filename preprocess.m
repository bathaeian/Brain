addpath D:\student\research\spm\spm12
spm fmri
p='E:\COBRE\Control\';
files = dir([p 'wr*.nii']);
numFiles = numel(files);
numVol=150;
for i = 1:numFiles
  for j=1:numVol
    r=[p files(i).name ',' int2str(j)];
    if ~(ismember(r,matlabbatch{1,1}.spm.spatial.smooth.data))
        matlabbatch{1,1}.spm.spatial.smooth.data = [matlabbatch{1,1}.spm.spatial.smooth.data; r];
    end;
  end  ;
end;
