%Definição de Parametros
r = 6;
l= 10e-3;
c = 4.7e-3;

%Definição de Numerador e Denominador
num = [r*l 0];
denom = [r*l*c l r];

%Função Transferência
system = tf(num,denom)

%Degrau
figure(1)
step(system)