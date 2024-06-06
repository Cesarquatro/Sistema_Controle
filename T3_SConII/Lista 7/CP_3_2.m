close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 3 Dorf 12a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% CP3.2) Determine a transfer function representation for the following
% state variable models using the tf function:
%% (a) 
A = [0, 1; 2, 8];
B = [0; 1];
C = [0, 1];
D = 0;

sys_a = ss(A, B, C, D);

disp("(a)")
tf_a = tf(sys_a)
disp("--------------------------------------------")

%% (b) 
A = [1, 1, 0; -2, 0, 4; 5, 4, -7];
B = [-1; 0; 1];
C = [0, 1, 0];
D = 0;

sys_b = ss(A, B, C, D);

disp("(b)")
tf_b = tf(sys_b)
disp("--------------------------------------------")

%% (c) 
A = [0, 1; -1, -2];
B = [0; 1];
C = [-2, 1];
D = 0;

sys_c = ss(A, B, C, D);

disp("(c)")
tf_c = tf(sys_c)
disp("--------------------------------------------")