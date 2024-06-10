close all; clc; clear;
%% T3 - SCon II - Lista 9 - Exercício PA11.14 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.14) Considere o sistema de terceira ordem
A = [0, 1, 0; 0, 0, 1; -8,-3,-3]; 
B = [0;0;4]; 
C = [2,-9,2]; 
D = 0;

% Verifique que o sistema é observável e controlável. Em seguida, projete
% uma lei de realimentação de estado completo e um observador alocando os 
% pólos do sistema em malha fechada s₁,₂ = -1 ± j e s₃ = -2  os pólos do
% observador em s₁,₂ = -12 ± j2 e s₃ = -30.

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

%% III) Verifique que o sistema é observável

if (size(A, 1) == rank(obsv(A, C)))
    disp("É observável")
    fprintf('rank(obsv(A, B) = %d\n', rank(obsv(A, C)))
else
    disp("Não é observável")
    fprintf('rank(obsv(A, B) = %d\n', rank(obsv(A, C)))
end

%% c) escolha dos pólos em malha fechada;
% IV) Polos controlador dados nos enunciados
p1 = -1 + 1i;
p2 = -1 - 1i;
p3 = -2;
p = [p1, p2, p3]; 

% IV) Polos observadoor dados nos enunciados
po1 = -12 + 2i;
po2 = -12 - 2i;
po3 = -30;
po = [po1, po2, po3];

% V) Cálculo de K por ackerman
K = acker(A, B, p);

% VI) Projeto do observador pelo Teorema da dualidade
ss_dual = ss(A',C', B', D'); 
Ke = acker(ss_dual.A, ss_dual.B, po')'; % K de estimação

% VII) Matrizes Compensado
Atotal = [A-B*K, B*K; zeros(3,3), A-Ke*C]; % A final
Btotal = zeros(6,1);                       % B final
Ctotal = [C, zeros(1,3)];                  % C final

% polos sistema de alocação de polos + observador 
polos_sys_total = eig(Atotal);

% VIII) SS Compensado
ss_comp = ss(Atotal,Btotal,Ctotal,D);

% IX) Simulação do sistema Compensado

% CI controlador
x0 = [1;2;3];

% CI observador
x0_o = [0;0;0];

% Erro no início
e0 = x0-x0_o; 

% CI totais
X0 = [x0; e0];

% Variáveis de Simulação
t = 0:0.01:8;
u = 0*t; % Entrada nula

[y, T, x] = lsim(ss_comp,u,t,X0); % Sim p/ CI Totais

% Plot
figure;
subplot(2,4,1);
plot(T, y, 'LineWidth', 3, 'Color', 'k', 'LineStyle', '-');
grid on;
title('Saída do Sistema Compensado');
xlabel('Tempo (s)');
ylabel('y(t)');

% Plot das variáveis de estado
subplot(2,4,2);
plot(T, x(:,1), 'LineWidth', 3, 'Color', '#EA8C15', 'LineStyle', '--');
grid on;
title('x₁');
xlabel('t [s]');
ylabel('x₁(t)');

subplot(2,4,3);
plot(T, x(:,2), 'LineWidth', 1.5, 'Color', '#15EA21', 'LineStyle', '--');
grid on;
title('x₂');
xlabel('t [s]');
ylabel('x₂(t)');

subplot(2,4,4);
plot(T, x(:,3), 'LineWidth', 1.5, 'Color', 'r', 'LineStyle', '--');
grid on;
title('x₃');
xlabel('t [s]');
ylabel('x₃(t)');

subplot(2,4,6);
plot(T, x(:,4), 'LineWidth', 1.5, 'Color', '#1573EA', 'LineStyle', '-.');
grid on;
title('Erro em x₁');
xlabel('t [s]');
ylabel('e₁(t)');

subplot(2,4,7);
plot(T, x(:,5), 'LineWidth', 1.5, 'Color', '#EA15DE', 'LineStyle', '-.');
grid on;
title('Erro em x₂');
xlabel('t [s]');
ylabel('e₂(t)');

subplot(2,4,8);
plot(T, x(:,6), 'LineWidth', 1.5, 'Color', '#1ecbe1', 'LineStyle', '-.');
grid on;
title('Erro em x₂');
xlabel('t [s]');
ylabel('e₃(t)');

