function [merged ] = mergeintersect( Unmerge )

% Unmerge=[21,220;221,610;597,1046;1036,1195];

%�ȶ��ҳ���������cilp����
Unmerge=sortrows(Unmerge,1);

[ha,wa]=size(Unmerge);
%��A�е�ÿһ������ȥ����Ƿ��н���
%�ӵ�һ����飬���û��鵽���һ���ͼ���
mark=1;
while(mark<ha)
    if Unmerge(mark+1,1)>Unmerge(mark,2) %����ڶ����������������ڵ�һ�����������䣬˵��û������������һ�����
        mark=mark+1;%������������
        continue;    
    else %���С�ڵ����ˣ�˵���н�������Ҫ����ǰ������ǰ����
        if Unmerge(mark+1,2)<=Unmerge(mark,2) %ȫ������ֱ���ӵ�mark+1�� mark���ƶ�
            Unmerge(mark+1,:)=[];
            [ha,wa]=size(Unmerge); %��ΪҪȥ���У����Կ���ʱ��ʱ��Ҫ���³���
        else %�����
            Unmerge(mark,2)=Unmerge(mark+1,2);
            Unmerge(mark+1,:)=[];
            [ha,wa]=size(Unmerge); %��ΪҪȥ���У����Կ���ʱ��ʱ��Ҫ���³���
        end       
    end
    
end

merged=Unmerge;
end