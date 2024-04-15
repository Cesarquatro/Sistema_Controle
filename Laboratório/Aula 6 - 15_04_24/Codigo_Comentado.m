close all; clc; clear;

% Caio Maciel - 211270415;
% Cesar Augusto - 211270121;
% Lucas Morello - 211270315

% Define as matrizes do sistema em espaço de estados
A = [0,1,0,0;-0.0342,0,6.592,0.031;0,0,0,1;18.898,0,-0.344,-1.713];
B = [0;-0.0633;0;3.496];
C = [1,0,0,0;0,0,1,0];
D = [0; 0];

% Cria um objeto de sistema em espaço de estados
sys = ss(A,B,C,D);

% Define o tempo de amostragem e cria um vetor de tempo
Ts = 0.05;
t = 0.0:Ts:30.0;

% Converte o sistema contínuo para discreto
sysd = c2d(sys,Ts);

% Define a posição desejada e cria vetores para entrada e saída
posicao = 0.3;
rk = posicao*ones(1,length(t));
uk = zeros(1,length(t));

% Inicializa vetores de estados e saída
xk_1 = zeros(4,1);
xk = zeros(4,1);
yk = zeros(2,length(t));

% Placeholders para vetores F e V
F = [18.8391, 13.6225, 29.1229, 4.1561]; %insira aqui o vetor F
V = [12.0670, 0]; %insira aqui o vetor V

% Loop principal para simulação
for j = 1:length(rk)
    % Calcula a entrada uk com base na posição desejada, vetor V e estado atual
    uk(j) = (rk(j)*V(1)) - (F*xk);

    % Atualiza o estado anterior e calcula a saída
    xk_1 = (sysd.A*xk) + (sysd.B*uk(j));
    yk(:,j) = (sysd.C*xk) + (sysd.D*uk(j));

    % Atualiza o estado atual para a próxima iteração
    xk = xk_1;
end

% Plota os resultados
figure
subplot(3,1,1)
plot(t,uk,t,3*2.15*ones(1,length(t)),t,-3*2.15*ones(1,length(t)));
legend('força [N]','lim sup','lim inf');

subplot(3,1,2)
plot(t,rk,t,yk(1,:),t,yk(2,:),t,0.4*ones(1,length(t)),t,-0.4*ones(1,length(t)));
legend('ref pos [m]','posição [m]','posição gangorra [rad]','lim sup','lim inf');

subplot(3,1,3)
plot(t,yk(2,:)*180/pi,t,15*ones(1,length(t)),t,-15*ones(1,length(t))); %posição da gangorra em graus
legend('posição gangorra [graus]','lim sup','lim inf');
