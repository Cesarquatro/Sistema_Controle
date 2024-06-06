close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 1 Ogata 5a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% Exemplo 10.2) Considere o mesmo sistema que foi considerado no Exemplo 
% 10.1. A equação do sistema é ẋ = Ax + Bu onde

A = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B = [0; 0; 1];

% Utilizando-se o controle por realimentação de estado u = –Kx, deseja-se
% obter os polos de malha fechada em s = mi (i = 1, 2, 3), onde 
% μ1 = – 2 + j4, μ2 = – 2 – j4, μ3 = – 10
% Determine com o MATLAB a matriz de ganho K de realimentação de estado.

mus = [-2 + 4i; -2 - 4i; -10];

KAcker = acker(A, B, mus)
Kplace = place(A, B, mus)