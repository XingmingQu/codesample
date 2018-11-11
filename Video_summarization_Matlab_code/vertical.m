
savePath='C:\multivideoExperiment\Newdataset\Cilp2S_basketball_SVD_var\';
f_mean=frame_matrixpart1+frame_matrixpart2+frame_matrixpart3+frame_matrixpart4;
f_mean=f_mean/4;
[x,y]=size(f_mean);
E_vertical_part1=[];
E_vertical_part2=[];
E_vertical_part3=[];
E_vertical_part4=[];
for i=1:y
E_vertical_part1(i)=sqrt(sum( (frame_matrixpart1(:,i)-f_mean(:,i)).^2 ));
E_vertical_part2(i)=sqrt(sum( (frame_matrixpart2(:,i)-f_mean(:,i)).^2 ));
E_vertical_part3(i)=sqrt(sum( (frame_matrixpart3(:,i)-f_mean(:,i)).^2 ));
E_vertical_part4(i)=sqrt(sum( (frame_matrixpart4(:,i)-f_mean(:,i)).^2 ));
    
end

save E_vertical_part,'E_vertical_part1';
