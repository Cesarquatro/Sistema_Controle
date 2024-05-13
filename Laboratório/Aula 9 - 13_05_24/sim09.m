t = 0.0:Ts:10.0;

posicao = -0.3;

rk = posicao*ones(1,length(t));
uk = zeros(1,length(t));

xk_1 = zeros(4,1);
xk = zeros(4,1);
yk = zeros(2,length(t));


for j = 1:length(rk)

    uk(j) = (rk(j)*V(1)) - (F*xk);

    xk_1 = (sysd.A*xk) + (sysd.B*uk(j));
    yk(:,j) = (sysd.C*xk) + (sysd.D*uk(j));

    xk = xk_1;
    
end

figure
subplot(3,1,1)
plot(t,uk,t,20*ones(1,length(t)),t,-20*ones(1,length(t)));
legend('força [N]','lim sup','lim inf');
subplot(3,1,2)
plot(t,rk,t,yk(1,:),t,yk(2,:),t,0.5*ones(1,length(t)),t,-0.5*ones(1,length(t)));
legend('ref pos [m]','posição [m]','posição pêndulo [rad]','lim sup','lim inf');
subplot(3,1,3)
plot(t,yk(2,:)*180/pi,t,10*ones(1,length(t)),t,-10*ones(1,length(t))); %posição do pêndulo em graus
legend('posição pêndulo [graus]','lim sup','lim inf');