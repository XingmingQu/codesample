function [ ratio ] = activepix( M1,M2,threshold )

%做差取绝对值，加到一维，uint8方便可视化
Diff=uint8(sum(abs(M1-M2),3));
count=0;
[h,w]=size(Diff);
%开始统计，超过阈值认为是活动像素
for i=1:h
    for j=1:w
        if Diff(i,j)>threshold
            count=count+1;
        end
    end
end
%返回活动像素比例
ratio=count/(h*w);
end

