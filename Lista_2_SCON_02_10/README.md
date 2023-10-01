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
