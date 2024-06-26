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
F = place(sysd.A, sysd.B, p);

% (S*I - A)
Acl = sysd.A - (sysd.B*F);

% novos autovalores
raizes_novas = eig(Acl);

% ganho para balancear as dimensões do sistema → [N]
V = 1/(sysd.C/(eye(4)-Acl)*sysd.B);

% sim09

%% Aula 10 - A

Cm = [1 0 0 0];
% Este vetor contém os polos desejados para o sistema do observador.
pL = [0.8351; 0.8352; 0.8353; 0.8354];

% matriz de controladores L
L = place(sysd.A',Cm',pL).';

% Matriz de observabilidade
Aobs = sysd.A - (L*Cm); 

% autovalores da matriz Aobs
Autov_Aobs = eig(Aobs);

%% Aula 10 - B
Ared = [sysd.A(2,2), sysd.A(2,4); sysd.A(4,2), sysd.A(4,4)];
Cred = [sysd.A(1,2), sysd.A(1,4); sysd.A(3,2), sysd.A(3,4)];

Autov_Ared = eig(Ared);

pred = [0.0498, 0.0499];

Lred = place(Ared',Cred',pred).';

Aored = Ared - (Lred*Cred);

Autov_Aored = eig(Aored);

A1 = [sysd.A(1,1), sysd.A(1,3); sysd.A(3,1), sysd.A(3,3)];
A2 = [sysd.A(2,1), sysd.A(2,3); sysd.A(4,1), sysd.A(4,3)];

B1 = [sysd.B(1,1); sysd.B(3,1)];
B2 = [sysd.B(2,1); sysd.B(4,1)];

Fred = (Aored*Lred) + A2 - (Lred*A1);
Bred = B2 - (Lred*B1);

%% Aula 10 - C
sim10