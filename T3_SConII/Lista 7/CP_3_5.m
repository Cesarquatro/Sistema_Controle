close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 3 Dorf 12a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% CP3.5) Consider the two systems:
A1 = [0, 1, 0; 0, 0, 1; -4, -5, -8];
B1 = [0; 0; 4];
C1 = [1, 0, 0];
D1 = 0;

% and
A2 = [ 0.5,  0.5, 0.7071;
      -0.5, -0.5, 0.7071;
      -6.3640, -0.7071, -8];
B2 = [0; 0; 4];
C2 = [0.7071, -0.7071, 0];
D2 = 0;

%% (a) Using the tf function, determine the transfer function Y(s)/U(s)
%  for system (1).
sys1 = ss(A1, B1, C1, D1);

disp("(a)")
Gs1 = tf(sys1)
disp("--------------------------------------------")

%% (b) Repeat part (a) for system (2).
sys2 = ss(A2, B2, C2, D2);

disp("(b)")
Gs2 = tf(sys2)
disp("--------------------------------------------")

%% (c) Compare the results in parts (a) and (b) and comment.
disp("(c)")
fprintf("Ambas os espaços de estados são realizações canônicas da mesma\n" + ...
        "função transferência.")