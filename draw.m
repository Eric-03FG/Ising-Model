function spin = draw(Lspin, P)
%   draw - Inicializa una configuración de espines.
%   spin = draw(Lspin, P) devuelve una configuración de espines
%   con |Lspin| espines a lo largo de cada dimensión y una proporción |P|
%   de ellos apuntando hacia arriba. |spin| es una matriz de +/- 1.

spin = sign(P - rand(Lspin, Lspin));
