function gothroughall2

d=dir('*.sbx');
m = dir('*memmap.mat*');
if numel(d)>0 && numel(m)>0
   %sbxballmotiondir;caanalysisdir;
%    mkdir('old-panenski');
   movefile('*memmap.mat','old-panenski')
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        disp(pwd);
        cd(allfiles(i).name);gothroughall2; cd ..
    end
end

