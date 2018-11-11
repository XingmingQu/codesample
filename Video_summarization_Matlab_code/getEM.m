function [ Final_Energy_Matrix ] = getEM( WindowL,file ,partNum)
% %������ʹ�õ�hyper-parameter
% %�������ڳ���
% file='C:\office\';
% WindowL=10;
% %�������ֵ���仯����������Ϊ�ǻ���أ�
actpix_threshold=3;
% %ȡǰ�漸���������ֵ����
Maxsingular=6;
% %·��
EH=[];
VectorMatrix={};
ACT=[];

for k =1:partNum
    k
% %��������·��
% savePath='C:\multivideoExperiment\Newdataset\Cilp2S_basketball_SVD_var\';
name=strcat('part',num2str(k));
% Esavename=strcat('E_horizontal',name);
% Asavename=strcat('actpix',name);
% Fsavename=strcat('frame_matrix',name);
filePath=strcat(file,name,'\');
image=dir(strcat(file,name,'\*.jpg'));
image_len=length(image);
image=sortObj(image);

image_list={};

for i =1:image_len
    A=rgb2gray( imread(strcat(filePath,image(i).name)));
    B = imresize(A,[120 160],'bilinear');
    image_list{i}=B;
    
%     A=rgb2gray( imread(strcat(filePath,image(i).name)));
%     image_list{i}=A;
    
end


% %��ʼ����ÿ��ͼƬ����ر�
% %activepix�������ǰһ֡����һ֡����ֵ���仯����������Ϊ�ǻ���أ�
% %���һ֡Ĭ����0
actpix=[];
for i=1:length(image_list)-1
    actpix(i)=activepix(image_list{i},image_list{i+1},actpix_threshold);
end
actpix(length(image_list))=0;

ACT=[ACT ;actpix];

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
VectorMatrix{k}=frame_matrix;
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

EH=[EH;E_horizontal];

% % % 
% % % eval([Esavename '=E_horizontal;']);
% % % eval([Asavename '=actpix;']);
% % % eval([Fsavename '=frame_matrix;']);
% % % % % %������Ҫ����
% % % % save(strcat(savePath,'E_horizontal-',name,'.mat'),Esavename);
% % % % save(strcat(savePath,'actpix-',name,'.mat'),Asavename);
% % % % save(strcat(savePath,'frame_matrix-',name,'.mat'),Fsavename);
end
% 
N=length(VectorMatrix);
[h w]=size( VectorMatrix{1});
V_mean=zeros(h,w);
for i=1:N
    V_mean=V_mean+VectorMatrix{i};
end
V_mean=V_mean/N;

EV=[];
for i=1:N
    part=VectorMatrix{i};
    ev=[];
    for j=1:w        
        ev(j)=sqrt(sum( (part(:,j)-V_mean(:,j)).^2 ));
    end
    EV=[EV;ev];
end

sumEH=sum(sum(EH));
sumEV=sum(sum(EV));
ratio=sumEH/sumEV;
ratio=ratio*2;
Energy_Matrix=EH+ (ratio*EV);
sumEM=sum(sum(Energy_Matrix));
sumACT=sum(sum(ACT));
ratio2=sumEM/sumACT;

cofficientACT=ACT*ratio2;

Final_Energy_Matrix=Energy_Matrix+cofficientACT;
end
