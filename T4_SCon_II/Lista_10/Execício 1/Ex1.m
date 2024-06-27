clear; close all; clc;
%% Considere que um sistema de controle com realimentação de estados obser-
% vados, tal como apresentado na figura 1. O sistema é modelado em espaço
% de estados, de forma que as matrizes
% A, B, C, D são definidas por:

% I) Espaço de Estados
A = [0, 1; -10.5, -11.3];
B = [0; 0.55];
C = [1, 0];
D = 0;

sys = ss(A,B,C,D);
Gs = tf(sys);

% II) Frações parciais para descobrir o tipo do sistema
zpk(Gs)

% Podemos ver que o sistema não possui integrador, logo é de tipo 0.
% ∴ Será necessário utilizar ξ

% III) Verficicar a controlabilidade
if rank(ctrb(A,B)) == size(A,1)
    disp('É controlável.')
else
    disp('Não é controlável.')
end

% IV) Verficicar a observabilidade
if rank(obsv(A,C)) == size(A,1)
    disp('É Observável.')
else
    disp('Não é Observável.')
end

if rank(obsv(A,C)) == size(A,1) && rank(ctrb(A,B)) == size(A,1)
    disp('∴ Realização mínima!')
end
%% V) Projeto de K por meio de alocação de polos
% Novas matrizes após a adição da variável de estados ξ
Ae = [A, zeros(2,1);
     -C, 0];
Be = [B; 0];
Ce = [C, 0];
De = 0;

% VI) Verifiquemos a nova controlabilidade do sistema
if rank(ctrb(Ae,Be)) == size(Ae,1)
    disp('Sys com ξ é controlável.')
else
    disp('Sys com ξ não é controlável.')
end

% VII) Escolhas de polos do controlador usando o sisotool para atender os
% critérios de projeto:
% -MUP < 5%
% - Settling Time < 1s
p1 = -4 + 4i;
p2 = -4 - 4i;
p3 = -40;         % Polo para ξ
p = [p1, p2, p3]; % Vetor de polos que atendem critérios de desempenho

% VIII) Escolhas de polos do observador usando o sisotool para atender os
% critérios de projeto (3 à 8 vezes maior):
po1 = -12 + 4i;
po2 = -12 - 4i;
po = [po1, po2];

% IX) K e Ke
Kc = acker(Ae,Be,p); % Controlador

K = Kc(1:2);  
Ki = -Kc(3);   

% X) Observador pelo teorema da dualidade
sys_dual = ss(A',C', B', D');             % Sys dual
Ke = acker(sys_dual.A, sys_dual.B, po')'; % Ke

% XI) Verificar estabilidade do controlador-observador
A_gco = A - Ke*C - B*K;
B_gco = B * Ki;
C_gco = C;
D_gco = D;

sys_gco = ss(A_gco, B_gco, C_gco, D_gco); % Espaço de estadoso CO

eig(A_gco) % Estável

% XII) Simulção
t = 0:0.01:10;
u = ones(length(t),1);

[y, t, xgco] = lsim(sys_gco, u, t);

% Plotagem dos resultados
figure;

% Subplot para x1
subplot(3,1,1);
plot(t, xgco(:, 1));
title('Estado x_1');
xlabel('Tempo (s)');
ylabel('x_1(t)');
grid on;

% Subplot para x2
subplot(3,1,2);
plot(t, xgco(:, 2));
title('Estado x_2');
xlabel('Tempo (s)');
ylabel('x_2(t)');
grid on;

% Subplot para a saída
subplot(3,1,3);
plot(t, y);
title('Resposta do sistema controlado-observado');
xlabel('Tempo (s)');
ylabel('Saída y(t)');
grid on;
