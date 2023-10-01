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

