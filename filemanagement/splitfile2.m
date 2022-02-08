function fnames = splitfile2(fname)
[fnam,filetype] = strtok(fname,'.');

posstart=strfind(fnam,filesep);
if isempty(posstart)
    posstart=0;
end
pos=strfind(fnam,'&');
nfiles = numel(pos)+1;
pos = [posstart(end),pos,pos(end)+pos(1)-posstart(end)];

for n=1:nfiles
    fnames{n}=[fnam([pos(n)+1:pos(n+1)-1 pos(end):end]) filetype];
end
