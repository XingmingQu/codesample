
videoName = 'C:\multivideoExperiment\outvideo\L25basketball.avi';%��ʾ��Ҫ��������Ƶ�ļ�������  
fps = 9; %֡��  

filePath=strcat('C:\multivideoExperiment\Newdataset\basketball\normalsize\part');
length=1200;
if(exist('videoName','file'))  
    delete videoName.avi  
end  
%������Ƶ�Ĳ����趨  
aviobj=VideoWriter(videoName);  %����һ��avi��Ƶ�ļ����󣬿�ʼʱ��Ϊ��  
aviobj.FrameRate=fps;  
  
open(aviobj);%Open file for writing video data  
%����ͼƬ  
for i=1:length 
    partname=num2str(count(i));
    framenum=num2str(i);    
    framepath=imread([filePath,partname,'\',framenum,'.jpg']);

    writeVideo(aviobj,framepath);  
end  
close(aviobj);% �رմ�����Ƶ  