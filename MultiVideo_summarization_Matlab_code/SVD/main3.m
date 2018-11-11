% %程序所使用的hyper-parameter
% %滑动窗口长度
WindowL=5;
% %活动像素阈值（变化超过多少认为是活动像素）
actpix_threshold=3;
% %取前面几个最大奇异值向量
Maxsingular=6;
% %路径

% %保存数据路径
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


% %开始计算每幅图片活动像素比
% %activepix输入参数前一帧，后一帧，阈值（变化超过多少认为是活动像素）
% %最后一帧默认是0
actpix=[];
for i=1:length(image_list)-1
    actpix(i)=activepix(image_list{i},image_list{i+1},actpix_threshold);
end
actpix(length(image_list))=0;
% 
% % %计算完活动像素后可以对每张图片进行svd
% %ColorHistogram传入一幅图像，返回一个256X1向量
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

% % 得到frame_matrix后可以计算横向方向的能量了
% % 使用滑动窗口进行能量判定，每个视频帧 ----（后面窗口帧的平均-前面窗口平均）^2求和开根号（二范数）
% % 值越大能量越高
E_horizontal=[];
for j=WindowL+1:length(image_list)-WindowL
    %前平均
    front=sum(frame_matrix(:,j-WindowL:j-1),2);
    front=front/WindowL;
    %后平均
    back=sum(frame_matrix(:,j+1:j+WindowL),2);
    back/WindowL;
    
    %计算向量二范数作为能量
    energy=sqrt(sum((back-front).^2));
    E_horizontal(j)=energy;
end
% %前L帧和最后L帧默认是0
E_horizontal(length(image_list)-WindowL+1:length(image_list))=0;
eval([Esavename '=E_horizontal;']);
eval([Asavename '=actpix;']);
eval([Fsavename '=frame_matrix;']);
% % %保存重要变量
save(strcat(savePath,'E_horizontal-',name,'.mat'),Esavename);
save(strcat(savePath,'actpix-',name,'.mat'),Asavename);
save(strcat(savePath,'frame_matrix-',name,'.mat'),Fsavename);




% %并行读取多个视频
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