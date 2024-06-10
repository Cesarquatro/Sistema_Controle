close all; clc; clear;
%% T3 - SCon II - Lista 8 - Exercício PA11.7 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.7) O Radisson Diamond usa flutuadores e estabilizadores para amorte-
% cer o efeito das ondas que batem no navio, como mostrado na figura PA11.7
% (a). O diagrama de blocos do sistema de controle rolagem do navio é mos-
% trado na Figura PA11.7 (b) abaixo. Determine de realimentação K₂ e K₃ de
% modo que as raízes características sejam S = -15 e S = -2 ± j2. Represen-
% te graficamente a saída de rolagem Φ(t) para a perturbação em degrau
% unitário.
% Ao invés de perturbar com degrau, use as funções degrau para gerar um
% perturbação do tipo impulso, com amplitude de 10. Gere Φ(t) apenas no
% simulink.

%% a) procedimento para realização no espaço de estados (se for o caso);
% I) Funções transferências
num1 = 60;
den1 = [1 8];

Gs1 = tf(num1, den1);

num2 = 2;
den2 = [1 2];

Gs2 = tf(num2, den2);

num3 = 1;
den3 = [1 0];

Gs3 = tf(num3, den3);

% II) Gs final aplicando a função series:
Gs = series(Gs1, series(Gs2, Gs3));

% III) Forma canônica observável:
sys = canon(Gs, "companion");

% IV) Forma canônica com saída na variável de estado desejada(x₁):
A = [-10, 1, 0; -16, 0, 1; 0, 0, 0];
B = [0; 0; 120];
C = [1, 0, 0];
D = 0;

%% b) viabilidade do controle, por meio da controlabilidade do sistema;
% V) teste se o posto{rank()} da matriz de ₵{ctrb(A, B)} é igual a 
% dimesão de A
if (size(A, 1) == rank(ctrb(A, B)))
    disp("É controlável")
    fprintf('rank(ctrb(A, B) = %d\n', rank(ctrb(A, B)))
else
    disp("Não é controlável")
    fprintf('rank(ctrb(A, B) = %d\n', rank(ctrb(A, B)))
end

%% c) escolha dos pólos em malha fechada;
% VI) Polos dados nos enunciados
p1 = -2 + 2i;
p2 = -2 - 2i;
p3 = -15;
p = [p1, p2, p3];

% VII) Cálculo de K por ackerman
K = acker(A, B, p);

% VIII) Ki e Kr (K realimentação), p/ compensação do sistema
Ki = K(1);
Kr = [0, K(2), K(3)];

% IX) Sys Compensado
Acomp = A-B*K;
Bcomp = B*K(1);

% SS Compensado
ss_comp = ss(Acomp,Bcomp,C,D);

% Gs Compensado
Gs_comp = tf(ss_comp);

% X) Verificação polos compensados, p/ ver se o SS compensado está 
% correto
rlocus(Gs_comp);

t = 0:0.01:5; %Intervalo de 0.01 s entre cada amostra
u = 10 * [1; zeros(length(t)-1, 1)]; %Entrada impulso com amplitude de 10

% XI) Simulação do sistema
[y, T, x] = lsim(ss_comp,u,t); 

% Plot

figure;
subplot(3,1,1);
plot(t, x(:,1), 'LineWidth', 3, 'Color', '#EA8C15', 'LineStyle', '-');
title('Saída do Sistema Compensado');
xlabel('t [s]');
ylabel('y(t) = x₁(t)');
grid on;

subplot(3,1,2);
plot(t, x(:,2), 'LineWidth', 1.5, 'Color', '#15EA21', 'LineStyle', '--');
title('x₂');
xlabel('t [s]');
ylabel('x₂(t)');
grid on;

subplot(3,1,3);
plot(t, x(:,3), 'LineWidth', 1.5, 'Color', '#1573EA', 'LineStyle', ':');
xlabel('t [s]');
ylabel('x₃(t)');
grid on;
