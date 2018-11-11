[row,leng]=size(video_abstract_sequenct);
videoName = 'C:\multivideoExperiment\outvideo\BSVD_abctrace.avi';%表示将要创建的视频文件的名字  
fps = 8; %帧率  

filePath=strcat('C:\multivideoExperiment\Newdataset\basketball\normalsize\part');
length=1000;
if(exist('videoName','file'))  
    delete videoName.avi  
end  
%生成视频的参数设定  
aviobj=VideoWriter(videoName);  %创建一个avi视频文件对象，开始时其为空  
aviobj.FrameRate=fps;  
  
open(aviobj);%Open file for writing video data  
%读入图片  
for i=1:leng 
    partname=num2str(count(i));
    framenum=num2str(video_abstract_sequenct(2,i));    
    framepath=imread([filePath,partname,'\',framenum,'.jpg']);

    writeVideo(aviobj,framepath);  
end  
close(aviobj);% 关闭创建视频  