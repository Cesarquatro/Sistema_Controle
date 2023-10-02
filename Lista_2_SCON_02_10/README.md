# Lista 2
## Ex 1
### Considere os dois polinômios
   p(s) = s² + 7s + 10
   
   e
   
   q(s) = s + 2.
   
```matlab
p = [1 7 10];
q = [1 2];
```
### Calcule o seguinte:

* (a) p(s)q(s)
  ```Matlab
  a = conv(p, q)
  disp('----------------------------')
  ```
  Saída:
  ```bash
  a =
     1     9    24    20
  ----------------------------
  ```

* (b) polos e zeros de G(s) = q(s) / p(s)
  ```Matlab
  disp('(b)')
  G = tf(q, p)
  
  polos = pole(G)
  
  zeros = zero(G)
  ```
  Saída:
  ```bash
  (b)
  
  G =   
        s + 2
    --------------
    s^2 + 7 s + 10
   
  Continuous-time transfer function. 
  
  polos =  
      -5
      -2  
  
  zeros =  
      -2
  ```
* (c) p(-1)
  ```Matlab
  c = polyval(p, -1)
  ```
  Saída:
  ```bash
  c =
     4
  ```

## Ex 2
### Considere o sistema com realimentação descrito na Figura abaixo

<img align="center" alt="ex2" height="200" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex2.png?raw=true"/>
   
```matlab
num1 = 1;
den1 = [1 1];
controlador = tf(num1, den1)

num2 = [1 2];
den2 = [1 3];
planta = tf(num2, den2)
disp('----------------------------')
```
### Calcule o seguinte:

* (a) Calcule a função transferência em malha fechada usando as funções series e feedback.
  ```Matlab
  disp('(a)')
   Serie = series(controlador, planta)
   Feedback = feedback(Serie, 1)
  ```
  Saída:
  ```bash
  controlador =    
       1
     -----
     s + 1    
   Continuous-time transfer function.  
   
   planta =    
     s + 2
     -----
     s + 3    
   Continuous-time transfer function.   
   ------------------------------------
   (a)   
   Serie =    
         s + 2
     -------------
     s^2 + 4 s + 3    
   Continuous-time transfer function.   
   
   Feedback =    
         s + 2
     -------------
     s^2 + 5 s + 5    
   Continuous-time transfer function.
  ```

  * (b) Obtenha a resposta ao degrau unitário do sistema em malha fechada com a função step e verifique que o valor final da saída é 2/5.
  ```Matlab
  figure(1)
  step(Feedback)
  grid on
  ```
  Saída:
  
  <img align="center" alt="ex2" width="700" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex2_step_response.png?raw=true"/>

## Ex 3
### Considere a equação diferencial:
###        y'' + 4y' + 3y = u
### em que y(0) = y'(0) = 0 e u(t) é um degrau unitário. Determine a solução y(t) analiticamente e verifique-a traçando em um gráfico a solução analítica e a resposta ao degrau obtida com a função step.

<img align="center" alt="ex2" width="700" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex3_1.jpg?raw=true"/>
<img align="center" alt="ex2" width="700" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex3_2.jpg?raw=true"/>
   
```matlab
num = 1; 
den = [1 4 3];
sys = tf(num, den)

t = 0:0.1:10;
ut = step(sys, t); % degrau unitário
yt = 1/3 - 1/2*exp(-t) + 1/6*exp(-3*t);

%plot
plot(t, ut,'-', 'Color', 'r', 'LineWidth', 8)
hold on
plot(t, yt, '--', 'Color', 'c', 'LineWidth', 2)

grid on;

title('Verificação','FontSize',20);
xlabel('Tempo [s]','FontSize',15);
ylabel('Amplitude','FontSize',15);
legend('Resposta do sistema ao degrau unitário u(t)', ...
    'Solução y(t) obtida analiticamente', ...
    'Location','southeast','FontSize',15)
```
Saída:
```bash
sys = 
        1
  -------------
  s^2 + 4 s + 3  
Continuous-time transfer function.  
```
<img align="center" alt="ex2" width="900" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex3.png?raw=true"/>

## Ex 4
### Considere o sistema mecânico descrito na figura abaixo. A entrada é dada
### por f(t) e a saída é y(t). Determine a função transferência de f(t) para
### y(t) e, plote um gráfico da resposta do sistema a uma entrada em degrau
### unitário. Seja m = 10k, k = 1 e b = 0.5. Mostre que a amplitude máxima da
### saída esta em torno de 1.8

<img align="center" alt="ex4" width="500" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex4.png?raw=true"/>
   
```matlab
k = 1;
b = 5e-1;
m = 10 * k;

num = 1/m;
den = [1 b/m k/m];

Hs = tf(num, den)

t = 0:0.01:400;

amplitude = step(Hs, t);

figure(1)
plot(t, amplitude, 'LineWidth', 2)
grid on
```
Saída:
```bash
Hs = 
         0.1
  ------------------
  s^2 + 0.05 s + 0.1
Continuous-time transfer function.  
```
Saída

<img align="center" alt="ex4" width="900" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex4_step_response.png?raw=true"/>

## Ex 5
### Um sistema de controle de altitude de um único eixo de um satélite pode
### ser representado pelo diagrama de blocos da figura abaixo. As variáveis
### k, a e b são parâmetros de controle e J é o momento de inércia do veículo
### espacil. Admita que o valor nominal do momento de inércia seja J = 10.8e8
### [slug.m²] e que os valores dos parâmetros de controle sejam k = 10.8e8, a
### a = 1 e b = 8.

<img align="center" alt="ex4" width="500" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex5.png?raw=true"/>
   
```matlab
J = 10.8e8; % [Slug.m²]
k = 10.8e8;
a = 1;
b = 8;

num1 = [k k*a];
den1 = [1 b];
controlador = tf(num1, den1)

num2 = 1;
den2 = [J 0 0];
veiculo_espacial = tf(num2, den2)
disp('-------------------------------')
```
Saída:
```bash
controlador = 
  1.08e09 s + 1.08e09
  -------------------
         s + 8 
Continuous-time transfer function.

veiculo_espacial = 
       1
  -----------
  1.08e09 s^2 
Continuous-time transfer function.
```
* (a) Desenvolva uma sequência de intruções para calcular a função transferência em malha fechada T(s) = θ(s) / θd(s).
  ```Matlab
  disp('-------------------------------')
   disp('(a)')

   Serie = series(controlador, veiculo_espacial)
   Feedback = feedback(Serie, 1)
  ```
  Saída:
  ```bash
  -------------------------------
   (a)   
   Serie =    
        1.08e09 s + 1.08e09
     -------------------------
     1.08e09 s^3 + 8.64e09 s^2    
   Continuous-time transfer function.   
   
   Feedback =    
                   1.08e09 s + 1.08e09
     -----------------------------------------------
     1.08e09 s^3 + 8.64e09 s^2 + 1.08e09 s + 1.08e09    
   Continuous-time transfer function.
  ```
  * (b) Calcule e plote o gráfico da resposta ao degrau para uma entrada em degrau de 10°.
  ```Matlab
  t = 0:0.1:100;
  figure(1)
  y = step(10*Feedback, t);
  plot(t, y, 'Color', 'b', 'LineWidth', 1)
  title('resposta ao degrau para uma entrada em degrau de 10°')
  grid on
  ```
  Saída:

  <img align="center" alt="ex4" width="900" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex5_step_response_a.png?raw=true"/>
* (c) O valor exato do momento de inércia é geralmente desconhecido e pode mudar lentaente com o tempo. Compare o desempenho da resposta ao degrau do veículo espacial quando J é reduzido de 20% e 50%. Use os parâmetros  do controlado k = 10.8e8, a = 1 e b = 8 e uma entrada de 10°. Discuta os resultados.
  ```Matlab
  disp('-------------------------------')
  disp('(c)')
  % J reduzido de 20%
  disp('J é reduzido de 20%:')
  J2 = J*0.8;
  den3 = [J2 0 0]; 
  veiculo_espacial2 = tf(num2, den3)
  Serie2 = series(controlador, veiculo_espacial2)
  Feedback2 = feedback(Serie2, 1)
  y2 = step(10*Feedback2, t);
  %plot
  figure(2)
  plot(t, y,'Color', 'k', 'LineWidth', 2, 'LineStyle','-')   % plot com J em 100%
  hold on
  plot(t, y2, 'Color', 'b', 'LineWidth', 2, 'LineStyle','--') % plot com J reduzido de 20%
  hold on
  grid on
   
  % J reduzido de 50%
  disp('J é reduzido de 50%:')
  J3 = J*0.5;
  den4 = [J3 0 0];
  veiculo_espacial3 = tf(num2, den4)
  Serie3 = series(controlador, veiculo_espacial3)
  Feedback3 = feedback(Serie3, 1)
  y3 = step(10*Feedback3, t);
  plot(t, y3, 'Color', 'r', 'LineWidth', 2,'LineStyle',':') % plot com J reduzido de 50%
  hold on
  legend('J', 'J reduzido de 20%','J de reduzido 50%', 'FontSize',15)
  ```
  Saída:
  ```bash
  -------------------------------
  (c)
  J é reduzido de 20%:  
  veiculo_espacial2 =   
         1
    -----------
    8.64e08 s^2   
  Continuous-time transfer function.
    
  Serie2 =   
       1.08e09 s + 1.08e09
    --------------------------
    8.64e08 s^3 + 6.912e09 s^2   
  Continuous-time transfer function.  
  
  Feedback2 =   
                  1.08e09 s + 1.08e09
    ------------------------------------------------
    8.64e08 s^3 + 6.912e09 s^2 + 1.08e09 s + 1.08e09
   Continuous-time transfer function.
  
  J é reduzido de 50%:  
  veiculo_espacial3 =   
        1
    ----------
    5.4e08 s^2   
  Continuous-time transfer function.
    
  Serie3 =   
      1.08e09 s + 1.08e09
    ------------------------
    5.4e08 s^3 + 4.32e09 s^2   
  Continuous-time transfer function.
    
  Feedback3 =   
                 1.08e09 s + 1.08e09
    ----------------------------------------------
    5.4e08 s^3 + 4.32e09 s^2 + 1.08e09 s + 1.08e09   
  Continuous-time transfer function.
  ```
  <img align="center" alt="ex4" width="900" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex5_step_response_c.png?raw=true"/>
  ### Percebe-se que quanto maior o Momento de Inércia (J), maior a amplitude e o tempo para alcançar a estabilidade.
## Ex 6
### Considere o diagrama de blocos da figura abaixo.

<img align="center" alt="ex4" width="500" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex6.png?raw=true"/>
   
```matlab
num1 = 1;
dem1 = [1 1];
sys1 = tf(num1, dem1)

num2 = [1 0];
dem2 = [1 0 2];
sys2 = tf(num2, dem2)

num3 = 1;
dem3 = [1 0 0];
sys3 = tf(num3, dem3)

num4 = [4 2];
dem4 = [1 2 1];
sys4 = tf(num4, dem4)

num5 = [1 0 2];
dem5 = [1 0 0 14];
sys5 = tf(num5, dem5)
```
Saída:
```bash
sys1 = 
    1
  -----
  s + 1 
Continuous-time transfer function.

sys2 = 
     s
  -------
  s^2 + 2 
Continuous-time transfer function.

sys3 = 
   1
  ---
  s^2 
Continuous-time transfer function.

sys4 = 
     4 s + 2
  -------------
  s^2 + 2 s + 1 
Continuous-time transfer function.

sys5 = 
  s^2 + 2
  --------
  s^3 + 14 
Continuous-time transfer function.
```
* (a) Use uma sequência de instruções para reduzir o diagrama de blocos na figura e calcule a função tranferência em malha fechada
  ```Matlab
  % I
  Serie1 = series(sys1, sys2);
  Feedback1 = feedback(sys3, 50);
  
  % II
  Feedback2 = feedback(Serie1, sys4);
  
  % III
  Serie2 = series(Feedback2, Feedback1);
  
  % IV
  Feedback3 = feedback(Serie2, sys5);
  
  % V
  disp('Função tranferência em malha fechada:')
  Serie3 = series(4, Feedback3)
  ```
  Saída:
  ```bash
  Função tranferência em malha fechada:
  Serie3 =   
                               4 s^6 + 8 s^5 + 4 s^4 + 56 s^3 + 112 s^2 + 56 s
    -----------------------------------------------------------------------------------------------------
    s^10 + 3 s^9 + 55 s^8 + 175 s^7 + 300 s^6 + 1323 s^5 + 2656 s^4 + 3715 s^3 + 7732 s^2 + 5602 s + 1400
  Continuous-time transfer function.
  ```
  * (b) Gere um diagrama e polos e zeros da função transferência em malha fechada na forma gráfica usando a função pzmap.
  ```Matlab
  figure(1)
  pzmap(Serie3)
  grid on
  ```
  Saída:

  <img align="center" alt="ex4" width="900" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex6_pzmap.png?raw=true"/>
* (c) Determine explicitamente os polos e zeros da função transferência em malha fechada usando as funções pole e zero e correlacione os resultados com o diagrama de polos e zeros da parte (b)
  ```Matlab
  Polos = pole(Serie3)
  Zeros = zero(Serie3)
  ```
  Saída:
  ```bash
  Polos =
  -0.0002 + 7.0710i
  -0.0002 - 7.0710i
   1.2052 + 2.0883i
   1.2052 - 2.0883i
   0.1223 + 1.8367i
   0.1223 - 1.8367i
  -2.4202 + 0.0000i
  -2.3077 + 0.0000i
  -0.4635 + 0.1993i
  -0.4635 - 0.1993i
      
  Zeros =  
   0.0000 + 0.0000i
   1.2051 + 2.0872i
   1.2051 - 2.0872i
  -2.4101 + 0.0000i
  -1.0000 + 0.0000i
  -1.0000 - 0.0000i
  ```
## Ex 7
### Para o pêndulo simples mostrado na figura abaixo

<img align="center" alt="ex4" width="500" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex7.png?raw=true"/>

### a equação linear do movimento é dada por
### θ''(t) + g / L * sen(θ) = 0 ,
### em que L = 0.5 m, m = 1kg e g = 9.8m/s². Quando a equação não linear é linearizada em torno do ponto de equilíbrio θ = 0, obtém-se o módulo linear invariante no tempo.
### θ'' + g / L * θ = 0 .
   
```matlab
L = 0.5; % [m]
m = 1;   % [Kg]
g = 9.8; % [m/s²]
t = 0:0.01:20;
```
### Crie uma sequência de intruções para plotar o gráfico de ambas as respostas, não linear e linear, do pêndulo simples quando o ângulo inicial do pêndulo for θ(0) = 30° e explique quais as diferenças.

<img align="center" alt="ex4" width="800" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex7_folha.jpeg?raw=true"/>

```matlab
theta = 30; % ângulo inicial θ(0)

% Simulação Linear
num = [1 0 0];
den = [1 0 g/L];
sys_linear = tf(num, den);
x = step(theta*sys_linear, t);

figure(1)
plot(t, x, "LineWidth",2)
grid on

hold on

% Simulação não linear
[t,ynl] = ode45(@pend,t,[theta*pi/180 0]);
plot(t,ynl(:,1)*180/pi, "LineWidth",2);
xlabel('Tempo [s]')
ylabel('θ [°]', 'Rotation',0)

legend('Simulação Linear','Simulação não linear','FontSize',15)

% Def. função pendulo
function [yd]=pend(~,y)
L=0.5; g=9.8;
yd(1)=y(2);
yd(2)=-(g/L)*sin(y(1));
yd=yd';
end
```
Saída:

<img align="center" alt="ex4" width="800" src="https://github.com/Cesarquatro/Sistema_Controle/blob/main/Lista_2_SCON_02_10/img/ex7_plots.png?raw=true"/>
### Ao analisar ambos os plots, podemos notat uma pequena diferença entre os sistemas que vai aumentando com o passar do tempo. Logo, concluímos que para análise de ângulos pequenos em um curto intervalo de tempo, o modelo linear satisfaz o resultado, uma vez que a diferença observada é mínima.
