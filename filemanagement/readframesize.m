function eachsize = readframesize(fnames)

eachsize =[];
for ii=1:numel(fnames)
    pos_=strfind(fnames{ii},'_');
    sbxread(fnames{ii}(1:pos_(3)-1),0,1);
    global info;
    eachsize = [eachsize, info.max_idx+1];
end

