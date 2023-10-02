close all; clc; clear;
%% Lista 2 - Ex 7
% Para o pêndulo simples mostrado na figura abaixo, a equação linear do
% movimento é dada por
% θ''(t) + g / L * sen(θ) = 0 ,
% em que L = 0.5 m, m = 1kg e g = 9.8m/s². Quando a equação não linear é
% linearizada em torno do ponto de equilíbrio θ = 0, obtém-se o módulo
% linear invariante no tempo.
% θ'' + g / L * θ = 0 .

L = 0.5; % [m]
m = 1;   % [Kg]
g = 9.8; % [m/s²]
t = 0:0.01:20;
%% Crie uma sequência de intruções para plotar o gráfico de ambas as res-
% postas, não linear e linear, do pêndulo simples quando o ângulo inicial
% do pêndulo for θ(0) = 30° e explique quais as diferenças

theta = 30; % ângulo inicial θ(0)

% Simulação Linear
num = [1 0 0];
den = [1 0 g/L];
sys_linear = tf(num, den);
x = step(theta*sys_linear, t);

figure(1)
plot(t, x, "LineWidth",2)
grid on

hold on

% Simulação não linear
[t,ynl] = ode45(@pend,t,[theta*pi/180 0]);
plot(t,ynl(:,1)*180/pi, "LineWidth",2);
xlabel('Tempo [s]')
ylabel('θ [°]', 'Rotation',0)

legend('Simulação Linear','Simulação não linear','FontSize',15)

% Def. função pendulo
function [yd]=pend(~,y)
L=0.5; g=9.8;
yd(1)=y(2);
yd(2)=-(g/L)*sin(y(1));
yd=yd';
end

