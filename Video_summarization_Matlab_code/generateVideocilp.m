function [ result ] = generateVideocilp( EnergyMatrix,WinL ,M)
% EnergyMatrix=LobbyEM;
[h,w]=size(EnergyMatrix);
% WinL=10;
CilpGroup=findHighestCilpGroup(EnergyMatrix,WinL);

C=[CilpGroup(1,:)]; %��ʼ��Cilpvideo ��ѡ��C  ����� 1������ 2������ 3ƽ������
W(1:length(CilpGroup))=0.986; %��ʼ��ÿ��cilp��Ȩ��
% M=3095+100;  %�����û���Ҫ������֡M

currentlen=WinL; %��ʼֻ��һ��cilp
currentSeedvideo=2; %ָ��ָ����һ��׼��������ѡ����cilp

while(currentlen<M)
    CompareSet=[];
    [CH,CW]=size(C); %CH�������ж��ٸ���ѡCilp
    
    %�����Ƚ�֡�����ҳ�������Cilp������֡ һ��CH*2��
    for i=1:CH %��ÿһ��Cilp �ҳ�������֡
        neighbour=C(i,1); %��һ�м�¼�����ĸ�Cilp���� 1������ 2������
        neighbour(2,1)=C(i,2);
        
        neighbour(1,2)=1;
        neighbour(2,2)=2; %�ڶ��м�¼������1��������2
        if neighbour(1,1)-1==0
            neighbour(1,3)=sum( EnergyMatrix(:,neighbour(1,1)) )/h;
        else
            neighbour(1,3)=sum( EnergyMatrix(:,neighbour(1,1)-1) )/h;
        end
      
        neighbour(2,3)=sum( EnergyMatrix(:,neighbour(2,1)+1) )/h; %�����м�¼���ں������е�ƽ������
        
        %�ѵ�ǰCilp����������֡����Ƚϼ���
        CompareSet=[CompareSet;neighbour];
    end
    
    CompareSet=sortrows(CompareSet,-3);
%    �ӱȽϼ��� ȡ��������֡
    Selectframe=CompareSet(1,:);
    RorL=Selectframe(2); %ȷ���ҵ���֡�����ڻ�������
    
    %������ѡ���ж�ӦCilpvideo���±�
    for i=1:CH %��C��ÿһ��Cilp
        %��λѡ����֡�����ĸ�C        
        if C(i,RorL)==Selectframe(1)      
           %����cilp������ƽ��   %����������˥��ϵ������Ҫ�޸ģ���������
           %���� EnergyMatrix(:,C(i,1):C(i,2)-1)+ EnergyMatrix(:,C(i,2))*wi
            aveE=  sum(sum(  EnergyMatrix(:,C(i,1):C(i,2))  ))  / ( (C(i,2)-C(i,1)+1) *h );
           
%             Selectframe(3)
             %���ѡ������֡�������ڵ���ƽ��
            if (Selectframe(3)) >=aveE
                
                  %Ҫ��֡����������ѡ��C�ж�Ӧcilp�Ĵ����±�
                if RorL==1   %1 �������һ�� 2���ұ��� 
                    C(i,RorL)=C(i,RorL)-1;
                else
                    C(i,RorL)=C(i,RorL)+1;
                end 
                
                currentlen=sum(C(:,2)-C(:,1)+1);
                break;
                
            else %���ѡ������֡����С��ƽ��
                %����һ���µ�cilp
                if currentlen+WinL>M  %��������������ˣ��ͺ��Ӵ���ave������
                     
                    if RorL==1   %1 �������һ�� 2���ұ��� 
                        C(i,RorL)=C(i,RorL)-1;
                    else
                        C(i,RorL)=C(i,RorL)+1;
                    end                    
                    
                    %������Ҫmerge�������¼ӽ����ĺ�ԭ�����Ƿ��н���
                    C=mergeintersect(C);
                    %����Ҳ�øģ��н����Ͳ��Ǽ�WinL��
                    currentlen=sum(C(:,2)-C(:,1)+1);
                    
                    break
                    
                end
                
                C=[C; CilpGroup(currentSeedvideo,:)];
                
                %������Ҫmerge�������¼ӽ����ĺ�ԭ�����Ƿ��н���
                C=mergeintersect(C);
                %����Ҳ�øģ��н����Ͳ��Ǽ�WinL��
                currentlen=sum(C(:,2)-C(:,1)+1);
                
                currentSeedvideo=currentSeedvideo+1;                
                break                              
            end           
        end          
    end     
end

result=C;

end