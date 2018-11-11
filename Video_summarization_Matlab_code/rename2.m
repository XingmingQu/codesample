files = dir('C:\office\part3\*.jpg');

files=sortObj(files);
len=length(files);

num=515;
for i=1:len
    oldname=files(i).name;
    newname=strcat('n_',num2str(num),'.jpg');
    num=num+1;
    command = ['rename' 32 oldname 32 newname];
    status = dos(command);
%     if status == 0
%         disp([oldname, ' 已被重命名为 ', newname])
%     else
%         disp([oldname, ' 重命名失败!'])
%     end
end