close all; clc; clear;
%% T3 - SCon II - Lista 8 - Exercício PA11.2 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.2) Um sistema possui o modelo
A = [-3, -1, -1; 4, 0, 0; 0, 1, 0];
B = [3; 0; 0];

% Acrescente uma realimentação de variáveis de estado de modo que os pólos
% em malha fechada sejam s = -4, -5 e -6.

%% a) procedimento para realização no espaço de estados (se for o caso);
C = [1, 0, 0];
D = 0;

sys = ss(A, B, C, D);

%% b) viabilidade do controle, por meio da controlabilidade do sistema;
% I) teste se o posto{rank()} da matriz de ₵{ctrb(A, B)} é igual a 
% dimesão de A
if (size(A, 1) == rank(ctrb(A, B)))
    disp("É controlável")
    fprintf('rank(ctrb(A, B) = %d\n', rank(ctrb(A, B)))
else
    disp("Não é controlável")
end

%% c) escolha dos pólos em malha fechada;
% II) Polos dados nos enunciados
p1 = -4;
p2 = -5;
p3 = -6;
p = [p1, p2, p3];

% III) Cálculo de K por ackerman
K = acker(A, B, p);

% IV) Condições Iniciais (enunciado)
X0 = [1; 0.5; 0.1];


% V) Sys compensado:
Acomp = A-B*K;
Bcomp = B*K(1);

% SS compensado
sys_comp = ss(Acomp,Bcomp,C,D); 
% FT compensado
Gs_comp = tf(sys_comp); 

% VI) Verificação polos compensados, p/ ver se o SS compensado está 
% correto
rlocus(Gs_comp) % polos corretamente alocados

% VII) Simulação do sistema
t = 0:0.01:10;
u = 0*t; % Entrada degrau nula

[y, t, x] = lsim(sys_comp,u,t,X0); % Simula a resposta do sistema

% VIII) %% Plotagem dos estados

figure();
% subplot(3,1,1);
subplot(3,1,1);
yline(u,'LineWidth', 1.5); 
hold on;
plot(t, x(:,1), 'cyan', 'LineWidth', 4);
grid on;
title('Saída do Sistema Compensado');
xlabel('t(s)');
ylabel('y(t) = x₁(t) [m]');
legend('Saída', 'Entrada');

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

