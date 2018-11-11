
videoName = 'C:\multivideoExperiment\outvideo\Weight2L2basketball.avi';%��ʾ��Ҫ��������Ƶ�ļ�������  
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

EnergyMatrix=L2S;
[hE, wE]=size(EnergyMatrix);
[hc, wc]=size(C);
EE=[];
for i=1:hc %��ÿһ��cilp
    %����������һ��
    Erow=[];
    %�Ȱ�cilp�ҳ���
    CilpE=EnergyMatrix(:,C(i,1):C(i,2));
    for j=1:hE
        Erow(j,1)=j;
        Erow(j,2)=sum (CilpE(j,:) );%��ÿ��E�ĺ�
    end
    Erow=sortrows(Erow,-2);%�ҵ�����
%     EE=[EE Erow];
    C(i,4)=Erow(1,1);
end 
%C��1 2 �д����cilp��ʼ�ͽ��� 4������������

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
close(aviobj);% �رմ�����Ƶ  