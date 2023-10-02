close all; clc; clear;
%% Lista 2 - Ex 8
% Um sistema possui a função transferência
% X(s) / R(s) = (20 / z)*(s + z) / s² + 3s + 20
den = [1 3 20];
t = 0:0.01:6;

%% Plot o gráfico da resposta do sistema quando R(s) é um degrau unitário
% para o parâmetro z = 5, z = 10 e z = 15.

% z = 5
disp("z = 5:")

z1 = 5;
num1 = [20/z1 20];
sys1 = tf(num1, den)
x1 = step(sys1, t);

% z = 10
disp("z = 10:")

z2 = 10;
num2 = [20/z2 20];
sys2 = tf(num2, den)
x2 = step(sys2, t);

% z = 15
disp("z = 15:")
z3 = 15;
num3 = [20/z3 20];
sys3 = tf(num3, den)
x3 = step(sys3, t);

%plot
figure()
plot(t, x1,'LineStyle', ':', 'Color', 'r', 'LineWidth', 4)
grid on
hold on
plot(t, x2,'LineStyle', '--', 'Color', 'g', 'LineWidth', 2)
hold on
plot(t, x3,'LineStyle','-', 'Color', 'b', 'LineWidth', 1)
legend('Z = 5','Z = 10','Z = 15', 'FontSize', 15, 'Location','southeast')