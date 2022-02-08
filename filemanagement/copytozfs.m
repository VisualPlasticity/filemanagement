function movetozfs

dpath=pwd;
zfs_path=strrep(dpath,'D:','\\mps-zfs\data1\idl');
if ~exist(zfs_path)
    mkdir(zfs_path)
end

try
copyfile('*',zfs_path);
catch
end


allfiles=ls;
for i=3:size(allfiles,1)
    if isdir(allfiles(i,:))
        cd(allfiles(i,:));movetozfs; cd ..
    end
end
    