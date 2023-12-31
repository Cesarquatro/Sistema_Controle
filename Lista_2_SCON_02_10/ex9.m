close all; clc; clear;
%% Lista 2 - Ex 9
% Considere o sistema de controle com realimentação na figura abaixo em que
% G(s) = s + 1 / s + 2 e H(s) = 1 / s + 1
num_G = [1 1];
den_G = [1 2];
G = tf(num_G, den_G)

num_H = 1;
den_H = [1 1];
H = tf(num_H, den_H)

%% (a) Usando uma sequência de intruções, determine a função tranferência
% em malha fechada.
disp('----------------------------')
disp('(a)')
sys = feedback(G, H, -1)

%% (b) Obtenha o diagrama de polos e zeros usando a função pzmap. Onde 
% estão os polos e zeros do sistema em malha fechada?
pzmap(sys)
grid on

%% (c) Existe algum cancelamento de polos e zeros? Se existe, use a função
% minreal para cancelar os polos e zeros em comum na função transferência
% em uma malha fechada.
disp('----------------------------')
disp('(c):')
nova_funcao_transferencia = minreal(sys)

polos = pole(sys)
zeros = zero(sys)

%% (d) Por que é importante cancelar os polos e zeros em comum na função
% transferência?

