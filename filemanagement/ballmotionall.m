function ballmotionall

d=dir('*.sbx');
if numel(d)>0
   sbxballmotiondir;
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        disp(pwd);
        cd(allfiles(i).name);ballmotionall; cd ..
    end
end

