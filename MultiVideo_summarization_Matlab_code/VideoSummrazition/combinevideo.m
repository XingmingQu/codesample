
videoName = 'C:\multivideoExperiment\outvideo\Weight2L2basketball.avi';%表示将要创建的视频文件的名字  
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

EnergyMatrix=L2S;
[hE, wE]=size(EnergyMatrix);
[hc, wc]=size(C);
EE=[];
for i=1:hc %对每一个cilp
    %找能量最大的一行
    Erow=[];
    %先把cilp找出来
    CilpE=EnergyMatrix(:,C(i,1):C(i,2));
    for j=1:hE
        Erow(j,1)=j;
        Erow(j,2)=sum (CilpE(j,:) );%求每行E的和
    end
    Erow=sortrows(Erow,-2);%找到最大的
%     EE=[EE Erow];
    C(i,4)=Erow(1,1);
end 
%C的1 2 列存的是cilp开始和结束 4存的是摄像机号

for i=1:hc
    for j=C(i,1):C(i,2)
        framenum=num2str(j);
        partname=num2str(C(i,4));
        framepath=imread([filePath,partname,'\',framenum,'.jpg']);
        writeVideo(aviobj,framepath);  
    end
end

% 
% for i=1:length 
%     partname=num2str(count(i));
%     framenum=num2str(i);    
%     framepath=imread([filePath,partname,'\',framenum,'.jpg']);
% 
%     writeVideo(aviobj,framepath);  
% end  
close(aviobj);% 关闭创建视频  