close all; clc; clear;
%% T3 - SCon II - Lista 9 - Exercício PA11.13 Dorf
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% PA11.7) Considere o sistema representado na forma de variáveis de estado
% em que
A = [1, 2; -6, -12];
B = [-5; 1];
C = [4, -3];
D = 0;

% Verifique que o sistema é observável e controlável. Se for, projete uma
% lei de realimentação de estado completo e um observador alocando os pólos
% do sistema em malha fechada s = -1 ± j e os pólos do observador em
% s = -12.

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
p = [p1, p2];

% IV) Polos observadoor dados nos enunciados
po1 = -12;
po2 = -12;
po = [po1, po2];

% V) Cálculo de K por ackerman
K = acker(A, B, p);

% VI) Projeto do observador pelo Teorema da dualidade
ss_dual = ss(A',C', B', D'); 
Ke = acker(ss_dual.A, ss_dual.B, po')'; % K de estimação

% VII) Matrizes Compensado
Atotal = [A-B*K, B*K; zeros(2,2), A-Ke*C]; % A final
Btotal = zeros(4,1);                       % B final
Ctotal = [C, zeros(1,2)];                  % C final

% polos sistema de alocação de polos + observador 
polos_sys_total = eig(Atotal); 

% VIII) SS Compensado
ss_comp = ss(Atotal,Btotal,Ctotal,D);

% IX) Simulação do sistema Compensado

% CI controlador
x0 = [1;2];  

% CI observador
x0_o = [1;0];

% Erro no início
e0 = x0-x0_o; 

% CI totais
X0 = [x0; e0];

% Variáveis de Simulação
t = 0:0.01:10;
u = 0*t; % Entrada nula

[y, T, x] = lsim(ss_comp,u,t,X0); % Sim p/ CI Totais

% Plot
% Plot da saída do sistema
figure;
subplot(2,3,1);
plot(T, y, 'LineWidth', 3, 'Color', 'k', 'LineStyle', '-');
grid on;
title('Saída do Sistema Compensado');
xlabel('t [s]');
ylabel('y(t)');

% Plot das variáveis de estado
subplot(2,3,2);
plot(T, x(:,1), 'LineWidth', 3, 'Color', '#EA8C15', 'LineStyle', '-');
grid on;
title('x₁');
xlabel('t [s]');
ylabel('x₁(t)');

subplot(2,3,3);
plot(T, x(:,2), 'LineWidth', 1.5, 'Color', '#15EA21', 'LineStyle', '--');
grid on;
title('x₂');
xlabel('t [s]');
ylabel('x₂(t)');

subplot(2,3,5);
plot(T, x(:,3), 'LineWidth', 1.5, 'Color', '#1573EA', 'LineStyle', ':');
grid on;
title('Erro em x₁');
xlabel('t [s]');
ylabel('e₁(t)');

subplot(2,3,6);
plot(T, x(:,4), 'LineWidth', 1.5, 'Color', '#EA15DE', 'LineStyle', '-.');
grid on;
title('Erro em x₂');
xlabel('t [s]');
ylabel('e₂(t)');