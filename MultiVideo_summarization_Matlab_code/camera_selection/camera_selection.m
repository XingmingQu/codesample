WindowL=20;
selection=[]
length=1000
for i= 1:length
    col=encoder(:,i);
    index = find(col==max(col));
    selection(i)=index;
end
figure
plot(selection)
count=[];
for j=1:ceil(length/WindowL)
    index=j*WindowL-(WindowL-1);
    
    if index+WindowL>length
        count(index:length)=findmax(selection(index:length));
        break
    end
    
    count(index:index+WindowL)=findmax(selection(index:index+WindowL));
end
figure
plot(count)