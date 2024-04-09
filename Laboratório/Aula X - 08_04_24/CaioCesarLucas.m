% Cesar Augusto  211270121
% Lucas Morello  211270351
%% 
% Limpar a Command Window e limpar as variáveis do WorlSpace
clear
clc

% Definindo as variáveis
%% Quadrada
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
        fimSe;
    end
end

%% Senoidal
