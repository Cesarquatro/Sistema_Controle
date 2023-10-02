close all; clc; clear;
%% Lista 2 - Ex 5
% Um sistema de controle de altitude de um único eixo de um satélite pode
% ser representado pelo diagrama de blocos da figura abaixo. As variáveis
% k, a e b são parâmetros de controle e J é o momento de inércia do veículo
% espacil. Admita que o valor nominal do momento de inércia seja J = 10.8e8
% [slug.m²] e que os valores dos parâmetros de controle sejam k = 10.8e8, a
% a = 1 e b = 8.
J = 10.8e8; % [Slug.m²]
k = 10.8e8;
a = 1;
b = 8;

num1 = [k k*a];
den1 = [1 b];
controlador = tf(num1, den1)

num2 = 1;
den2 = [J 0 0];
veiculo_espacial = tf(num2, den2)

%% (a) Desenvolva uma sequência de intruções para calcular a função 
% transferência em malha fechada T(s) = θ(s) / θd(s).
disp('-------------------------------')
disp('(a)')

Serie = series(controlador, veiculo_espacial)
Feedback = feedback(Serie, 1)

%% (b) Calcule e plote o gráfico da resposta ao degrau para uma entrada 
% em degrau de 10°.

t = 0:0.1:100;
figure(1)
y = step(10*Feedback, t);
plot(t, y, 'Color', 'b', 'LineWidth', 1)
title('Resposta ao degrau para uma entrada em degrau de 10°')
grid on
%% (c) O valor exato do momento de inércia é geralmente desconhecido e 
% pode mudar lentaente com o tempo. Compare o desempenho da resposta ao
% degrau do veículo espacial quando J é reduzido de 20% e 50%. Use os
% parâmetros  do controlado k = 10.8e8, a = 1 e b = 8 e uma entrada de 10°.
% discuta os resultados.
disp('-------------------------------')
disp('(c)')
% J reduzido de 20%
disp('J é reduzido de 20%:')
J2 = J*0.8;
den3 = [J2 0 0]; 
veiculo_espacial2 = tf(num2, den3)
Serie2 = series(controlador, veiculo_espacial2)
Feedback2 = feedback(Serie2, 1)
y2 = step(10*Feedback2, t);
%plot
figure(2)
plot(t, y,'Color', 'k', 'LineWidth', 2, 'LineStyle','-')   % plot com J em 100%
hold on
plot(t, y2, 'Color', 'b', 'LineWidth', 2, 'LineStyle','--') % plot com J reduzido de 20%
hold on
grid on

% J reduzido de 50%
disp('J é reduzido de 50%:')
J3 = J*0.5;
den4 = [J3 0 0];
veiculo_espacial3 = tf(num2, den4)
Serie3 = series(controlador, veiculo_espacial3)
Feedback3 = feedback(Serie3, 1)
y3 = step(10*Feedback3, t);
plot(t, y3, 'Color', 'r', 'LineWidth', 2,'LineStyle',':') % plot com J reduzido de 50%
hold on
legend('J', 'J reduzido de 20%','J de reduzido 50%', 'FontSize',15)
