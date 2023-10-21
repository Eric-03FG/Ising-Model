%% Transición de fase en el modelo de Ising (Temperaturas fijas) - Parte 1
clc; clear; close all
Lspin = 32;         % Longitud de la matriz de espines
P = 0.5;            % Probabilidad de que un espín esté hacia arriba (spin up)
J = 1;              % Intercambio de energía (parámetro de interacción)
Nsteps = 10000;
Steps = linspace(0,Nsteps,Nsteps);
Tfix = [1.8, 2.3, 3];
NT = length(Tfix);

% Preasigna matrices para almacenar los resultados
Evar = zeros(1,NT);
Mvar = zeros(1,NT);
Emean = zeros(NT, Nsteps);
Mmean = zeros(NT, Nsteps);

% Genera una configuración inicial de espines aleatoria
spin = draw(Lspin, P);

for i = 1:NT  % Bucle para temperaturas
for j = 1:Nsteps
    % Utiliza el algoritmo de Metropolis para simular el modelo de Ising
    spin = metropolis(spin, Tfix(i), J);
    % Calcula el promedio de la energía y la magnetización
    Emean(i,j) = energy(spin, J);
    Mmean(i,j) = magnetization(spin);
end
% Calcula la varianza de la energía y la magnetización
Evar(i) = var(Emean(i,(1000:10000)));
Mvar(i) = var(Mmean(i,(1000:10000)));
end

fprintf('Varianza de la energía:\n')
disp(Evar)
fprintf('Varianza de la magnetización:\n')
disp(Mvar)

% Magnetización y Energía vs Pasos
figure(1);
subplot(2, 1, 1);
plot(Steps, Emean(1,:));
hold on
plot(Steps, Emean(2,:));
hold on
plot(Steps, Emean(3,:));
legend(['T = ' num2str(Tfix(1))],['T = ' num2str(Tfix(2))],['T = ' num2str(Tfix(3))],'Location', 'BestOutside');
title('Energ\''ia Media Por Esp\''in vs Iteraci\''on','Interpreter','latex');
xlabel('Iteraci\''on','Interpreter','latex');
ylabel('$\langle E \rangle$','Interpreter','latex');
grid on;
subplot(2, 1, 2);
plot(Steps, Mmean(1,:));
hold on
plot(Steps, Mmean(2,:));
hold on
plot(Steps, Mmean(3,:));
legend(['T = ' num2str(Tfix(1))],['T = ' num2str(Tfix(2))],['T = ' num2str(Tfix(3))],'Location', 'BestOutside');
title('Magnetizaci\''on Media Por Esp\''in vs Iteraci\''on','Interpreter','latex');
xlabel('Iteraci\''on','Interpreter','latex');
ylabel('$\langle |M| \rangle$','Interpreter','latex');
grid on;
%% Transición de fase en el modelo de Ising (Rango de temperaturas) - Parte 2
clc; clear; close all
Lspin = 32;         % Longitud de la matriz de espines
P = 0.5;            % Probabilidad de que un espín esté hacia arriba (spin up)
J = 1;              % Intercambio de energía (parámetro de interacción)
Nsteps = 1000;
PS = Nsteps*0.1;
Steps = linspace(0,Nsteps,Nsteps);
T = linspace(1.8,3,100);
NT = length(T);

% Preasigna matrices para almacenar los resultados
Evar = zeros(1,NT);
Mvar = zeros(1,NT);
Emean = zeros(NT, Nsteps);
Mmean = zeros(NT, Nsteps);
TEm = zeros(1, NT);
TMm = zeros(1, NT);

% Genera una configuración inicial de espines aleatoria
spin = draw(Lspin, P);

% Configura la figura para la animación
figure;
axis tight manual;
filename = 'ising_temperature_animation.gif';

for i = 1:NT  % Bucle para temperaturas
    for j = 1:Nsteps
        % Utiliza el algoritmo de Metropolis para simular el modelo de Ising
        spin = metropolis(spin, T(i), J);
        
        % Calcula el promedio de la energía y la magnetización
        Emean(i, j) = energy(spin, J);
        Mmean(i, j) = magnetization(spin);
    end
    
    % Muestra la matriz de espines como una cuadrícula de puntos rojos y azules
    cla; % Limpia la figura anterior
    axis([0, Lspin+1, 0, Lspin+1]);
    axis equal;
    axis off;
    hold on;
    
    [x, y] = meshgrid(1:Lspin, 1:Lspin);
    plot(x(spin == 1), y(spin == 1), 'ksquare', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    plot(x(spin == -1), y(spin == -1), 'ksquare', 'MarkerSize', 6, 'MarkerFaceColor', 'b');
    grid on;
    legend('$\uparrow \, \sigma_k = +1$', '$\downarrow \, \sigma_k = -1$', 'Interpreter', 'latex','Location','best');
    text(0, Lspin + 2, [num2str(Lspin) '$^2$ espines'], 'Interpreter', 'latex');
    
    title(['Temperatura: ' num2str(T(i)) ''],'Interpreter','latex');
    drawnow;

    % Guarda cada frame en un archivo GIF
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    if i == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append');
    end

    % Calcula la varianza de la energía y la magnetización
    Evar(i) = var(Emean(i, (PS:Nsteps-PS)));
    Mvar(i) = var(Mmean(i, (PS:Nsteps-PS)));
    TEm(i) = mean(Emean(i, :));
    TMm(i) = mean(Mmean(i, :));
end

% Magnetización y Energía vs Temperatura
figure(2);
plot(T, TEm,'r');
hold on
plot(T, TMm,'b');
title('Energ\''ia y Magnetizaci\''on vs Temperatura','Interpreter','latex');
xlabel('T','Interpreter','latex');
ylabel('Magnitud','Interpreter','latex');
legend('$\langle E \rangle$','$\langle |M| \rangle$','Interpreter','latex')
grid on;
% Calor Específico y Susceptibilidad Magnética vs Temperatura
figure(3);
plot(T, Evar,'Color','#77AC30');
hold on
plot(T, Mvar,'Color','#0072BD');
title('Calor Espec\''ifico y Susceptibilidad Magn\''etica vs Temperatura','Interpreter','latex');
xlabel('T','Interpreter','latex');
ylabel('Magnitud','Interpreter','latex');
legend('$c_v$ or $\sigma^2\left(E\right)$','$\chi$ or $\sigma^2\left(|M|\right)$','Interpreter','latex')
grid on;