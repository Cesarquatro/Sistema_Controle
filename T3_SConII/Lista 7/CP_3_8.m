close all; clc; clear;
%% T3 - SCon II - Lista 7 - Exercício 3 Dorf 12a
% Cesar Augusto Mendes Cordeiro da Silva    211270121

% CP3.8) Consider the state variable model with parameter K given by

% A = [0, 1, 0; 0, 0, 1; -2, -K, -2];

% Plot the characteristic values of the system as a function of K in
% the range 0 ≤ K ≤ 100. Determine that range of K for which all the
% characteristic values he in the left half-plane.
K = 0:0.1:100;

estabilidade = (zeros(1,length(K)));

figure(1)
title("Estabilidade para diferente valores de K");
ylabel("i", Rotation=0);
xlabel("R");
hold on;
grid on

xline(0, 'k', 'LineWidth', 2); % Linha vertical em x = 0
yline(0, 'k', 'LineWidth', 2); % Linha horizontal em y = 0

% estabilidade = (zeros(1,length(K)));
for ii = 1:length(K)
 A = [0, 1, 0; 0, 0, 1; -2, -K(ii), -2];
 B = [0; 0; 1];
 C = [1, 0, 0];
 D = 0;
 sys = ss(A,B,C,D);
 polos = eig(A);
 % estabilidade(ii) = isstable(sys); % Verifica estabilidade do sistema
 % pzmap(sys); % Plota os polos e os zeros

 plot(polos, LineStyle="none", Marker="X", MarkerSize=10, LineWidth=2) 
end
