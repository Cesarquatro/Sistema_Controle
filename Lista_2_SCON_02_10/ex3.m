close all; clc; clear;
%% Lista 2 - Ex 3
% Considere a equação diferencial:
%        y'' + 4y' + 3y = u
% em que y(0) = y'(0) = 0 e u(t) é um degrau unitário. 
% Determine a solução y(t) analiticamente e verifique-a 
% traçando em um gráfico a solução analítica e a resposta 
% ao degrau obtida com a função step.
% (figura) 

num = 1; 
den = [1 4 3];
sys = tf(num, den)

t = 0:0.1:10;
ut = step(sys, t); % degrau unitário
yt = 1/3 - 1/2*exp(-t) + 1/6*exp(-3*t);

%plot
plot(t, ut,'-', 'Color', 'r', 'LineWidth', 8)
hold on
plot(t, yt, '--', 'Color', 'c', 'LineWidth', 2)

grid on;

title('Verificação','FontSize',20);
xlabel('Tempo [s]', 'FontSize',15);
ylabel('Amplitude','FontSize',15);
legend('Resposta do sistema ao degrau unitário u(t)', ...
    'Solução y(t) obtida analiticamente', ...
    'Location','southeast', 'FontSize',15)