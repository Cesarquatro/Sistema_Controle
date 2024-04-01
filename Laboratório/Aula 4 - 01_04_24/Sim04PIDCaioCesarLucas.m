% Caio Alencar Maciel                    211270415
% Cesar Augusto Mendes Cordeiro da Silva 211270121
% Lucas Martins Morello                  211270351

%%
clear;
clc; 

% Coeficientes do denominador da função de transferência G(s)
a = [1	-3.54717910815472	4.70165065287017	-2.75979305247598	0.605321507760533];
% Coeficientes do numerador da função de transferência G(s)
b = [1.53978812514888e-05	6.15915250063992e-05	9.23872875091547e-05	6.15915250068433e-05	1.53978812515998e-05];

x = zeros(5,1);
y = zeros(5,1);

fs = 20; % Frequência de amostragem (Hz)
Ts = 1/fs; % Período de amostragem (s)

t = 0.0:Ts:60.0; % Vetor de tempo
ref = ones(1,length(t)); % Vetor de referência do sistema
saida = zeros(1,length(t)); % Vetor de saída do sistema

% Parâmetros do controlador PID
kp = 0.613155; 
ki = 0.01;
kd = 0.441645;

% Parâmetros do controlador PID para o cálculo do sinal de controle
q0 = kp + (ki*Ts/2) + (kd/Ts);
q1 = -kp + (ki*Ts/2) - (kd*2/Ts);
q2 = (kd/Ts);

% Vetor de erro (utilizado para armazenar os erros passados do sistema)
erro = zeros(1,3);
% Vetor de controle (utilizado para armazenar os valores de controle passados)
u = zeros(1,2);

% Loop principal da simulação
for j = 1:length(t)
    erro(3) = erro(2);
    erro(2) = erro(1);
    erro(1) = ref(j) - y(1);

    u(2) = u(1);
    u(1) = (q0*erro(1)) + (q1*erro(2)) + (q2*erro(3)) + u(2);

    x(5) = x(4);
    x(4) = x(3);
    x(3) = x(2);
    x(2) = x(1);
    x(1) = u(1);

    y(5) = y(4);
    y(4) = y(3);
    y(3) = y(2);
    y(2) = y(1);
    % Cálculo da saída do sistema
    y(1) = (b(1)*x(1))+(b(2)*x(2))+(b(3)*x(3))+(b(4)*x(4))+(b(5)*x(5))-(a(2)*y(2))-(a(3)*y(3))-(a(4)*y(4))-(a(5)*y(5));
    saida(j) = y(1);
end

% Plotagem do resultado da simulação
figure
plot(t,ref,t,saida);
xlabel('Tempo (s)');
ylabel('Amplitude');
legend('Referência','Saída');
title('Resposta do Sistema');
