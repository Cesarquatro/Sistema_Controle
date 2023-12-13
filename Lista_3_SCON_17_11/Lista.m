close all; clc; clear;
%% Onda Quadrada e Resposta ao Degrau

% Função de entrada - Onda Quadrada
A = 0.3;
f = 1/20;
t = 0:0.01:50;
onda_quadrada = A * square(2 * pi * f * t + 1.1);

limX = [0 20]; 
limY = [-0.5 0.5];

% Ft
K = 1; % Ganho
tau = 1; % Cte de tempo
Gtau = tf(K, [tau 1]);

% Fazendo a resposta do sistema
resposta_ao_degrau = lsim(Gtau, onda_quadrada, t);

% Limpar a figura
figure(1);
clf;

% Plotando a onda quadrada e a resposta ao degrau
subplot(2, 1, 1);
plot(t, onda_quadrada, 'r', 'LineWidth', 3, 'DisplayName', 'Onda Quadrada', LineStyle='--');
grid on
legend('show');
title('Entrada: Onda Quadrada');

subplot(2, 1, 2);
plot(t, resposta_ao_degrau, 'b', 'LineWidth', 3, 'DisplayName', 'Resposta ao Degrau de G');
grid on
legend('show');
title('Resposta ao Degrau de G(τ)');

% Definindo os limites dos eixos
subplot(2, 1, 1);
xlim(limX);
ylim(limY);

%% Resposta ao Degrau com PID

% Plot 2
figure(2);
clf;

m = 0.2;
M = 0.5;
l = 0.3;
b = 0.1;
g = 9.8;
I = 0.006;
q = (M+m)*(I+m*l^2)-(m*l)^2;
num = [(m*l/q) 0];
denum = [1 (b*(I+m*l^2)/q) (-1*((M+m)*m*g*l)/q) (-1*(b*m*g*l)/q)];
sys = tf(num, denum);

kp = 8.5;
ki = 1;
kd = 0.1;
C = pid(kp, ki, kd);
T = feedback(sys, C);
t = 0:0.01:20;
A = 7;
f = 1/20;
onda_quadrada = A * square(2 * pi * f * t + 1.1);
resposta_degrau = lsim(T, onda_quadrada, t);

% Plot resposta ao degrau com PID
plot(t, resposta_degrau, 'k', 'LineWidth', 3, 'DisplayName', 'Resposta ao Degrau com PID');
hold on
plot(t, onda_quadrada, 'r', 'LineWidth', 3, 'DisplayName', 'Onda Quadrada', LineStyle='--');
grid on
legend('show');
title('Resposta ao Degrau com PID');