close all; clc; clear;

%% I) Obter o modelo da planta em espaço de estados(realização)
s = tf('s'); % Cria a variavel de laplace 's'
G = 10*(s+2)/(s*(s+4)*(s+6)); % ft do sistema

[num, den] = tfdata(G, 'v'); % Coleta os fatores do num e den de G(s)
[A, B, C, D] = tf2ss(num, den); % Faz a realização em SS a partir de G(s)

%% II) Condições iniciais
x0 = [1; 0; 0];
e0 = [1; 0; 0];

%% III) Projeto de K por meio da alocação de polos
% Critério de projeto:
% tss < 4s
% 25% < M.U.P. < 35%

% Evocar o sisotool para ajudar na seleção dos polos
mu1 = -1.2 + 3*1i;
mu2 = -1.2 - 3*1i;
mu3 = -12; % Parte real mais afastado à esq. para "não influenciar" no sis.

mus = [mu1, mu2, mu3]; % Vetor de polis que atendem os critérios de proj.

%% IV) Projeto do observador

% Caso 1 - polos o observador vão ter parte real 5x mais afastados à esq.
% com relação aos polos dominantes do controlador k

po1 = 2*real(mu2);
po2 = 2*real(mu2);
po3 = 2*real(mu2);

po = [po1; po2; po3];

%% V) Projeto de K e Ke
K = acker(A, B, mus); % Projeto de K para atender aos critérios de demp.

%% VI) Projeto do observador usando o teorema da dualidade
sys_dual = ss(A', C', B', D'); % sis dual

Ke = acker(sys_dual.A, sys_dual.B, po)';

%% VII) Avaliar a estabilidade do controlador-observador

A_gco = A- Ke*C - B*K;  % Os valores dessa matriz são iguais aos 
                        % polos do controlador-observador
polos_gco =  eig(A_gco); % Caso houver parte real +, o sis é instável
Atotal = [A - B*K, B*K; zeros(3,3),A-Ke*C]; % Matriz A do sis final, com-
                                          % pensado com estados observador
polos_sys_total = eig(Atotal);

%% VIII) Analisar o comportamento no Simulink
% Compensador: 
Gcomp = minreal(K/(s*eye(3) - A + Ke*C + B*K)*Ke, 1e-3);
sistema_com = minreal(Gcomp*G);
rlocus(sistema_com)
