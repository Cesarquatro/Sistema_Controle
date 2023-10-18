close all; clc; clear;
%% Atividade 07 – Controle de velocidade em malha fechada – Motor CC

% Objetivos:
% Analisar a influência dos ganhos proporcional e integral na resposta de 
% sistemas dinâmicos em malha fechada. Simulação computacional de sistemas
% de controle em malha fechada com controlador Proporcional-Integral.

Km = 0.06;   % [N.m/A]
J = 80.45e-6;   % [kg.m²]
Cphi = 0.06; % [V/s]
Ra = 2.5;    % [Ω]
La = 75e-3;     % [H]

%% Parte A
% 1) Crie um script ou live script no Matlab e defina um vetor c que varia
% de 0,1 a 1,0 com passo de 0,1.
c = 0.1:0.01:1;

% 2) Modele novamente a função transferência de controle de velocidade do 
% motor CC (Gw(s)) utilizada nas atividades passadas.

num = Km;
den = [La*J Ra*J Cphi*Km];

Gw = tf(num, den) % Atividade 6

% 3) Crie um laço for com um contador cont variando entre 1 e o comprimento
% do vetor c (length(c)). Dentro do laço for, obtenha a função transferên-
% cia do controlador PI (GPI(s)) através da função pid(). Utilize os ganhos
% kp e ki obtidos no final da Parte C da Atividade 6, mas multiplique o 
% ganho ki pelo vetor c. Isto pode ser feito da seguinte forma:

% Gpi = pid(kp,c(cont)*ki,0,0); % cont nesse caso é o contador do laço for

% 4) Ainda dentro do laço for:

% a) utilize a função GmfPI = feedback(sys1,sys2) para obter a função
% transferência do sistema em malha fechada composto por
% sys1 = GPI(s) ∗ Gw(s) e sys2 = 1.

% b) obtenha o gráfico da resposta ao degrau de GmfPI utilizando a função
% step(). Use também a função figure(1) o comando hold on.

% c) obtenha as informações da resposta ao degrau através da função
% stepinfo(). Guarde as informações de sobressinal e tempo de acomodação
% em vetores. Isto pode ser feito da seguinte forma:

% Info = stepinfo(GmfPI);
% Sobressinal(cont) = Info.Overshoot; 
% Tempo_ac(cont) = Info.SettlingTime;

kp = 0.0721;  % da Atividade 6
ki = 2.9135; % da Atividade 6

num1 = ki;
den1 = [1 0];

%GPI = kp + tf(num1, den1)
sys2 = 1;

Sobressinal = zeros(1, length(c));
Tempo_ac = zeros(1, length(c));

figure(1)
for cont = 1:length(c)
    Gpi = pid(kp,c(cont)*ki,0,0);
    sys1 = Gpi*Gw;
    GmfPI = feedback(sys1,sys2);
  
    step(GmfPI)

    hold on;

    Info = stepinfo(GmfPI);
    Sobressinal(cont) = Info.Overshoot; 
    Tempo_ac(cont) = Info.SettlingTime; 
end

% 4) Após o laço for, utilize a função plot() para obter os gráficos de
% sobressinal em função do vetor c*100 e tempo de acomodação em função do 
% vetor c*100. Utilize a função figure() para plotar os gráficos em janelas
% separadas e não sobrescrever o gráfico com as respostas ao degrau obtido
% anteriormente.

figure(2)
plot(c*100, Sobressinal)

figure(3)
plot(c*100, Tempo_ac)