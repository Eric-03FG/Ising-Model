function Emean = energy(spin, J)
%   energy - Energía media por giro.
%   Emean = energy(spin, J) devuelve la energía media por espín de la
%   configuración |spin|. |spin| es una matriz de +/- 1. |J| es un escalar.

% Calcula la suma de los vecinos de cada espín en la red.
sumOfNeighbors = ...
      circshift(spin, [ 0  1]) ...   % Desplaza la matriz 'spin' una columna hacia la derecha.
    + circshift(spin, [ 0 -1]) ...   % Desplaza la matriz 'spin' una columna hacia la izquierda.
    + circshift(spin, [ 1  0]) ...   % Desplaza la matriz 'spin' una fila hacia abajo.
    + circshift(spin, [-1  0]);      % Desplaza la matriz 'spin' una fila hacia arriba.

% Calcula la energía de la red utilizando el modelo de Ising.
Em = - J * spin .* sumOfNeighbors;

% Calcula la energía total dividiendo por 2 para evitar el doble conteo.
E  = 0.5 * sum(Em(:));

% Calcula la energía media por espín dividiendo la energía total entre el número de espines en la red.
Emean = E / numel(spin);