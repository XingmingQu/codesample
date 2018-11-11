function [merged ] = mergeintersect( Unmerge )

% Unmerge=[21,220;221,610;597,1046;1036,1195];

%先对找出来的所有cilp排序
Unmerge=sortrows(Unmerge,1);

[ha,wa]=size(Unmerge);
%和A中的每一个集合去检查是否有交集
%从第一个检查，如果没检查到最后一个就继续
mark=1;
while(mark<ha)
    if Unmerge(mark+1,1)>Unmerge(mark,2) %如果第二个区间的左区间大于第一个区间右区间，说明没交集，继续下一个检查
        mark=mark+1;%检查下面的区间
        continue;    
    else %如果小于等于了，说明有交集，需要检查是包含还是半包含
        if Unmerge(mark+1,2)<=Unmerge(mark,2) %全包含，直接扔掉mark+1行 mark不移动
            Unmerge(mark+1,:)=[];
            [ha,wa]=size(Unmerge); %因为要去掉行，所以开的时候时候要更新长度
        else %半包含
            Unmerge(mark,2)=Unmerge(mark+1,2);
            Unmerge(mark+1,:)=[];
            [ha,wa]=size(Unmerge); %因为要去掉行，所以开的时候时候要更新长度
        end       
    end
    
end

merged=Unmerge;
end