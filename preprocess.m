addpath D:\student\research\spm\spm12
spm fmri
p='E:\COBRE\Control\';
files = dir([p 'wr*.nii']);
numFiles = numel(files);
for i = 1:numFiles
  r=[p files(i).name];
  if ismember(r,matlabbatch{1,1}.spm.spatial.smooth.data)
        continue
  end
    matlabbatch{1,1}.spm.spatial.smooth.data = [matlabbatch{1,1}.spm.spatial.smooth.data; r];
end
