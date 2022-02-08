function copyfromzfs

zfs_path=pwd;
%cpath=strrep(zfs_path,'\\mps-zfs\data\jsun','C:');
cpath=strrep(zfs_path,'\\mps-zfs\data1\idl','C:');

if ~exist(cpath)
    mkdir(cpath)
end

try
%copyfile('*cell_tau*',cpath);
movefile('*ball*',cpath);
end

allfiles=ls;
for i=3:size(allfiles,1)
    if isdir(allfiles(i,:))
        cd(allfiles(i,:));copyfromzfs; cd ..
    end
end
    