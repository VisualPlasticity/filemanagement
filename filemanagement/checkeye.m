function checkeye


cpath=pwd;

d=dir('*_eye.mat');
if numel(d)>0
    try
        %[~,remains]=strtok(pwd,'A');
        remains = d(1).name(1:10);
        figure('Name',remains)
        for i=1:numel(d)
            fn=d(i).name;
            m=matfile(fn);
            subplot(ceil(numel(d)/2),2,i)
            imshow(squeeze(m.data(1:112,1:160,1,1000)),'InitialMagnification',200)
            title(fn(end-10:end-8))
        end
        %saveas(gcf, ['\\mps-zfs\data1\lebedeva\' strrep(remains,'\','_') '.png'])
    end
end

allfiles=ls;
for i=3:size(allfiles,1)
    if isdir(allfiles(i,:))
        cd(allfiles(i,:));checkeye; cd ..
    end
end

