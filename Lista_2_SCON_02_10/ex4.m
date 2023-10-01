close all; clc; clear;
%% Lista 2 - Ex 4
% Considere o sistema mecânico descrito na figura abaixo. A entrada é dada
% por f(t) e a saída é y(t). Determine a função transferência de f(t) para
% y(t) e, plote um gráfico da resposta do sistema a uma entrada em degrau
% unitário. Seja m = 10k, k = 1 e b = 0.5. Mostre que a amplitude máxima da
% saída esta em torno de 1.8

k = 1;
b = 5e-1;
m = 10 * k;

num = 1/m;
den = [1 b/m k/m];

Hs = tf(num, den)

t = 0:0.01:400;

amplitude = step(Hs, t);

figure(1)
plot(t, amplitude, 'LineWidth', 2)
grid on