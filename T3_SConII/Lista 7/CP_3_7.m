close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 3 Dorf 12a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% CP3.7) Consider the following system:
A = [0, 1; -2, -4];
B = [0; 1];
C = [1, 0];
D = 0;

% with
x0 = [1, 0];

% Using the Isim function obtain and plot the system response
% (for x₁(t) and x₂(t)) when u(t) = 0.
sys = ss(A, B, C, D);

% Ⅰ) t de simulação
t = 0:0.01:10;

% Ⅱ) u(t) = 0
u = 0*t;

% Ⅲ) Simuação do sistema
[y, t, x] = lsim(sys, u, t, x0);

% Ⅳ) Plot
figure()

plot(t,x(:,1), LineWidth = 3);
hold on;
plot(t,x(:,2),':', LineWidth = 3);

xlabel('t[s]');
ylabel('x(t)', Rotation = 0);
grid;

title('Simuação do sistema CP3.7')
legend('x₁', 'x₂')