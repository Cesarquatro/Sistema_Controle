close all; clc; clear;
%% Lista 2 - Ex 2
% Considere o sistema com realimentação descrito na Figura abaixo
% (figura)

num1 = 1;
den1 = [1 1];
controlador = tf(num1, den1)

num2 = [1 2];
den2 = [1 3];
planta = tf(num2, den2)
disp('----------------------------')

%% (a) Calcule a função transferência em malha
% fechada usando as funções series e feedback.
disp('(b)')
Serie = series(controlador, planta)
Feedback = feedback(Serie, 1)

%% (b) Obtenha a resposta ao degrau unitário
% do sistema em malha fechada com a função 
% step e verifique que o valor final da saída
% é 2/5.
figure(1)
step(Feedback)
grid on

