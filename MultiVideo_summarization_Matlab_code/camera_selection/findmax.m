function [ output ] = findmax( window )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
s=tabulate(window);
re= find(s(:,2)==max(s(:,2)));
output=re(1);
end

