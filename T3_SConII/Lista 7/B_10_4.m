close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 2 Ogata 5a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% B.10.4) Resolva o Problema 10.3 com o MATLAB.
% B.10.3) Considere o sistema definido por: ẋ = Ax + Bu e y = Cx onde

A = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B = [0; 1; 1];

%Usando o controle de realimentação de estado u = –Kx, desejamos ter os
% polos de malha fechada em s = – 2 ± j4, s = – 10. Determine a matriz
% de ganho K de realimentação de estado.

p = [-2 + 4i, -2 - 4i, -10];

%% Resolução
K = acker(A, B, p);