close all; clc; clear;

%%
M = 2;      % Massa do carro
m = 0.1;    % Massa do pêndulo
l = 0.5;    % Comprimento da haste
g = 9.81;   % Gravidade

% SS
A = [0, 1 ,0 ,0 ; (M+m)*g/(M*l), 0, 0, 0; 0, 0, 0, 1; -m*g/M, 0, 0, 0 ];
B = [0; -1/(M*l); 0; 1/M]
C = [0, 0, 1, 0];
D = 0;

sys = ss(A, B, C, D);

%% Definição das matrizes de interesse para controle
%  Lembrando que o sistema possui uma var de estado adicional ξ = (\xi)
Ae = [A, zeros(4,1); -C, 0]
Be = [B; 0]

% Checando controlabilidade do sistema
matrizControlabilidade = ctrb(Ae, Be); % n = (n de A) +1
rho = rank(matrizControlabilidade);    % posto dever ser = (n de A) + 1, 
                                       % por conta do ξ
matrizControlabilidade2 = [A, B; -C, 0];
rho2 = rank(matrizControlabilidade2);

%% escolha dos polos - lembre que o sistema é de ordem 5 agora
%  vamos selecionar os polos pelo sisotool
mu1 = -1+1i;
mu2 = -1-1i;
mu3 = -10;
mu4 = -10;
mu5 = -10;

mu = [mu1, mu2, mu3, mu4, mu5];

%% Determinção do vetor K

Kc = acker(Ae, Be, mu); % esse Kc contém K e Ki
% Place não funciona para polos repetidos

K = Kc(1:4);   % 
Ki = -Kc(5);   % Ganho para o ξ

% calculando a resposta ao degrau do sistema
Acomp = [A-(B*K), B*Ki; -C, 0];
Bcomp = [zeros(4,1); 1];
Ccomp = [C, 0];
Dcomp = 0;

%% ss novo - novo sistema
sysNew = ss(Acomp, Bcomp, Ccomp, Dcomp)

%% Simulação do sistema
t = 0:0.02:10;
[y, T, x] = step(sysNew,t);

%% Plot das variáveis
legendas = ["θ", "ω", "x", "v", "ξ"];


for janela = 1:length(Acomp)
    subplot(2,3, janela);
    plot(t, x(:,janela));
    legend(legendas(janela));
    grid on;
end