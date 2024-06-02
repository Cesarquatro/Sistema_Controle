close all; clc; clear all;
%% Ogata B.9.10
num1 = [10.4 47 160];
den1 = [1 14 56 160];

sys1 = tf(num1, den1);
pol = pole(sys1);
zer = zero(sys1);

% Não há cancelamento de polos e zeros
[A,B,C,D] = tf2ss(num1, den1);

%Matriz de controlabilidade
Con1 = [B, A*B, (A^2)*B];
posto_Con1 = rank(Con1); % Posto de ₵ = 3 ∴ Totalmente controlável

%Matriz de observbilidade
Ob1 = [C', A'*C', ((A')^2)*C'];
posto_Ob1 = rank(Ob1);   % Posto de ∅ = 3 ∴ Totalmente observável

% ∴ é a realização mínima
%% Ogata B.9.11
A2 = [0, 1, 0; -1, -1, 0; 1, 0, 0];
B2 = [0; 1; 0];
C2 = [0, 0,  1];
D2 = 0;

sys2 = ss(A2, B2, C2, D2);

[num2, den2] = ss2tf(A2, B2, C2, D2);

sys2_tf = tf(num2, den2);

%Matriz de controlabilidade
Con2 = [B2, A2*B2, (A2^2)*B2];
posto_Con2 = rank(Con2); % Posto de ₵ = 3 ∴ Totalmente controlável

%Matriz de observbilidade
Ob2 = [C2', A2'*C2', ((A2')^2)*C2'];
posto_Ob2 = rank(Ob2);   % Posto de ∅ = 3 ∴ Totalmente observável

% ∴ é a realização mínima
%% Ogata B.9.12
A3 = [2, 1, 0; 0, 2, 0; 0, 1, 3];
B3 = [0, 1; 1, 0; 0, 1];
C3 = [1, 0, 0];
D3 = [0, 0];

sys3 = ss(A3, B3, C3, D3);

% G(s) para input 1
[num3, den3] = ss2tf(A3, B3, C3, D3, 1);

sys3_tf = tf(num3, den3);

% G(s) para input 2
[num4, den4] = ss2tf(A3, B3, C3, D3, 2);

sys4_tf = tf(num4, den4);

%Matriz de controlabilidade
Con3 = [B3, A3*B3, (A3^2)*B3];
posto_Con3 = rank(Con3); % Posto de ₵ = 3 ∴ Totalmente controlável

%Matriz de observbilidade
Ob3 = [C3', A2'*C3', ((A3')^2)*C3'];
posto_Ob3 = rank(Ob3);   % Posto de ∅ = 2 ∴ Não é totalmente observável

% Analise do G(s) input 1:
pol3 = pole(sys3_tf);
zer3 = zero(sys3_tf);

% Analise do G(s) input 2:
pol4 = pole(sys4_tf);
zer4 = zero(sys4_tf);