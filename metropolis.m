function spin = metropolis(spin, kT, J)
% metropolis - El algoritmo de Metrópolis.
% Esta función implementa el algoritmo de Metrópolis para simular sistemas
% de espines a una temperatura dada.
% spin: matriz de +/- 1 que representa la configuración de espines.
% kT: temperatura multiplicada por la constante de Boltzmann.
% J: coeficiente de acoplamiento entre los espines.

numIters = numel(spin);

for iter = 1 : numIters
    % Selecciona un índice lineal aleatorio dentro de la matriz de espines.
    linearIndex = randi(numel(spin));
    % Convierte el índice lineal en coordenadas de fila y columna.
    [row, col]  = ind2sub(size(spin), linearIndex);
    % Encuentra los vecinos más cercanos del espín seleccionado.
    above = mod(row - 1 - 1, size(spin,1)) + 1;
    below = mod(row + 1 - 1, size(spin,1)) + 1;
    left  = mod(col - 1 - 1, size(spin,2)) + 1;
    right = mod(col + 1 - 1, size(spin,2)) + 1;
    % Obtiene los valores de los espines vecinos.
    neighbors = [spin(above, col);spin(row, left);spin(row, right); spin(below, col)];
    % Calcula el cambio de energía si este espín se invierte.
    dE = 2 * J * spin(row, col) * sum(neighbors);
    % Calcula la probabilidad de aceptar la inversión del espín basada en la probabilidad de Boltzmann.
    prob = exp(-dE / kT);
    % Condición para cambiar el espín.
    if dE <= 0 || rand() <= prob
        spin(row, col) = -spin(row, col);
        % Si el cambio de espín es aceptado (porque disminuye la energía o por probabilidad),
        % se invierte el espín.
    end
end