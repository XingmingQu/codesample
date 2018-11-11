WindowL=31;
selection=[];
length=1200;
for i= 1:length
    col=L25basketball(:,i);
    index = find(col==max(col));
    selection(i)=index;
end
subplot(2,2,1);
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
subplot(2,2,2);
plot(count)


sigma=2;%��׼���С  
window=double(uint8(3*sigma)*2+1);%���ڴ�Сһ��Ϊ3*sigma  
  
H=fspecial('gaussian', WindowL, sigma);%fspecial('gaussian', hsize, sigma)�����˲�ģ��  
%Ϊ�˲����ֺڱߣ�ʹ�ò���'replicate'������ͼ����ⲿ�߽�ͨ�������ڲ��߽��ֵ����չ��  
img_gauss=imfilter(count,H,'replicate');  
subplot(2,2,3);
plot(img_gauss)

roundimg_gauss=round(img_gauss);

subplot(2,2,4);
plot(roundimg_gauss)