close all; clc; clear;
%% T3 - SCon II - Lista 8 - Exercício PA11.5 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.5) Um sistema de suspensão de automóvel tem três variáveis de estado
% físicas, como mostrado na figura abaixo. A estrutura de realimentação de
% variáveis de estado é mostrada na figura, com K₁ = 1. Escolhas K₂, K₃ de
% modo que as variáveis da equação característica sejam três raízes reais
% situadas entre s = -3 e S = -6. Além disso, escolha Kₚ de modo que o erro
% em regime permanente para entrada em degrau seja igual a zero.

%% a) procedimento para realização no espaço de estados (se for o caso);
% I) Funções transferências
num1 = 2;
den1 = [1 4];

Gs1 = tf(num1, den1);

num2 = 1;
den2 = [1 2];

Gs2 = tf(num2, den2);

num3 = 1;
den3 = [1 3];

Gs3 = tf(num3, den3);

% II) Gs final aplicando a função series:
Gs = series(Gs1, series(Gs2, Gs3));

% III) Forma canônica observável:
sys = canon(Gs, "companion");

% IV) Forma canônica com saída na variável de estado desejada(x₁):
A = [-9, 1, 0; -26, 0, 1; -24, 0, 0];
B = [0; 0; 2];
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

% VII) Para sistema de tipo 0, o sistema possui uma var de estado adicional
% ξ = (\xi)
Ae = [A, zeros(3,1); -C, 0];
Be = [B; 0];

% VIII) viabilidade do controle, por meio da controlabilidade do sistema;
% teste se o posto{rank()} da matriz de ₵{ctrb(Ae, Be)} é igual a 
% dimesão de Ae
if (size(Ae, 1) == rank(ctrb(Ae, Be)))
    disp("É controlável")
    fprintf('rank(ctrb(Ae, Be) = %d\n', rank(ctrb(Ae, Be)))
else
    disp("Não é controlável")
    fprintf('rank(ctrb(Ae, Be) = %d\n', rank(ctrb(Ae, Be)))
end

%% c) escolha dos pólos em malha fechada;
% IX) Escolha de pólos arbitrária seguindo as regras do enunciado;
p1 = -4;
p2 = -4.5;
p3 = -5;
p4 = -5.5; % Polo extra para ξ

p = [p1, p2, p3, p4];

% X) Cálculo de K por ackerman
Kacker = acker(Ae, Be, p);

% XI) Ki e K (K realimentação), p/ compensação do sistema
Ki = -Kacker(4);
K = Kacker(1:3);  

% XII) Sys Compensado
Acomp = [A-(B*K), B*Ki; -C, 0];
Bcomp = [zeros(3,1); 1];
Ccomp = [C, 0];
Dcomp = 0;

% SS Compensado
ss_comp = ss(Acomp,Bcomp,Ccomp,Dcomp);

% Gs Compensado
Gs_comp = tf(ss_comp);

% XIII) Verificação polos compensados, p/ ver se o SS compensado está 
% correto
rlocus(Gs_comp);

% XIV) Simulação do sistema
t = 0:0.01:10; 
u = 10*ones(1, length(t)); % Entrada degrau 5

[y, T, x] = lsim(ss_comp, u, t); % Simula a resposta do sistema

% Plot

subplot(2,2,1);
plot(t, x(:,1), 'LineWidth', 3, 'Color', '#EA8C15', 'LineStyle', '-');
ylabel("X₁ [u]");
xlabel("t [s]");
title("X1 (saída)");
hold on;
yline(10);
legend("Saída", "Referência", Location =  "southeast");
grid on;

subplot(2,2,2);
plot(t, x(:,2), 'LineWidth', 1.5, 'Color', '#15EA21', 'LineStyle', '--');
ylabel("X₂ [u]");
xlabel("t [s]");
title("X₂");
grid on;

subplot(2,2,3);
plot(t, x(:,3), 'LineWidth', 1.5, 'Color', '#1573EA', 'LineStyle', ':');
ylabel("X₃ [u]");
xlabel("t [s]");
title("X₃");
grid on;

subplot(2,2,4);
plot(t, x(:,4), 'LineWidth', 1.5, 'Color', '#EA15DE', 'LineStyle', '-.');
ylabel("ξ [u]");
xlabel("t [s]");
title("X₄ (ξ)");
grid on;