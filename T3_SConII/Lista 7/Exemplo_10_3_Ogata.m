close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 1 Ogata
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% Exemplo 10.3) Considere o mesmo sistema discutido no Exemplo 10.1. 

A = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B = [0; 0; 1];

% Deseja-se que esse sistema regulador tenha polos de malha fechada em

mus = [-2 + 4i; -2 - 4i; -10];

% A matriz necessária de ganho K de realimentação de estado foi obtida no 
% Exemplo 10.1, como segue:

K = acker(A, B, mus);
% K = [199 55 8]

% Utilizando o MATLAB, obtemos a resposta do sistema à seguinte condição
% inicial: % x(0) = [1 0 0]ᵀ

% Resposta à condição inicial: para obter a resposta a uma dada condição 
% inicial x(0), substituímos u = –Kx na equação da planta para obter
% ẋ = (A - BK)x.
% Para exibir as curvas de resposta (x₁ versus t, x₂ versus t e x₃ versus
% t), podemos utilizar o comando initial. Primeiro, definimos as equações
% do sistema no espaço de estados, como segue: ẋ = (A – BK)x + Iu, 
% y = Ix + Iu
% onde incluímos u (um vetor de entrada de dimensão 3). Esse vetor u é 
% considerado 0 no cálculo da resposta à condição inicial. Então, 
% definimos:

sys = ss(A - B*K, eye(3), eye(3), eye(3));

% e utilizamos o comando initial como, onde t é o intervalo de tempo que 
% desejamos utilizar, como

t = 0:0.01:4;

x = initial(sys, [1;0;0],t);

% Então, obtemos x₁, x₂ e x₃, como segue:

x1 = [1 0 0]*x';
x2 = [0 1 0]*x';
x3 = [0 0 1]*x';

% Utilizamos o comando plot. Esse programa é mostrado no Programa 10.3 em 
% MATLAB. As curvas de resposta resultantes são mostradas na Figura 10.3.

subplot(3,1,1); plot(t,x1), grid
title("Resposta à condição inicial")
ylabel("variável de estado x₁")
subplot(3,1,2); plot(t,x2), grid
ylabel("variável de estado x₂")
subplot(3,1,3); plot(t,x3), grid
xlabel("t [s]")
ylabel("variável de estado x₃")