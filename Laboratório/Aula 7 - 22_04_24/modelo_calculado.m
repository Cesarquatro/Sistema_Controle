close all; clc; clear;

% Caio Maciel - 211270415;
% Cesar Augusto - 211270121;
% Lucas Morello - 211270315

X10 = 0.0;
U0 = 0.0;

a1=0.402;
a2=0.00726;
a3=2.6487;

b1=0.1377932;
b3=0.2401;
b4=0.0002401;
b5=0.00726;
b6=2.6487;
b7=0.0;

Konst1 = a1*(0.27*X10*X10 + b1) - a2*b5;
if (Konst1 <= 0.0001)
    Mult1=0.0;
else
    Mult1=1.0/Konst1;
end

Konst2 = (0.27*X10*X10 + b1)*Konst1;
if (Konst2 <= 0.0001)
    Mult2=0.0;
else
    Mult2= 1.0/Konst2;
end

Konst3 = (0.27*X10*X10 + b1);
if (Konst3 <= 0.0001)
    Mult3=0.0;
else
    Mult3= 1.0/Konst3;
end

A21 = (-a2*b6*Konst1 + 2.0*0.27*a1*a2*X10*(b6*X10 + 0.49*U0))*(Mult1*Mult1);
A23 = (a3*Konst3 +a2*(b4 - b7))*Mult1;
A24 = a2*b3 * Mult1;

t41_1 = b6*(-0.27*X10*X10 + b1) * (Mult3*Mult3);

t41_2 = a2*b5*b6*(0.27*X10*X10*(3.0*a1*0.27*X10*X10 + 2.0*a1*b1 - a2*b5) + b1*(-a1*b1 + a2*b5)) *(Mult2*Mult2);

t41_3 = 2.0*0.27*0.49*X10*U0*(Mult3*Mult3);

t41_4 = 2.0*a2*b5*0.49*0.27*X10*U0*(Mult2*Mult2)*(2.0*a1*0.27*X10*X10 + 2.0*a1*b1 - a2*b5);

A41 = t41_1 - t41_2 - t41_3 - t41_4;

A43 = ((b7 - b4)*Mult3) - (a3*b5*Mult1) - (a2*b5*(b4 - b7)*Mult2);

A44 = -b3*(Mult3  + (a2*b5*Mult2));

B2 = -a2*0.49*Mult1;

B4 = 0.49*(Mult3 + (a2*b5*Mult2));

A = [0 1 0 0; A21 0 A23 A24; 0 0 0 1; A41 0 A43 A44];
B = [0; B2; 0; B4];
C = [1,0,0,0;0,0,1,0];
D = [0; 0];