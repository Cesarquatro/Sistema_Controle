% Cesar Augusto Mendes Cordeiro da Silva RA: 211270121
% Lucas Martins Morello                  RA: 211270351
% Caio Alencar Maciel                    RA: 211270415
%%
clear

% Def. D como objeto para coleta de dados
d = daq("mcc");
% Taxa da amostragem em [Hz]
d.Rate = 100;

% Parametriza ch1 como (d,"id do disp.","id input","tipo medicao")
ch1 = addinput(d,"Board0","Ai0","Voltage");

% Configura o terminal como apenas saída
ch1.TerminalConfig = "SingleEnded";


% Realiza a leitura do input de dados (d, intervalo de leitura)
Board0_ai0 = read(d,seconds(1));

% Cria uma figura
figure(1)

% Plota o gráfico da leitura
plot(Board0_ai0.Time,Board0_ai0.Board0_Ai0,"+")

% limpa d
clear d