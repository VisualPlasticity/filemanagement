function renamefile(str1,str2)
% f=dir('*_Day1.xml');
f=dir(['*' str1 '*']);

for i=1:numel(f)
    fn=f(i).name;
    newfn = strrep(fn,str1,str2);
    if ~strcmp(fn,newfn)
        fprintf('%s \n to %s\n',fn,newfn);
    end
end

x = input('ready to rename? Y/N : ','s');
if strcmp(x,'Y')
    
    for i=1:numel(f)
        fn=f(i).name;
        newfn = strrep(fn,str1,str2);
        if ~strcmp(fn,newfn)
            movefile(fn,newfn);
        end
    end
end