[row,leng]=size(video_abstract_sequenct);
videoName = 'C:\multivideoExperiment\outvideo\BSVD_abctrace.avi';%��ʾ��Ҫ��������Ƶ�ļ�������  
fps = 8; %֡��  

filePath=strcat('C:\multivideoExperiment\Newdataset\basketball\normalsize\part');
length=1000;
if(exist('videoName','file'))  
    delete videoName.avi  
end  
%������Ƶ�Ĳ����趨  
aviobj=VideoWriter(videoName);  %����һ��avi��Ƶ�ļ����󣬿�ʼʱ��Ϊ��  
aviobj.FrameRate=fps;  
  
open(aviobj);%Open file for writing video data  
%����ͼƬ  
for i=1:leng 
    partname=num2str(count(i));
    framenum=num2str(video_abstract_sequenct(2,i));    
    framepath=imread([filePath,partname,'\',framenum,'.jpg']);

    writeVideo(aviobj,framepath);  
end  
close(aviobj);% �رմ�����Ƶ  