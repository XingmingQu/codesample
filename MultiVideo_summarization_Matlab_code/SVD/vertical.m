
savePath='C:\multivideoExperiment\SVDvar\';
f1=frame_matrixpart1;
f2=frame_matrixpart2;
f3=frame_matrixpart3;
f_mean=f1+f2+f3;
f_mean=f_mean/3;

E_vertical_part1=[];
E_vertical_part2=[];
E_vertical_part3=[];
for i=1:1000
E_vertical_part1(i)=sqrt(sum( (f1(:,i)-f_mean(:,i)).^2 ));
E_vertical_part2(i)=sqrt(sum( (f2(:,i)-f_mean(:,i)).^2 ));
E_vertical_part3(i)=sqrt(sum( (f3(:,i)-f_mean(:,i)).^2 ));
    
end

save E_vertical_part,'E_vertical_part1';
