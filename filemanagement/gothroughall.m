function gothroughall

d=dir('suite2p');
if numel(d)>0
   %sbxballmotiondir;caanalysisdir;
   %delete('*cell.*')
   printcells2;caanalysisdir;
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        disp(pwd);
        cd(allfiles(i).name);gothroughall; cd ..
    end
end

