% Caio Maciel    211270415
% Cesar Augusto  211270121
% Lucas Morello  211270351
%% 
clear           % Limpa o espaço de trabalho
clc             % Limpa a janela de comando

d = daq("ni");  % Cria um objeto da Caixa de Ferramentas de Aquisição de Dados para hardware da National Instruments

% Adiciona Canais de Entrada
ch1 = addinput(d,"Dev1","ai0","Voltage");    % Adiciona um canal de entrada analógica (ai0) para medição de voltagem
ch1.TerminalConfig = "SingleEnded";          % Configura o terminal para medição single-ended

ch2 = addinput(d,"Dev1","ai1","Voltage");    % Adiciona outro canal de entrada analógica (ai1) para medição de voltagem
ch2.TerminalConfig = "SingleEnded";          % Configura o terminal para medição single-ended

% Adiciona Canal de Saída
addoutput(d,"Dev1","ao0","Voltage");         % Adiciona um canal de saída analógica (ao0) para saída de voltagem

d.Rate = 1000;                                % Define a taxa de amostragem para 1000 amostras por segundo
Ts = 1/d.Rate;                                % Calcula o período de amostragem
t = 0.0:Ts:20.0;                              % Cria um vetor de tempo de 0 a 20 segundos com o período de amostragem dado
rotacao = 3000*pi/30;                         % Calcula a taxa de rotação de referência em radianos por segundo
ref = rotacao*ones(1,length(t));              % Cria um vetor contendo a taxa de rotação de referência para toda a duração

PIoutput = zeros(1,length(t));                % Inicializa um vetor para armazenar a saída do controlador proporcional-integral
RPM_medido = zeros(1,length(t));              % Inicializa um vetor para armazenar os valores de RPM medidos
corrente_medida = zeros(1,length(t));         % Inicializa um vetor para armazenar os valores de corrente medidos

erro = zeros(1,2);                             % Inicializa um vetor para armazenar os valores de erro
u = zeros(1,2);                                % Inicializa um vetor para armazenar os sinais de controle

Dev1_1.Dev1_ai0 = 0.0;                         % Inicializa a variável de medição de entrada analógica

% Parâmetros do Controlador PI
kp = 0.001407025785043;                        % Ganho proporcional
ki = 0.016885202156297;                        % Ganho integral
q0 = kp+(ki*Ts/2);                             % Coeficiente integral
q1 = -kp+(ki*Ts/2);                            % Coeficiente integral

% PID
for j = 1:length(t)
    Dev1_1 = read(d,seconds(Ts));              % Lê os valores de entrada analógica com um período de amostragem
    corrente_medida(j) = Dev1_1.Dev1_ai1;     % Armazena o valor de corrente medido

    RPM_medido(j) = Dev1_1.Dev1_ai0/2.5e-3;   % Calcula e armazena o valor de RPM medido

    erro(2) = erro(1);                         % Desloca os valores de erro
    erro(1) = ref(j) - (RPM_medido(j)*(pi/30)); % Calcula o erro entre referência e RPM medido

    u(2) = u(1);                                % Desloca os valores do sinal de controle
    u(1) = q0*erro(1) + q1*erro(2) + u(2);      % Calcula o sinal de controle usando um controlador proporcional-integral
    if u(1) > 10                                % Verifica se o sinal de controle excede o limite máximo
        u(1) = 10;
    elseif u(1) < -10                           % Verifica se o sinal de controle excede o limite mínimo
        u(1) = -10;
    end
    PIoutput(j) = u(1);                         % Armazena o sinal de controle calculado

    write(d,u(1));                              % Escreve o sinal de controle no canal de saída analógica
end

pause(2)                                        % Pausa por 2 segundos para geração do sinal

% Resetar Saída CC
dcOutput = 0;                                   % Define a voltagem de saída como zero
write(d,dcOutput);                              % Escreve a voltagem zero no canal de saída analógica

% Limpeza
clear d                                         % Limpa o objeto da Caixa de Ferramentas de Aquisição de Dados do espaço de trabalho

% Plotagem
figure(1)                                       % Abre a figura 1 para plotagem
plot(t,PIoutput,t,corrente_medida);             % Plota a saída do controlador e a corrente medida

figure(2)                                       % Abre a figura 2 para plotagem
plot(t,RPM_medido,t,(30/pi)*ref);               % Plota o RPM medido e o RPM de referência
