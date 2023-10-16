close all; clc; clear;
%% gera a função transferência 
p = [1 1]; q = [1 5 6 0];

sys = tf(p,q)

%% gera o lugar geométrico das raízes (os polos buscam os zeros no 
% infinito)
figure(1)
rlocus(sys);
% o → zeros
% x → polos

% Linhas coloridas são os deslocamento das raízes (polos) conforme a
% variação do ganho k
% Quando as raízes se encontram (k = 0.419), é criticamente amortecido

% P/ polos:
% Duas raízes Subamortecido
% Raízes iguais Sem amortecimento
% Sem raízes 

%% gera os vetores das posições das raízes associadas
[r, K] =  rlocus(sys);

%% localizar graficamente um ponto no LGR
disp("-------------------------------------------------------------")
figure(2)
rlocus(sys);
rlocfind(sys) % aparece a cruz que mostra onde o polos estão localizados
              % para aquele valor, resposta no prompt

%% Gera os ganhos/resíduos (r) de frações parciais associados com cada polo
% polo (p)
disp("-------------------------------------------------------------")
K = 20.5775; num = K * [1 4 3]; den = [1 5 6+K K 0];
[r, p, K] = residue(num, den)


