EH=[E_horizontalpart1;E_horizontalpart2;E_horizontalpart3;E_horizontalpart4];
EF=[E_vertical_part1;E_vertical_part2;E_vertical_part3;E_vertical_part4];
ACT=[actpixpart1;actpixpart2;actpixpart3;actpixpart4];
sumEH=sum(sum(EH));
sumEF=sum(sum(EF));
ratio=sumEH/sumEF;
ratio=ratio*2;
Energy_Matrix=EH+ (ratio*EF);
sumEM=sum(sum(Energy_Matrix));
sumACT=sum(sum(ACT));
ratio2=sumEM/sumACT;

cofficientACT=ACT*ratio2;

Final_Energy_Matrix=Energy_Matrix+cofficientACT;

save 'L2SbasketballEM';

