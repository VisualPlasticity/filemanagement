function copytoD

zpath=pwd;
D_path=strrep(zpath,'Z:\','D:\Dropbox\');
if ~exist(D_path)
    mkdir(D_path)
end


allfiles=dir('*.*');
for i=3:size(allfiles,1)
    if isfolder(allfiles(i).name)
        cd(allfiles(i).name);
        copytoD; 
        cd ..
    elseif ~strcmp(allfiles(i).name(end-3:end),'.bin') && ~strcmp(allfiles(i).name(end-3:end),'.tif')
        copyfile(allfiles(i).name,D_path);
        fprintf('copy %s to %s\n',allfiles(i).name,D_path)
    end
end
    