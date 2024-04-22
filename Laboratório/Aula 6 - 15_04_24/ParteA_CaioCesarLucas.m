close all; clc; clear;
% Caio Maciel    211270415
% Cesar Augusto  211270121
% Lucas Morello  211270351
%% 
% Matrizes
% A = [0,1,0,0;-0.0342,0,6.592,0.031;0,0,0,1;18.898,0,-0.344,-1.713];
% B = [0;-0.0633;0;3.496];
% C = [1,0,0,0;0,0,1,0];
% D = [0; 0];
modelo_calculado

sys = ss(A,B,C,D)

sys_tf = tf(sys)

Auto_Valores_A = eig(sys.A)

%% Continue 2 Discrete
Ts = 0.05;
t = 0.0:Ts:30.0;

sysd = c2d(sys,Ts);

step(sysd)

Auto_Valores_AD = eig(sysd.A)


p = [1.1601 + 0.0000i;
     0.8262 + 0.0000i;
     0.9654 + 0.1601i;
     0.9654 - 0.1601i;]*0.8

F = place(sysd.A, sysd.B, p)

Acl = sysd.A - (sysd.B*F)

Acl_eig = eig(Acl)

%% Sys malha fechada

sys_fechada = ss(Acl,sysd.B,sysd.C,sysd.D, Ts);

figure
step(sys_fechada)

V = 1/(sysd.C*inv(eye(4)-Acl)*sysd.B)


Ared = [sysd.A(2,2), sysd.A(2,4); sysd.A(4,2), sysd.A(4,4)];
Cred = [sysd.A(1,2), sysd.A(1,4); sysd.A(3,2), sysd.A(3,4)];

Auto_Valores_Ared = eig(Ared)

pred = [1.0022  + 0.0000i;
        0.9135  + 0.0000i;]*0.99

Lred = place(Ared',Cred',pred).';

Aored = Ared - (Lred*Cred);

Auto_Valores_Aored = eig(Aored)

A1 = [sysd.A(1,1), sysd.A(1,3); sysd.A(3,1), sysd.A(3,3)];
A2 = [sysd.A(2,1), sysd.A(2,3); sysd.A(4,1), sysd.A(4,3)];

B1 = [sysd.B(1,1); sysd.B(3,1);];
B2 = [sysd.B(2,1); sysd.B(4,1);];

Fred = (Aored*Lred) + A2 - (Lred*A1)
Bred = B2 - (Lred*B1)

