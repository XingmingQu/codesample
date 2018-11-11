huadongL=[2 4 6 8 10 12 14 16 20 26 30 36 40 44 46 50 52 58 60];
EMmatrix={};
Len=length(huadongL);
clipL=[6 10 12 14 16 20 26 30 36 40 44 46 50 52 58 60];
Clen=length(clipL);
file='C:\lobby\level1\';
partNum=3;
groundTruth=groundTruth;
frameNum=sum(groundTruth(:,2)-groundTruth(:,1)+1);

%lobby
frameNum=floor(frameNum/3);

for i=1:1
    i
    EMmatrix{i}=getEM(huadongL(i),file,partNum);
end

PRACCF1=[];
for j=1:1
    for k=1:Clen
        Clip=generateVideocilp( EMmatrix{j},clipL(k),frameNum);
        re=evaluate(Clip,groundTruth);
        re=[re;huadongL(j);clipL(k)];
        PRACCF1=[PRACCF1 re]
    end
end
