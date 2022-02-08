function fname = combinefilename(fnamelist)

nfiles = size(fnamelist,1);
for n=1:nfiles
    [~,tifname,~] = fileparts(fnamelist(n,:));
    pos_=strfind(tifname,'_');
    if n==1 
        oldtifname=tifname;
        fname = [tifname(1:pos_(3)-1)];
    elseif ~strcmp(oldtifname(1:pos_(3)-1), tifname(1:pos_(3)-1))
        oldtifname=tifname;
        fname = [fname '&' tifname(1:pos_(3)-1)];
    end
end
