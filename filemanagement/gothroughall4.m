function gothroughall4
warning off
tmpfile=dir('*sp*all.mat');
tmpfile2=dir('*sp*as+ms*.mat');
if numel(tmpfile)==1 && numel(tmpfile2)<1
    wkdir=pwd;
    disp(pwd);
    load(tmpfile.name,'pair0','pair1','fign');
    gd=find(pair0&pair1);
      caanalysisplot('..',gd,0);close all
%      fign=tmpfile.name(1:end-7);
%      save(tmpfile.name,'fign','-append')
%     plotTC(fign,gd);close all
    
    setpref('Internet','SMTP_Server','keck.ucsf.edu')
    setpref('Internet','E_mail','jsun@phy.ucsf.edu')
    sendmail('j.suninchina@gmail.com',['done: ' fign]);
end

allfiles=dir;
for i=3:size(allfiles,1)
    if isdir(allfiles(i).name)
        cd(allfiles(i).name);gothroughall4; cd ..
    end
end


