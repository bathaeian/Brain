lData= size(COBREphenotypicdata,1);
for i=1:lData
subj2=char(strcat('00' ,string(table2cell(COBREphenotypicdata(i,1))))) ;
rest_fn = [subj2 filesep 'session_1' filesep 'rest_1' filesep 'rest.nii.gz'];
file_rest = gunzip(rest_fn);
if char(string(table2cell(COBREphenotypicdata(i,5))))=='Control' 
dest=['Control' filesep subj2 '.nii']
else 
 dest=['Patient' filesp subj2 '.nii']
end;
movefile(file_rest{1},dest)
end;
