function [ FinalRE ,d] = evaluate( result ,groundTruth)
%LOBBY ×¨ÓÃ
% re=result(2:end,:);
% re=result;
% GT=floor(groundTruth./3);

%OFFiCE
re=result;
GT=(groundTruth);

a=max(max(re));
b=max(max(GT));
c=max(a,b);
d=zeros(3,c);
[x,y]=size(re);

for i=1:x
    d(1,re(i,1):re(i,2))=1;
end
[x,y]=size(GT);
for i=1:x
    d(2,GT(i,1):GT(i,2))=1;
    d(3,GT(i,1):GT(i,2))=2;
end

figure
ax=1:1:c;
scatter(ax,d(1,:),'r')
hold on;
scatter(ax,d(3,:),'b')

count=d(1,:)==d(2,:);
Acc=sum(count)/c;

TP=0;
FP=0;
FN=0;
for i=1:c
    if (d(1,i)==1 && d(2,i)==1)
        TP=TP+1;
    end

    if (d(1,i)==1 && d(2,i)==0)
        FP=FP+1;
    end  
    
    if (d(1,i)==0 && d(2,i)==1)
        FN=FN+1;
    end
end
FP
FN
P=TP/(TP+FP);
R=TP/(TP+FN);
F1= (2*P*R)/(P+R);

FinalRE=[Acc;P;R;F1];



