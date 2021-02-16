<!-- 
.. title: Programando funciones de singularidad
.. slug: programando-funciones-de-singularidad
.. date: 2017-05-01 17:05:27 UTC-05:00
.. tags: mathjax, mecánica, python, draft,
.. category: 
.. link: 
.. description: 
.. type: text
-->

Las funciones de singularidad son un tipo de funciones que se caracterizan por la notación 
de paréntesis angulares y por definirse como una función a trozos para diversos valores en 
un intervalo. De manera específica una función de singularidad se define como:

$$
< x -a >^n = 
\left\\{
\begin{matrix}
(x-a)^n & \text{para } x \geq a \\\
0 & \text{para } x < a
\end{matrix}
\right.
$$

Programar (en computadora, claro) una función de singularidad es algo bastante intuitivo. En 
el enfoque más simplista podemos concebirla como una simple estructura de bifurcación, algo como:

```
Si x mayor o igual que a entonces
    Devolver (x-a)^n
Si no
    Devolver 0
```

