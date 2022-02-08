function fnames = splitfile(fname)

[fnam,filetype] = strtok(fname,'.');

posstart=strfind(fnam,filesep);
if isempty(posstart)
    posstart=0;
end
pos=regexp(fnam,'[0-9]&[0-9]')+1;
nfiles = numel(pos)+1;
pos = [posstart(end),pos,pos(end)+pos(1)-posstart(end)];

for n=1:nfiles
    fnames{n}=[fnam(1:pos(1)) fnam([pos(n)+1:pos(n+1)-1 pos(end):end]) filetype];
end
