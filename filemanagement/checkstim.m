function checkstim


cpath=pwd;
[main,remains]=strtok(pwd,'A');
files=dir('*.signals');
for i=1:numel(files)
    fn=files(i).name;
    try
        if ~contains(fn,'&')
            CAcheckstimuli(fn);
        end
        saveas(gcf, [main 'checkstim\' strrep(remains,'\','_') strtok(fn,'.') '.png'])
        close(gcf);
    end
end


allfiles=ls;
for i=3:size(allfiles,1)
    if isdir(allfiles(i,:))
        cd(allfiles(i,:));checkstim; cd ..
    end
end

