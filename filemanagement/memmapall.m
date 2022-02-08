function memmapall

d=dir('*.sbx');
if numel(d)>0
   memmapdir(4);
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        disp(pwd);
        cd(allfiles(i).name);memmapall; cd ..
    end
end

