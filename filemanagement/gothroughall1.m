function gothroughall1

d=dir('*cellca*');
if numel(d)>0 && contains(d(1).folder,'_sp')
renamefiles;
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        disp(pwd);
        cd(allfiles(i).name);gothroughall1; cd ..
    end
end

