
videoName = 'C:\multivideoExperiment\outvideo\L25basketball.avi';%表示将要创建的视频文件的名字  
fps = 9; %帧率  

filePath=strcat('C:\multivideoExperiment\Newdataset\basketball\normalsize\part');
length=1200;
if(exist('videoName','file'))  
    delete videoName.avi  
end  
%生成视频的参数设定  
aviobj=VideoWriter(videoName);  %创建一个avi视频文件对象，开始时其为空  
aviobj.FrameRate=fps;  
  
open(aviobj);%Open file for writing video data  
%读入图片  
for i=1:length 
    partname=num2str(count(i));
    framenum=num2str(i);    
    framepath=imread([filePath,partname,'\',framenum,'.jpg']);

    writeVideo(aviobj,framepath);  
end  
close(aviobj);% 关闭创建视频  