function folder=CAcheckstimuli(fname)
% load calcium signal and sync with the ball motion/ pupil dilation data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. load calcium signal
% 2. syn with external stimulus
% 3. syn with internal state: ball motion/ eye motion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load calcium signal and open recorded image
if nargin ==0
    [fname,p]=uigetfile('*.signals','load calcium signal data .signals');
else
    [p,fnam,ext]=fileparts(fname);
    fname=[fnam ext];
end
if ~isempty(p)
    cd(p)
end
load(fname,'-mat');
pos = strfind(strtok(fname,'c'),'_');
try
    fn = fname(1:pos(3)-1);
catch
    fn = strtok(fname,'.');
end
global info;
sbxread(fn,1,1);
movement=preprocess(fn);

global info;
if ~exist('sig','var')
    try
        sig=sig_chunk;
%         sigs=sigs_chunk;
%         sigsp=sigsp_chunk;
    catch
        sig = rtdata;
    end
end
%% cleaning data

if ~exist('sigs','var') 
sigsp = zeros(size(sig));
sigs = zeros(size(sig));
% sigML = zeros(size(sig));
sprintf('Smoothing and Deconvovling, expected %d secs',round(size(sig,2)*6))
tic
% for i=1:size(sig,2)
%     try
%     [sigs(:,i),sigsp(:,i)]=deconvolveCa(sig(:,i));
%     catch
%         sprintf('Cell%d did not processed',i);
%     end
% end
sprintf('Done Smoothing and Deconvovling, took %d secs',round(toc))
% for i=1:ncell
%     sigML(:,i)=MLspike(sig(:,i));
% end
% else
%     sigs=interp1(x,sigs,xx,'spline','extrap');
%     sigsp = interp1(x,sigsp,xx,'spline','extrap');
% end
save(fname,'sigs','sigsp','-append');
end

%%
ncell=size(sigs,2);
Cor = 1:ncell;
sig=sig(:, Cor);

nframes = info.max_idx+1;
if info.volscan == 0 & nframes/size(sig,1) < 2
    x=1:size(sig,1);
else
%     nplane = info.otparam(3);
    multiplane = str2num(fname(pos(end)-1));
    nplane = round(nframes/size(sig,1));
    x=multiplane:nplane:nframes;
end
xx=1:nframes;
%     figure;hold on;plot(x,sig(:,67),'Linewidth',2,'Color',[ 0 0 1 .7])
%     plot(xx,sig(:,67),'Color',[ 0 0 0 .7])
sig=interp1(x,sig,xx,'spline','extrap');
sigs=interp1(x,sigs,xx,'spline','extrap');
sigsp = interp1(x,sigsp,xx,'spline','extrap');

%% sync movement with stimulus data and plot
CAframeHz =info.resfreq/info.recordsPerBuffer;
if movement
    load([fn '_ball.mat'],'ball','time');
    speed=abs(ball(1:end-1))/192*2./diff(time)'; %size of the imaging area 192pixel, 2cm
    sp=conv(speed,ones(1,ceil(CAframeHz*3))/ceil(CAframeHz*3),'same'); %conv the speed into with a 1s filter
    if numel(sp) > nframes
        velocity=downsample(sp,2);
    else
        velocity=sp;
    end
else
    velocity=[];
end

if size(velocity,2)> nframes
    velocity(nframes+1:end)=[];
end
%% Correct stimtype obtained with closeloop
info.stimtypeorg=info.stimtype;
grey = max(info.stimtype);
blank = 0;
if sum(info.stimtype ==grey)>= numel(info.stimtype)/2-1 % this means blank is counted as grey
    % if a stimtype is grey but the one before is different, then it's actually
        % a blank
        info.stimtype([0;diff(info.stimtype)]~=0 &info.stimtype ==grey)=blank;
    while sum(info.stimtype(diff(info.stimtype)==0) ==grey) >=1 %two greys in a row
        % if a grey stimtype is considered blank if: the one before is also grey, but the one 2 frames before is blank
        info.stimtype([1;1;info.stimtype(1:end-2)]==0& [1;info.stimtype(1:end-1)==grey] & info.stimtype ==grey)=blank;
    end
        hh=figure('Position',[200 600 600 800]);
        subplot(3,1,1);hold on;
        plot(info.stimtypeorg,'o-');
        plot(info.stimtype,'x-');
        title(sprintf('Stimtype correction for closeloop experiment:%s',fn))
        xlim([numel(info.stimtype)-100 numel(info.stimtype)])
end
%% sync stimulus with data  
prestim=floor(CAframeHz*1); %use 1s baseline
%stimON=prctile(diff(info.frame),80); % StimON duration
if median(diff(info.frame))>prestim %StimON duration based on closeloop or regular type
    stimON_each = info.frame(2:end)-info.frame(1:(end-1));
    seg_each = prestim+info.frame(3:2:end)-info.frame(1:2:(end-2)); % segment=prestim+info.frame(TTL ON+TTL off )

else
    stimON_each = info.frame(3:2:end)-info.frame(1:2:(end-2)); % StimON duration
    seg_each = prestim+info.frame(5:4:end)-info.frame(1:4:(end-4)); % segment=prestim+info.frame(TTL ON+TTL off )
end
subplot(3,1,2);hold on;
histogram(stimON_each);histogram(seg_each);
legend('stimONduration','eachTrialduration')
stimON = floor(median(stimON_each));
seg = floor(median(seg_each));
Var=numel(unique(info.stimtype(info.stimtype>0)));% excluding blankstim(o) and calculate types of stimulus, orientations, contrast, etc
%rep=floor(min(2*numel(info.stimtype),numel(info.frame))/2/Var); %calculate repetitions
subplot(3,1,3);hold on;
m=histogram(info.stimtype,1:Var+1);
rep = min(m.Values);
% saveas(gcf,[fn '.png'])
