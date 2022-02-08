function alignall

d=dir('*.sbx');
if numel(d)>0
   sbxalignnplanedir(1);
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        disp(pwd);
        cd(allfiles(i).name);alignall; cd ..
    end
end

