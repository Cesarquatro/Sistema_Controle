close all; clc; clear;
%% T3 - SCon II - Lista 8 - Exercício PA11.1 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.1) Um sistema de Controle de motor CC tem a forma mostrada na 
% figura PA11.1. As três variáveis de estão disponíveis para medição; 
% a posição de saída é x₁(t). Escolha os ganhos de realimentação de 
% modo que o sistema tenha um erro em regime permanente igual a zero 
% para uma entrada em degrau e uma resposta com uma máxima ultrapas-
% sagem percentual menor 3%.

%% a) procedimento para realização no espaço de estados (se for o caso);
A = [0, 1, 0; 0, 0, 1; 0, -4, -5];
B = [0; 0; 1];
C = [4, 0, 0];
D = 0;

sys = ss(A, B, C, D);

%% b) viabilidade do controle, por meio da controlabilidade do sistema;
% IV) teste se o posto{rank()} da matriz de ₵{ctrb(A, B)} é igual a 
% dimesão de A
if (size(A, 1) == rank(ctrb(A, B)))
    disp("É controlável")
else
    disp("Não é controlável")
end

%% c) escolha dos pólos em malha fechada;
%  V) Utilizando o sisotool para máxima ultrapassagem percentual menor 3%
p1 = -0.4 + 0.2i;
p2 = -0.4 - 0.2i;
p3 = -10;
p  = [p1, p2, p3];

%%
% VI) Calculo de K:
K = acker(A, B, p);

% Ganho inicial
Ki = K(1);

% Ganho de realimentação desconsiderando o Ki
Kr = [0, K(2), K(3)];

% VII) Sistema compensado:
Acomp = A-B*K;
Bcomp = B*Ki;

% SS compensado
sys_comp = ss(Acomp,Bcomp,C,D); 
% FT compensado
Gs_comp = tf(sys_comp); 

% VIII) Verificação polos compensados, p/ ver se o SS compensado está 
% correto
rlocus(Gs_comp) % polos corretamente alocados

% IX) Simulação do Sys compensado
t = 0:0.01:40; 

% θref: 4 voltas completas
theta_ref = 4*2*pi;

% Degrau de referência para θref
r = (theta_ref).*ones(1, length(t)); 

% Simulação
[y, T, x] = lsim(sys_comp,r,t); 

% X) Plot da simulação
figure();
% subplot(3,1,1);
subplot(3,1,1);
yline(theta_ref,'LineWidth', 1.5); 
hold on;
plot(t, x(:,1), 'cyan', 'LineWidth', 4);
grid on;
title('Saída do Sistema Compensado');
xlabel('t(s)');
ylabel('y(t) = x₁(t) [m]');
legend('Saída    (Posição)', 'Entrada (Referência)');

% Variáveis de estado
% subplot(3,1,2);
subplot(3,1,2);
plot(t, x(:,2), 'Color', '#00BC08', 'LineStyle', ':','LineWidth', 1.5);
grid on;
title('ω');
xlabel('t [s]');
ylabel('x₂(t) [rad/s]');
legend('Velocidade');

% subplot(3,1,3);
subplot(3,1,3);
plot(t, x(:,3), 'Color', '#BC00B3', 'LineStyle', '--', 'LineWidth', 1.5);
grid on;
title('i');
xlabel('t [s]');
ylabel('x₃(t) [A]');
legend('Corrente de campo');