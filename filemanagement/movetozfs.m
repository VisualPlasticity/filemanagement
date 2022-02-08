function movetozfs

cpath=pwd;
zfs_path=strrep(cpath,'D:','\\mps-zfs\data1\idl\');
if ~exist(zfs_path)
    mkdir(zfs_path)
end

try
movefile('*eye*',zfs_path);
movefile('*memmap*',zfs_path);
catch
end


allfiles=ls;
for i=3:size(allfiles,1)
    if isdir(allfiles(i,:))
        cd(allfiles(i,:));movetozfs; cd ..
    end
end
    