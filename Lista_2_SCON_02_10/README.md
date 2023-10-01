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

