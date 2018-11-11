% %������ʹ�õ�hyper-parameter
% %�������ڳ���
WindowL=9;
% %�������ֵ���仯����������Ϊ�ǻ���أ�
actpix_threshold=3;
% %ȡǰ�漸���������ֵ����
Maxsingular=6;
% %·��

for k =1:4
% %��������·��
savePath='C:\multivideoExperiment\Newdataset\Cilp2S_basketball_SVD_var\';
name=strcat('part',num2str(k));
Esavename=strcat('E_horizontal',name);
Asavename=strcat('actpix',name);
Fsavename=strcat('frame_matrix',name);
file='C:\multivideoExperiment\Newdataset\basketball\';
filePath=strcat(file,name,'\');
image=dir(strcat(file,name,'\*.jpg'));
image_len=length(image);
image=sortObj(image);

image_list={};

for i =1:image_len
%     A=rgb2gray( imread(strcat(filePath,image(i).name)));
%     B = imresize(A,[120 160],'bilinear');
%     image_list{i}=B;
    
    A=rgb2gray( imread(strcat(filePath,image(i).name)));
    image_list{i}=A;
    
end


% %��ʼ����ÿ��ͼƬ����ر�
% %activepix�������ǰһ֡����һ֡����ֵ���仯����������Ϊ�ǻ���أ�
% %���һ֡Ĭ����0
actpix=[];
for i=1:length(image_list)-1
    actpix(i)=activepix(image_list{i},image_list{i+1},actpix_threshold);
end
actpix(length(image_list))=0;
% 
% % %���������غ���Զ�ÿ��ͼƬ����svd
% %ColorHistogram����һ��ͼ�񣬷���һ��256X1����
frame_matrix=[];
for i=1:length(image_list)
    [S,V,D]=svd(double(image_list{i}));
    S=S(:,1:Maxsingular);
    V=[];
    for j=1:Maxsingular
        V=[V;S(:,j)];
    end
    frame_matrix=[frame_matrix V];
end

% % �õ�frame_matrix����Լ���������������
% % ʹ�û������ڽ��������ж���ÿ����Ƶ֡ ----�����洰��֡��ƽ��-ǰ�洰��ƽ����^2��Ϳ����ţ���������
% % ֵԽ������Խ��
E_horizontal=[];
for j=WindowL+1:length(image_list)-WindowL
    %ǰƽ��
    front=sum(frame_matrix(:,j-WindowL:j-1),2);
    front=front/WindowL;
    %��ƽ��
    back=sum(frame_matrix(:,j+1:j+WindowL),2);
    back/WindowL;
    
    %����������������Ϊ����
    energy=sqrt(sum((back-front).^2));
    E_horizontal(j)=energy;
end
% %ǰL֡�����L֡Ĭ����0
E_horizontal(length(image_list)-WindowL+1:length(image_list))=0;
eval([Esavename '=E_horizontal;']);
eval([Asavename '=actpix;']);
eval([Fsavename '=frame_matrix;']);
% % %������Ҫ����
save(strcat(savePath,'E_horizontal-',name,'.mat'),Esavename);
save(strcat(savePath,'actpix-',name,'.mat'),Asavename);
save(strcat(savePath,'frame_matrix-',name,'.mat'),Fsavename);

end
% 

