t = 0.0:Ts:10.0;

posicao = 0.4;

rk = posicao*ones(1,length(t));
uk = zeros(1,length(t));

xk_1 = zeros(4,1);
xk = zeros(4,1);
yk = zeros(2,length(t));

nk_1 = zeros(2,1);
nk = zeros(2,1);
xk_red = zeros(2,length(t));
estados = zeros(4,1);

xk_obs1 = zeros(4,1);
xk_obs = zeros(4,1);
estados_full = zeros(4,length(t));

for j = 1:length(rk)
    
    uk(j) = (rk(j)*V(1)) - (F*estados);%(F*estados); 

    
    xk_1 = (sysd.A*xk) + (sysd.B*uk(j));
    yk(:,j) = (sysd.C*xk) + (sysd.D*uk(j));

    xk = xk_1;
    
    nk_1 = (Aored*nk)+(Bred*uk(j))+(Fred*yk(:,j));
    xk_red(:,j) = nk + (Lred*yk(:,j));
    estados = [yk(1,j); xk_red(1,j); yk(2,j); xk_red(2,j)];

    nk = nk_1;

    
    xk_obs1 = (Aobs*xk_obs)+(sysd.B*uk(j))+(L*yk(1,j));

    xk_obs = xk_obs1;
    estados_full(:,j) = xk_obs;
end

% resultados
figure
subplot(4,1,1)
plot(t,uk,t,20*ones(1,length(t)),t,-20*ones(1,length(t)));
legend('força [N]','lim sup','lim inf');
subplot(4,1,2)
plot(t,rk,t,yk(1,:),t,yk(2,:),t,0.5*ones(1,length(t)),t,-0.5*ones(1,length(t)));
legend('ref pos [m]','posição [m]','posição pêndulo [rad]','lim sup','lim inf');
subplot(4,1,3)
plot(t,yk(2,:)*180/pi,t,10*ones(1,length(t)),t,-10*ones(1,length(t))); %posição do pêndulo em graus
legend('posição pêndulo [graus]','lim sup','lim inf');
subplot(4,1,4)
plot(t,yk(1,:),t,xk_red(1,:),t,yk(2,:),t,xk_red(2,:));
legend('posição [m]','velocidade [m/s]','posição pêndulo [rad]','veloc ang pêndulo [rad/s]');