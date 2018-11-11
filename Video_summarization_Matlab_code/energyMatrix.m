EH=[E_horizontalpart1;E_horizontalpart2;E_horizontalpart3;E_horizontalpart4];
EF=[E_vertical_part1;E_vertical_part2;E_vertical_part3;E_vertical_part4];
ACT=[actpixpart1;actpixpart2;actpixpart3;actpixpart4];

Energy_Matrix=EH+EF;

cofficientACT=ACT.*Energy_Matrix;

Final_Energy_Matrix=Energy_Matrix+cofficientACT;

save '4people_all_var';

