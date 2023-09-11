p = [ 1 3 4 2];
r = roots(p)
%% (3s²+2s+1)(s+4)
p1 = [3 2 1]; d = [1 4];
x = conv(p1, d); % multiplicação de dois polinômios

%% calculando o valor do polinomio p/ s = -5
valor = polyval(x, -5);

%% Representar função de transferência 1
num1 = 10; den1 = [1 2 5];
sys1 = tf(num1, den1);

%% Representar função de transferência 2
num2 = 1; den2 = [1 1];
sys2 = tf(num2, den2);

%% Representar função de transferência resultante (sys1 + sys2)

sys = sys1 + sys2

%% Determinação dos pólos e zeros da FT
pp = pole(sys)
zz = zero(sys)

%% Função transferencia
G = sys1 / sys2

%% redução dos diagramas de blovcos
syss = series(sys1, sys2)
sysp = parallel(sys1, sys2)

%% realimentação
sysf = feedback(sys1, sys2)

%% resposta transitória
figure(1)
step(sysf)

%% Cancelamento de fatores em comum
figure(2)
sys_minreal = minreal(sysf)
pzmap(sys_minreal)