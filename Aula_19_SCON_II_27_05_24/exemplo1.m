close all; clc; clear;

%% I) representação do sistema
A = [-3, 0; 0, -2];
B = [1; 1];
C = [1, 2];
D = 0;

sys = ss(A, B, C, D);           % Representação em SS
sys_dual = ss(A', C', B', D');  % Representação dual
                                % ' depois é o transposto

%% II) Verificação de observabilidade - implica que o sistema 
% dual é controlavel

O = obsv(A, C); % Matriz de observabilidade
rho = rank(O);  % Deve ser igual a n para ser observável (n=2 nesse caso)

%% III) Polos desejados para o controle do sistema dual
%  Agora é um problema de controlabilidade por alocação de polos normal

mu1 = -10;
mu2 = -12;
mu = [mu1, mu2];

K = acker(sys_dual.A, sys_dual.B, mu);

% Erro de estimação 🐶
Ke = K'

%% IV) Condições iniciais para os estados - apenas para o estudo da 
% dinâmica do observador
ci_x1 = 0.4;
ci_x2 = 0.2;
