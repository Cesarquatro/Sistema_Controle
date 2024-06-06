close all; clc; clear;
%% 
A = [0, 1, 0; 0, 0, 1; 0, -1, 0];
B = [0; 0; 1];
C = [1, 0, 0];
D = 0;

p1 = -1.5 + 2.75i;
p2 = -1.5 - 2.75i;
p3 = -10;

p = [p1, p2, p3];

po1 = real(p1)*3.5;
po2 = real(p2)*3.5;
po3 = real(p3)*3.5;

po = [po1, po2, po3];

sys = ss(A, B, C, D);

[num, den] = ss2tf(A, B, C, D);

Gs = tf(num, den); % Planta

K = acker(A, B, p); % Vetor Ganho

sys_dual = ss(A', C', B', D');

Ke = acker(sys_dual.A, sys_dual.B, po)';

%% Controlador e Observador
A_gco = A- Ke*C - B*K;
polosA_gco = eig(A_gco)