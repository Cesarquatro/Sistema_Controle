%Caio Maciel    211270415
%Cesar Augusto  211270121
%Lucas Morello  211270351
%%
%Limpar a Command Window e limpar as variáveis do WorlSpace
clear
clc
%Coeficientes da transformação bilinear na função transferência:
a = [1	-2.76940133037694	2.54767184035477	-0.778270509977827];
b = [0.000110864745011097	0.000332594235032957	0.000332594235033845	0.000110864745010764];
%Criação de uma matriz de n x n, na qual os elementos são zeros
x = zeros(4,1);
y = zeros(4,1);
%Frequência de amostragem
fs = 20;
Ts = 1/fs;
%Discretização
t = 0.0:Ts:20.0;
ref = ones(1,length(t));
saida = zeros(1,length(t));
%Parâmetros obtidos do controlador em avanço de fase para a função transferência
K = 83.535;
z = 0.821555;
p = 34.3143;
a0 = (2/Ts)+p;
a1 = -(2/Ts)+p;
b0 = K*((2/Ts)+z);
b1 = K*(-(2/Ts)+z);
erro = zeros(1,2);
u = zeros(1,2);
for j = 1:length(t)
    erro(2) = erro(1);
    erro(1) = ref(j) - y(1);
    u(2) = u(1);
    u(1) = (1.0/a0)*(b0*erro(1) + b1*erro(2) - a1*u(2));
    x(4) = x(3);
    x(3) = x(2);
    x(2) = x(1);
    x(1) = u(1);
    y(4) = y(3);
    y(3) = y(2);
    y(2) = y(1);
    y(1) = (b(1)*x(1))+(b(2)*x(2))+(b(3)*x(3))+(b(4)*x(4))-(a(2)*y(2))-(a(3)*y(3))-(a(4)*y(4));
    saida(j) = y(1);
end
figure
plot(t,ref,t,saida);