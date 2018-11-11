function [ Cilp ] = findHighestCilpGroup( Matrix, WinL)
% Matrix=L2S;
[h,w]=size(Matrix);
% WinL=18;
stride=WinL/2;

Cilp=[];

%对视频划分cilp并且求出每个cilp能量
for j=1:ceil(w/stride)
    index=j*stride-(stride-1);
 
    if index+WinL>w
    break
    end
    
    %计算当前cilpgroup总能量
    CurrentcilpGroupE=sum(  sum(  Matrix(1:h,index:index+WinL-1)  )   );
    %求平均
    CurrentcilpGroupE=CurrentcilpGroupE/  ( h* WinL );
    Currentcilp=[index index+WinL-1 CurrentcilpGroupE];
    %Cilp存的是 1左区间 2右区间 3平均能量
    Cilp=[Cilp;Currentcilp ];
end
Cilp=sortrows(Cilp,-3);

end







% 
% 
% afterflit=[];
% for i=1:h
%     re=filtergetmax(M(i,:),WinL);
%     afterflit=[afterflit;re];
% 
% end
% 
% Final=[];
% for j=1:ceil(w/WinL)
%     index=j*WinL-(WinL-1);
%     
%     if index+WinL>w
%         Maxnum=max(max(afterflit(:,index:w)));
%         Inwindow=afterflit(:,index:w);
%         re=~(Inwindow<Maxnum);
%         re=re.*Inwindow;
%         Final=[Final re];
% 
%         break
%     end
%     Inwindow=afterflit(:,index:index+WinL-1);
%     Maxnum=max(max(Inwindow));
%     re=~(Inwindow<Maxnum);
%     re=re.*Inwindow;
%     Final=[Final re];
% 
% end
% % figure
% % waterfall(afterflit)
% %  
% figure
% waterfall(Final)
% [row,col]=find(Final~=0);
% Aset=[row';col'];
% K=length(row);
% filePath=strcat('C:\multivideoExperiment\Newdataset\basketball\normalsize\part');
% % figure
% value=[];
% for i=1:K
%     framepath=imread([filePath,int2str(row(i)),'\',int2str(col(i)),'.jpg']);
%     afterflit(row(i),col(i));
%     value=[value afterflit(row(i),col(i))];
% %     subplot(1,K,i);imshow(framepath);
% end
% Aset=[Aset; value];
% Aset=Aset';
% Aset=sortrows(Aset,-3);
