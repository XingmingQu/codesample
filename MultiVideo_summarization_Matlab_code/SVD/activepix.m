function [ ratio ] = activepix( M1,M2,threshold )

%����ȡ����ֵ���ӵ�һά��uint8������ӻ�
Diff=uint8(sum(abs(M1-M2),3));
count=0;
[h,w]=size(Diff);
%��ʼͳ�ƣ�������ֵ��Ϊ�ǻ����
for i=1:h
    for j=1:w
        if Diff(i,j)>threshold
            count=count+1;
        end
    end
end
%���ػ���ر���
ratio=count/(h*w);
end

