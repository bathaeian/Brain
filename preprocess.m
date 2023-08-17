addpath D:\student\research\spm\spm12
spm fmri

files = dir('wr*.nii');
numFiles = numel(files);
for i = 1:numFiles
  if ismember(r,UNI)
        continue
  end
    UNI = [UNI; r];
end
