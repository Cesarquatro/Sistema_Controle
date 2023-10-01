close all; clc; clear;
%% Lista 2 - Ex 1
% Considere os dois polinômios
% p(s) = s² + 7s + 10
%         e
%    q(s) = s + 2.

p = [1 7 10];
q = [1 2];
% Calcule o seguinte:
%% (a) p(s)q(s)
a = conv(p, q)
disp('----------------------------')

%% (b) polos e zeros de G(s) = q(s) / p(s)
disp('(b)')
G = tf(q, p)

polos = pole(G)

zeros = zero(G)

%% (c) p(-1)
c = polyval(p, -1)
