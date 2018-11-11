file='C:\multivideoExperiment\Newdataset\Time_12-34\';
name='part1'
filePath=strcat(file,name,'\');
image=dir(strcat(file,name,'\*.jpg'));

image=sortObj(image);

videoName = 'C:\multivideoExperiment\outvideo\TIMESVD.avi';%表示将要创建的视频文件的名字  
fps = 8; %帧率  

filePath=strcat('C:\multivideoExperiment\Newdataset\Time_12-34\part');
length=795;
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
    framenum=image(i).name;    
    framepath=imread([filePath,partname,'\',framenum]);
    framepath=imresize(framepath,[576 768],'bilinear');

    writeVideo(aviobj,framepath);  
end  
close(aviobj);% 关闭创建视频  