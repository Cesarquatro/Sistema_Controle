close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 2 Ogata 5a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% B.10.7) Resolva o Problema 10.6 com o MATLAB.

% B.10.6) Um sistema regulador tem a planta:
% Y(s)               10
% ----  =   ---------------------
% U(s)      (s + 1)(s + 2)(s + 3)

% Defina as variáveis de estado como:x1 = y; x2 = ẋ1; x3 = ẋ2
% Usando-se o controle de realimentação de estado u = –Kx, desejamos
% localizar os polos de malha fechada em:

p = [-2+2*(sqrt(3))*1i, -2 - 2*(sqrt(3))*1i, -10];

A = [0, 1, 0; 0, 0, 1; -6, -11, -6];
B = [0; 0; 10];

K = acker(A, B, p)
