close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 3 Dorf 12a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% CP3.6a) Consider the closed-loop control system in Figure CP3.6.
% (a) Determine a state variable representation of the controller.
num = 3;
den = [1, 3];

Gcon = tf(num, den);

disp("(a)")
Controler = ss(Gcon)