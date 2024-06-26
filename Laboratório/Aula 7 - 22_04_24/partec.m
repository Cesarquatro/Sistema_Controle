% Caio Maciel    211270415
% Cesar Augusto  211270121
% Lucas Morello  211270351

clear
clc

ParteA_CaioCesarLucas

% Crianção das varíaveis de Estado
sys = ss(A,B,C,D);

% Criando os vetoes e o tempo para cretização do sistema
Ts = 0.05;
t = 0.0:Ts:30.0;

% Convertendo o sistema do domínio contínuo para o discreto 
sysd = c2d(sys,Ts,'tustin');

% Posição desejada da bola
posicao = 0.3;

% Criação dos vetores de resposat e entrada do sistema
rk = posicao*ones(1,length(t));
uk = zeros(1,length(t));

% Criação da matriz de estados 
xk_1 = zeros(4,1);
xk = zeros(4,1);
yk = zeros(2,length(t));

% Criação da matriz de estados 
nk_1 = zeros(2,1);
nk = zeros(2,1);
xk_obs = zeros(2,length(t));
estados = zeros(4,1);

% F = ; %insira aqui o vetor F
% V = ; %insira aqui o vetor V

% Aored = ; %insira aqui a matriz Aored
% Bred = ; %insira aqui a matriz Bred
% Fred = ; %insira aqui a matriz Fred
% Lred = ; %insira aqui a matriz Lred

% loop de simulação
for j = 1:length(rk)
    % realimentação
    uk(j) = (rk(j)*V(1)) - (F*estados);

    % modelo do sistema físico em malha aberta para calcular x1 e x3
    xk_1 = (sysd.A*xk) + (sysd.B*uk(j));
    yk(:,j) = (sysd.C*xk) + (sysd.D*uk(j)); %posição da bola (x1) e posição da gangorra (x3)

    xk = xk_1;
    
    % observador de estados
    nk_1 = (Aored*nk)+(Bred*uk(j))+(Fred*yk(:,j));
    xk_obs(:,j) = nk + (Lred*yk(:,j));
    estados = [yk(1,j); xk_obs(1,j); yk(2,j); xk_obs(2,j)];

    nk = nk_1;
end

% resultados
figure
subplot(4,1,1)
plot(t,uk,t,3*2.15*ones(1,length(t)),t,-3*2.15*ones(1,length(t)));
legend('força [N]','lim sup','lim inf');
subplot(4,1,2)
plot(t,rk,t,yk(1,:),t,yk(2,:),t,0.4*ones(1,length(t)),t,-0.4*ones(1,length(t)));
legend('ref pos [m]','posição [m]','posição gangorra [rad]','lim sup','lim inf');
subplot(4,1,3)
plot(t,yk(2,:)*180/pi,t,15*ones(1,length(t)),t,-15*ones(1,length(t)));
legend('posição gangorra [graus]','lim sup','lim inf');
subplot(4,1,4)
plot(t,yk(1,:),t,xk_obs(1,:),t,yk(2,:),t,xk_obs(2,:));
legend('posição [m]','velocidade [m/s]','posição gangorra [rad]','veloc ang gangorra [rad/s]');