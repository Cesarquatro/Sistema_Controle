close all; clc; clear;

% Cesar Augusto 211270121
% Caio Maciel   211270415
% Lucas Morello 211270351
%%
M0 = 4;%kg
M1 = 0.36;%kg
M = M0+M1;
lS = 0.451;%m
theta = 0.08433;%kgm²
N = 0.1624;%kgm
N2_01 = 0.3413;%kg²m²
N2_N2_01 = 0.07723;
Fr = 10;%Kg/s
C = 0.00145;%kgm²/s
g = 9.81;%m/s²

a22 = -(theta*Fr)/N2_01;
a23 = -N2_N2_01*g;
a24 = (N*C)/N2_01;
% a25 = (theta*N)/N2_01;

a42 = (N*Fr)/N2_01;
a43 = (M*N*g)/N2_01;
a44 = -(M*C)/N2_01;
% a45 = -N2_N2_01;

b2 = theta/N2_01;
b4 = -N/N2_01;

A = [0, 1, 0, 0; 0, a22, a23, a24; 0, 0, 0, 1; 0, a42, a43, a44];
B = [0; b2; 0; b4];
C = [1,0,0,0;0,0,1,0];
D = [0; 0];

%%

%Período de 
Ts = 0.03;

sys = ss(A,B,C,D);

% Continuous too discrete
sysd = c2d(sys, Ts);

raizes = eig(sysd);

% Vetor p (novos polos):
p = [0.9046584; 0.9046686; 0.8845338; 0.8845440];

% Alocação de polos F = K:
F = place(sysd.A, sysd.B, p)

% (S*I - A)
Acl = sysd.A - (sysd.B*F);

% novos autovalores
raizes_novas = eig(Acl);

% ganho para balancear as dimensões do sistema → [N]
V = 1/(sysd.C/(eye(4)-Acl)*sysd.B);

sim09