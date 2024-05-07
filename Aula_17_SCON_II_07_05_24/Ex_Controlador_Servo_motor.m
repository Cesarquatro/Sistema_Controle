close all; clc; clear;
%% Aula de Scon II - 07/05/2024
% Projeto do controlador de um servo motor utilizando alocação de polos

%% Variáveis
Ra = 0.6;   % [Ω]
La = 12e-3; % [H]
Kphi = 1.8; % [Nm/A]
J = 1;     % [kg m²/s]
b = 0.01;   % [Nm/s]
W0 = 0;     % [rad/s]
n_voltas = 1.5; % Variável de referência

plotar = 0;

%% Matrizes de estado

A = [0, 1, 0; 0, -b/J, Kphi/J; 0, -Kphi/La, -Ra/La];
B = [0; 0; 1/La];
C = [1, 0, 0];
D = 0;

%% Representação em Espaço de Estados (ss)
sys = ss(A, B, C, D);

%% Função Transferência
TF = tf(sys);
TF = zpk(TF);

%% Projeto de K por Ackermann
% Alocação de polos de forma arbitrária (Critério de Projetos)
mus = [-5 + 0.1i; -5 - 0.1i; -30]; 

K = acker(A, B, mus);
% K = place(A, B, mus) faz a mesma coisa por outro método

%% Simulação do sistema não compensado
t = 0:0.01:20;
u = ones(1, length(t));

% Simuação do sistema não compensado
[y, T, x] = lsim(sys, u, t);

Ahat = A-B*K;
Bhat = B*K(1);

sysc = ss(Ahat, Bhat, C, D);
eig(A);    % Auto valores de A
eig(Ahat); % Auto valores de Ahat

theta_ref = (n_voltas) * 2 * pi;     % [rad]

% para o sistema compensado, a entrada é r e não u
r = (theta_ref).*ones(1, length(t));

% Simuação do sistema compensado
[y2, T2, x2] = lsim(sysc, r, t);


%% Apêndice
% Dica: commando 'whos u' me fala quem é u
% Dica: commando 'help ss' me explica como funciona a função

if plotar == 1
    subplot(2,3,1);  % subplot(n_linhas,n_colunas,janela_de_plot)
    plot(t, x(:,1)); % plotando todas as linhas da 1ª coluna
    ylabel("[rad]");
    xlabel("[s]");
    title("θ não compensado")
    grid on;
    
    subplot(2,3,2);  % subplot(n_linhas,n_colunas,janela_de_plot)
    plot(t, x(:,2).*(30/pi)); % plotando todas as linhas da 2ª coluna
    ylabel("[rpm]");
    xlabel("[s]");
    title("ω não compensado")
    grid on;

    subplot(2,3,3);  % subplot(n_linhas,n_colunas,janela_de_plot)
    plot(t, x(:,3)); % plotando todas as linhas da 3ª coluna
    ylabel("[A]");
    xlabel("[s]");
    title("i não compensado")
    grid on;

    subplot(2,3,4);  % subplot(n_linhas,n_colunas,janela_de_plot)
    plot(t, x2(:,1)); % plotando todas as linhas da 1ª coluna
    ylabel("[rad]");
    xlabel("[s]");
    title("θ compensado")
    grid on;
    hold on;
    yline(theta_ref);
    legend("\theta", "\theta_{ref}", Loc="best")

    subplot(2,3,5);  % subplot(n_linhas,n_colunas,janela_de_plot)
    plot(t, x2(:,2)); % plotando todas as linhas da 3ª coluna
    ylabel("[rpm]");
    xlabel("[s]");
    title("ω compensado")
    grid on;
    
    subplot(2,3,6);  % subplot(n_linhas,n_colunas,janela_de_plot)
    plot(t, x2(:,3)); % plotando todas as linhas da 3ª coluna
    ylabel("[A]");
    xlabel("[s]");
    title("i compensado")
    grid on;
end

%% Valores das variaveis em regime permanente

X = -inv(A-B*K)*B*K*r(1) % \ calcula a matriz inversa
%U = -K*X+K(1)*r


