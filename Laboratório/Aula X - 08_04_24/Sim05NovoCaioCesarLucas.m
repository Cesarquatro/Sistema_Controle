% Caio Maciel    211270415
% Cesar Augusto  211270121
% Lucas Morello  211270351
%% 
% Limpar a Command Window e limpar as variáveis do WorlSpace
clear
clc

%% Tipo de onda
% 1 - Quadrada
% 2 - Triangular
% 3 - Senoidal
tipo = 2;

%% Quadrada

if tipo == 1
    T = 10;
    n1 =1;
    n2 = 1;
    fs = 1000;
    Ts = 1/fs;
    tfinal = 20;
    sinal = 1;
    amplitude = (2000*pi/30);
    
    t = 0:Ts:tfinal;
    f_t = zeros(1,length(t));
    
    for k=1: length(t)
        if t(k) == n1*T/2
            sinal = -1;
            n1 = n1 + 2;
        elseif t(k) == n2*T
            sinal = 1;
            n2 = n2 + 1;
        end
        f_t(k) = sinal*amplitude;
    end

%% Triangular
elseif tipo == 2

    T = 10;
    n = 1;
    fs = 1000;
    Ts = 1/fs;
    tfinal = 20;
    amplitude_sup = (2000*pi/30) ;
    amplitude_inf = (1000*pi/30) ;
    
    inc = (amplitude_sup - amplitude_inf)*Ts/T;
    
    t = 0:Ts:tfinal;
    f_t = amplitude_inf*ones(1,length(t));
    
    for k=2: length(t)
        if t(k) == n*T
            f_t(k) = amplitude_inf;
            n = n + 1;
        else
            f_t(k) = f_t(k-1) + inc;
        end
    end

elseif tipo == 3
    %% Senoidal
    T = 10;
    fs = 1000;
    Ts = 1/fs;
    tfinal = 20;
    amplitude = 2000*pi/30;
    w=2*pi/T;
    t=0:Ts:tfinal;
    f_t = amplitude*sin(w*t);
end


%% Add Channels
d = daq("ni");

ch1 = addinput(d,"Dev1","ai0","Voltage");
ch1.TerminalConfig = "SingleEnded";

ch2 = addinput(d,"Dev1","ai1","Voltage");
ch2.TerminalConfig = "SingleEnded";

addoutput(d,"Dev1","ao0","Voltage");
d.Rate = 1000;
%Ts = 1/d.Rate;
%t = 0.0:Ts:20.0;
% rotacao = 3000*pi/30;
ref = f_t; 

PIoutput = zeros(1,length(t));
RPM_medido = zeros(1,length(t));
corrente_medida = zeros(1,length(t));

erro = zeros(1,2);
u = zeros(1,2);

Dev1_1.Dev1_ai0 = 0.0;

kp = 0.001407025785043;
ki = 0.016885202156297;%0.0923;%

q0 = kp+(ki*Ts/2);
q1 = -kp+(ki*Ts/2);

for j = 1:length(t)
    Dev1_1 = read(d,seconds(Ts));
    corrente_medida(j) = Dev1_1.Dev1_ai1;

    RPM_medido(j) = Dev1_1.Dev1_ai0/2.5e-3;

    erro(2) = erro(1);
    erro(1) = ref(j) - (RPM_medido(j)*(pi/30));

    u(2) = u(1);
    u(1) = q0*erro(1) + q1*erro(2) + u(2);
    if u(1) > 10
        u(1) = 10;
    elseif u(1) < -10
        u(1) = -10;
    end
    PIoutput(j) = u(1);

    write(d,u(1));
end
pause(2) % Adjust the duration of signal generation.

% Reset DC Output
dcOutput = 0;
write(d,dcOutput);

% Clean Up
clear d

% tempo = 0:Ts:(Ts*(length(PIoutput)-1));
figure(1)
plot(t,PIoutput,t,corrente_medida);
figure(2)
plot(t,RPM_medido,t,(30/pi)*ref);