close all; clc; clear;
%% Lista 2 - Ex 10
% Considere o diagrama de blocos abaixo.

%% (a) Calcule a resposta do sistema em malha fechada (isto é, R(s) = 1 / s
% e Tp(s) = 0) e plote o gráfico do valor em regime permanente da saída
% Y(s) em função do ganho do controlador 0 < k ≤ 10.
% Controlador
K = 0.1:0.1:10;

% Planta
num_p = 1;
den_p = [1 20 20];
planta = tf(num_p, den_p)

for i=1:length(K)
 num_c = K(i); 
 den_c = 1;
 controlador = tf(num_c,den_c);
 serie_cp = feedback(controlador*planta, 1)
 feedback_cp = feedback(planta, controlador)
 y1 = step(serie_cp);
 Tf1(i) = y1(end);
end

%plot
figure(1)
plot(K,Tf1, 'LineWidth',3)
%% (b) Calcule a resposta à perturbação em degrau do sistema em malha 
% fechada (isto é, R(s) = 0 e Tp(s) = 1 / s)e plote o gráfico do valor em 
% regime permanente da saída Y(s) em função do ganho do controlador 
% 0 < k ≤ 10 no mesmo gráfico do item (a).
for i=1:length(K)
 y2 = step(feedback_cp);
 Tf2(i) = y2(end);
end

%plot
figure(2)
plot(K,Tf1, 'LineStyle','-', 'LineWidth', 3)
hold on
grid on
plot(K, Tf2,'LineStyle',':', 'LineWidth', 2)
xlabel('K')
legend('Item a)','Item b)', 'FontSize', 15, 'Location', 'northwest')

%% (c) Determine o valor de K de modo que o valor do regime permante da 
% saída seja igual para ambas, a resposta à entrada e a resposta à
% pertubação.