close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 3 Dorf 12a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% CP3.1) Determine a state variable representation for the following
% transfer functions (without feedback) using the SS function:
%% (a) G(s) = 1 / (s+10)
num = 1;
den = [1, 10];

sys_a = tf(num, den);

disp("(a)")
ss_a = ss(sys_a)
disp("--------------------------------------------")

%% (b) G(s) = (s²+5s+3) / (s²+8s+5)
num = [1, 5, 3];
den = [1, 8, 5];

sys_c = tf(num, den);

disp("(b)")
ss_b = ss(sys_c)
disp("--------------------------------------------")

%% (c) G(s) = (s+1) / (s³+3s²+3s+1)
num = [1, 1];
den = [1, 3, 3, 1];

sys_c = tf(num, den);

disp("(c)")
ss_c = ss(sys_c)
disp("--------------------------------------------")