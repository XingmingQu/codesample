len=length(d);




TP=0;
FP=0;
FN=0;
d=saved;
% d(2,10000:11000)=0;
figure
ax=1:1:len;
scatter(ax,d(1,:),'r')
hold on;
scatter(ax,d(3,:),'b')
for i =1:len
    if d(1,i)==1 &d(2,i)==1
        TP=TP+1;
    end
    
    if d(1,i)==1 &d(2,i)==0
        FP=FP+1;
    end
    
    if d(1,i)==0&d(2,i)==1
        FN=FN+1;
    end
    
end 