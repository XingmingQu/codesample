matrix=BSVD;

Dif=abs(diff(matrix,1,2));
[x,y]=size(Dif);
aveDif=sum(sum(Dif))/ (x*y);


% 
% matrix=TimeSVD;
% [h,w]=size(matrix);
% 
% norm_matrix=[];
% for i =1:h
%    row_norm=norm(matrix(i,:));
%    norm_matrix=[norm_matrix; matrix(i,:)/row_norm];
% end
% 
% 
% Dif=abs(diff(norm_matrix,1,2));
% [x,y]=size(Dif);
% aveDif=sum(sum(Dif))/ (x*y);