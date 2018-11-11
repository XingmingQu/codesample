% %������ʹ�õ�hyper-parameter
% %�������ڳ���
WindowL=5;
% %�������ֵ���仯����������Ϊ�ǻ���أ�
actpix_threshold=3;
% %ȡǰ�漸���������ֵ����
Maxsingular=6;
% %·��

% %��������·��
savePath='C:\multivideoExperiment\SVDvar\';
name='part3';
Esavename=strcat('E_horizontal',name);
Asavename=strcat('actpix',name);
Fsavename=strcat('frame_matrix',name);
filePath=strcat('C:\multivideoExperiment\dataset\',name,'\');
image=dir(strcat('C:\multivideoExperiment\dataset\',name,'\*.jpg'));
image_len=length(image);


image_list={};

for i =1:image_len
    A=rgb2gray( imread(strcat(filePath,num2str(i),'.jpg')));
    B = imresize(A,0.5,'bilinear');
    image_list{i}=B;
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




% %���ж�ȡ�����Ƶ
% parfor i =1:folder_len
%     disp(strcat('Reading ',folder(i).name))
%     a=folder(i).name;
%     b=dir(strcat('C:\multivideoExperiment\dataset\',folder(i).name,'\*.jpg'));
% %     eval([a '=i;'])
% 
% %     b=dir(strcat('C:\multivideoExperiment\dataset\',folder(i).name,'\*.jpg'))
% 
%     image_len=length(image);
% %     image=sortObj(image);
% end