function [ output ] = findmax( window )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
s=tabulate(window);
re= find(s(:,2)==max(s(:,2)));
output=re(1);
end

