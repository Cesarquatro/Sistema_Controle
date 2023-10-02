close all; clc; clear;
%% Lista 2 - Ex 6
% Considere o diagrama de blocos da figura abaixo.
% (figura)

num1 = 1;
dem1 = [1 1];
sys1 = tf(num1, dem1)

num2 = [1 0];
dem2 = [1 0 2];
sys2 = tf(num2, dem2)

num3 = 1;
dem3 = [1 0 0];
sys3 = tf(num3, dem3)

num4 = [4 2];
dem4 = [1 2 1];
sys4 = tf(num4, dem4)

num5 = [1 0 2];
dem5 = [1 0 0 14];
sys5 = tf(num5, dem5)

%% (a) Use uma sequência de instruções para reduzir o diagrama de blocos
% na figura e calcule a função tranferência em malha fechada
% I
Serie1 = series(sys1, sys2);
Feedback1 = feedback(sys3, 50);

% II
Feedback2 = feedback(Serie1, sys4);

% III
Serie2 = series(Feedback2, Feedback1);

% IV
Feedback3 = feedback(Serie2, sys5);

% V
disp('Função tranferência em malha fechada:')
Serie3 = series(4, Feedback3)

%% (b) Gere um diagrama e polos e zeros da função transferência em malha
% fechada na forma gráfica usando a função pzmap.
figure(1)
pzmap(Serie3)
grid on

%% (c) Determine explicitamente os polos e zeros da função transferência em
% malha fechada usando as funções pole e zero e correlacione os resultados
% com o diagrama de polos e zeros da parte (b)

Polos = pole(Serie3)
Zeros = zero(Serie3)




