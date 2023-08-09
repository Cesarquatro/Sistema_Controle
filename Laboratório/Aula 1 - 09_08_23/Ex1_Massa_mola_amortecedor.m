clear; close all; clc
%% Modelo massa mola amortecedor
% função transferencia:
% Y(s) / R(s) = 1 / M.s² + b.s 
%  Dados

M = 1; %[Kg]
b = 10; %[N.s/m]
K = 100; %[N/m]

% Definindo os parâmetros do sistema de primeira ordem
numerator = 1;     % Coeficientes do numerador da função de transferência
denominator = [M, b, K]; % Coeficientes do denominador da função de transferência

system = tf(numerator, denominator) % Criando o sistema de primeira ordem

% Calculando a resposta ao impulso
impulse_response = impulse(system);

% Traçando a resposta ao impulso
plot(impulse_response);
title('Resposta ao Impulso de um Sistema Massa-mola c/ amortecedor');
xlabel('Tempo [s]');
ylabel('Força [N]');