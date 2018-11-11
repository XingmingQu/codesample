file='C:\multivideoExperiment\Newdataset\Time_12-34\';
name='part1'
filePath=strcat(file,name,'\');
image=dir(strcat(file,name,'\*.jpg'));

image=sortObj(image);

videoName = 'C:\multivideoExperiment\outvideo\TIMESVD.avi';%��ʾ��Ҫ��������Ƶ�ļ�������  
fps = 8; %֡��  

filePath=strcat('C:\multivideoExperiment\Newdataset\Time_12-34\part');
length=795;
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
    framenum=image(i).name;    
    framepath=imread([filePath,partname,'\',framenum]);
    framepath=imresize(framepath,[576 768],'bilinear');

    writeVideo(aviobj,framepath);  
end  
close(aviobj);% �رմ�����Ƶ  