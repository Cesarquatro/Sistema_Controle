%Caio Maciel - 211270415
%Cesar Augusto - 211270121
%Lucas Morello - 211270351

clear
clc


a = [1	-3.54717910815472	4.70165065287017	-2.75979305247598	0.605321507760533];
b = [1.53978812514888e-05	6.15915250063992e-05	9.23872875091547e-05	6.15915250068433e-05	1.53978812515998e-05];

x = zeros(5,1);
y = zeros(5,1);

fs = 20;
Ts = 1/fs;

t = 0.0:Ts:60.0;
ref = ones(1,length(t));
saida = zeros(1,length(t));
kp = 0.146155;
ki = 0.0105983;
kd=0.441645;


q0 = kp + ki*(Ts/2);
q1 = -kp + ki*(Ts/2);

erro = zeros(1,3);
u = zeros(1,2);


for j = 1:length(t)
    erro(3) = erro(2);
    erro(2) = erro(1);
    erro(1) = ref(j) - y(1);

    u(2) = u(1);
    u(1) = (q0*erro(1)) + (q1*erro(2))  + u(2);
    x(5) = x(4);
    x(4) = x(3);
    x(3) = x(2);
    x(2) = x(1);
    x(1) = u(1);

    y(5) = y(4);
    y(4) = y(3);
    y(3) = y(2);
    y(2) = y(1);
    y(1) = (b(1)*x(1))+(b(2)*x(2))+(b(3)*x(3))+(b(4)*x(4))+(b(5)*x(5))-(a(2)*y(2))-(a(3)*y(3))-(a(4)*y(4))-(a(5)*y(5));
    saida(j) = y(1);
end

figure
plot(t,ref,t,saida);