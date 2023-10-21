function Mmean = magnetization(spin)
%   magnetization - Cálculo de la magnetización de una configuración de espines.
%   Mmean = magnetization(spin) devuelve la magnetización de la configuración
%   |spin|. |spin| es una matriz de valores +/- 1 que representa los espines.

% Se calcula la magnetización promedio tomando la media de todos los valores en |spin|.
Mmean = abs(mean(spin(:)));
