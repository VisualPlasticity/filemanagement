function [fname,eachsize] = combinefiles(fnamelist,nthplane,nplanes)

nfiles = size(fnamelist,1);
for n=1:nfiles
    [~,tifname,~] = fileparts(fnamelist(n,:));
    pos_=strfind(tifname,'_');
    if n==1 
        oldtifname=tifname;
        fname = [tifname(1:pos_(3)) nthplane];
        info=imfinfo(strrep(fnamelist(n,:),' ',''));
        eachsize = numel(info)/nplanes;
    elseif ~strcmp(oldtifname(1:pos_(3)), tifname(1:pos_(3)))
        oldtifname=tifname;
        fname = [fname '&' tifname(1:pos_(3)) nthplane];
        info=imfinfo(strrep(fnamelist(n,:),' ',''));
        eachsize = [eachsize,numel(info)/nplanes];
    else
        info=imfinfo(strrep(fnamelist(n,:),' ',''));
        eachsize(end) = eachsize(end)+numel(info)/nplanes;       
    end
end
