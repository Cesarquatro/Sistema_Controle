close all; clc; clear;
%% T3 - SCon II - Lista 8 - Exercício PA11.4 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.4) A equação diferencial vetorial descrevendo o pêndulo invertido é 
A = [0, 1, 0, 0; 0, 0, -1, 0; 0, 0, 0, 1; 0, 0, 9.8, 0];
B = [0; 1; 0; -1];

% Admita que todas as variáveis de estado estejam disponíveis para medição
% e use uma realização de variáveis de estado. Aloque as raízes caracterís-
% ticas do sistema em s = -2 ± j, -5 e -5.

%% a) procedimento para realização no espaço de estados (se for o caso);
% considere y = x3, o projeto de um regulador (enunciado da lista)
C = [0, 0, 1, 0];
D = 0;

% I) SS
sys = ss(A, B, C, D);

%% b) viabilidade do controle, por meio da controlabilidade do sistema;
% II) teste se o posto{rank()} da matriz de ₵{ctrb(A, B)} é igual a 
% dimesão de A
if (size(A, 1) == rank(ctrb(A, B)))
    disp("É controlável")
    fprintf('rank(ctrb(A, B) = %d\n', rank(ctrb(A, B)))
else
    disp("Não é controlável")
    fprintf('rank(ctrb(A, B) = %d\n', rank(ctrb(A, B)))
end

%% c) escolha dos pólos em malha fechada;
% II) Polos dados nos enunciados
p1 = -2 + 1i;
p2 = -2 - 1i;
p3 = -5;
p4 = -5;
p = [p1, p2, p3, p4];

% III) Cálculo de K por ackerman
K = acker(A, B, p);

% IV) Condições Iniciais (enunciado)
X0 = [0.9; 0.6; 0.7; 0.3];


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

subplot(2,2,1);
plot(t, x(:,1), 'LineWidth', 1.5, 'Color', '#EA8C15', 'LineStyle', '-');
ylabel("θ [rad]");
xlabel("t [s]");
title("X₁");
grid on;
legend("X₁");

subplot(2,2,2);
plot(t, x(:,2), 'LineWidth', 1.5, 'Color', '#15EA21', 'LineStyle', '--');
ylabel("ω [rad/s]");
xlabel("t [s]");
title("X₂");
grid on;
legend("X₂");

subplot(2,2,3);
plot(t, x(:,3), 'LineWidth', 1.5, 'Color', '#1573EA', 'LineStyle', ':');
ylabel("Posição linear [m]");
xlabel("t [s]");
title("X₃ (Saída)");
grid on;
legend('X₃');

subplot(2,2,4);
plot(t, x(:,4), 'LineWidth', 1.5, 'Color', '#EA15DE', 'LineStyle', '-.');
ylabel("i [A]");
xlabel("t [s]");
title("Corrente de Campo");
grid on;
legend('X₄');
