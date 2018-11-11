function [ result ] = generateVideocilp( EnergyMatrix,WinL ,M)
% EnergyMatrix=LobbyEM;
[h,w]=size(EnergyMatrix);
% WinL=10;
CilpGroup=findHighestCilpGroup(EnergyMatrix,WinL);

C=[CilpGroup(1,:)]; %初始化Cilpvideo 已选集C  存的是 1左区间 2右区间 3平均能量
W(1:length(CilpGroup))=0.986; %初始化每个cilp的权重
% M=3095+100;  %定义用户需要保留的帧M

currentlen=WinL; %开始只有一个cilp
currentSeedvideo=2; %指针指向下一个准备放入已选集的cilp

while(currentlen<M)
    CompareSet=[];
    [CH,CW]=size(C); %CH是现在有多少个已选Cilp
    
    %创建比较帧集，找出来所有Cilp的相邻帧 一共CH*2个
    for i=1:CH %对每一个Cilp 找出来相邻帧
        neighbour=C(i,1); %第一列记录来自哪个Cilp区间 1行是左 2行是右
        neighbour(2,1)=C(i,2);
        
        neighbour(1,2)=1;
        neighbour(2,2)=2; %第二列记录是左邻1还是右邻2
        if neighbour(1,1)-1==0
            neighbour(1,3)=sum( EnergyMatrix(:,neighbour(1,1)) )/h;
        else
            neighbour(1,3)=sum( EnergyMatrix(:,neighbour(1,1)-1) )/h;
        end
      
        neighbour(2,3)=sum( EnergyMatrix(:,neighbour(2,1)+1) )/h; %第三列记录左邻和右邻列的平均能量
        
        %把当前Cilp的两个相邻帧加入比较集合
        CompareSet=[CompareSet;neighbour];
    end
    
    CompareSet=sortrows(CompareSet,-3);
%    从比较集中 取出来最大的帧
    Selectframe=CompareSet(1,:);
    RorL=Selectframe(2); %确定找到的帧是左邻或者右邻
    
    %更新已选集中对应Cilpvideo的下标
    for i=1:CH %对C中每一个Cilp
        %定位选出来帧属于哪个C        
        if C(i,RorL)==Selectframe(1)      
           %计算cilp窗口内平均   %这行如果添加衰减系数后需要修改！！！！！
           %就是 EnergyMatrix(:,C(i,1):C(i,2)-1)+ EnergyMatrix(:,C(i,2))*wi
            aveE=  sum(sum(  EnergyMatrix(:,C(i,1):C(i,2))  ))  / ( (C(i,2)-C(i,1)+1) *h );
           
%             Selectframe(3)
             %如果选出来的帧能量大于等于平均
            if (Selectframe(3)) >=aveE
                
                  %要这帧，并更新已选集C中对应cilp的窗口下标
                if RorL==1   %1 就左边扩一个 2就右边扩 
                    C(i,RorL)=C(i,RorL)-1;
                else
                    C(i,RorL)=C(i,RorL)+1;
                end 
                
                currentlen=sum(C(:,2)-C(:,1)+1);
                break;
                
            else %如果选出来的帧能量小于平均
                %加入一个新的cilp
                if currentlen+WinL>M  %如果不够开窗口了，就忽视大于ave的条件
                     
                    if RorL==1   %1 就左边扩一个 2就右边扩 
                        C(i,RorL)=C(i,RorL)-1;
                    else
                        C(i,RorL)=C(i,RorL)+1;
                    end                    
                    
                    %这里需要merge看，看新加进来的和原来的是否有交集
                    C=mergeintersect(C);
                    %这行也得改，有交集就不是加WinL了
                    currentlen=sum(C(:,2)-C(:,1)+1);
                    
                    break
                    
                end
                
                C=[C; CilpGroup(currentSeedvideo,:)];
                
                %这里需要merge看，看新加进来的和原来的是否有交集
                C=mergeintersect(C);
                %这行也得改，有交集就不是加WinL了
                currentlen=sum(C(:,2)-C(:,1)+1);
                
                currentSeedvideo=currentSeedvideo+1;                
                break                              
            end           
        end          
    end     
end

result=C;

end