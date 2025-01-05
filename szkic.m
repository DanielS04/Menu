clear all;
close all;

% Parametry symulacji
N = 1000;               % Całkowita populacja
I0 = 10;                % Początkowa liczba zakażonych
R0 = 0;                 % Początkowa liczba ozdrowieńców
S0 = N - I0 - R0;       % Początkowa liczba podatnych
beta = 0.3;             % Wskaźnik zakaźności
gamma = 0.1;            % Wskaźnik wyzdrowień
T = 100;                % Czas symulacji (w dniach)

% Warunki początkowe
y0 = [S0, I0, R0];

% Definicja równań różniczkowych
sir_model = @(t, y) [-beta * y(1) * y(2) / N;    % dS/dt
                      beta * y(1) * y(2) / N - gamma * y(2);  % dI/dt
                      gamma * y(2)];           % dR/dt

% Rozwiązanie równań różniczkowych
[t, y] = ode45(sir_model, [0 T], y0);

% Ekstrakcja wyników
S = y(:, 1);  % Liczba podatnych
I = y(:, 2);  % Liczba zakażonych
R = y(:, 3);  % Liczba ozdrowieńców

% Wizualizacja wyników
figure;
plot(t, S, 'b-', 'LineWidth', 2); hold on;
plot(t, I, 'r-', 'LineWidth', 2);
plot(t, R, 'g-', 'LineWidth', 2);
xlabel('Czas (dni)');
ylabel('Liczba osób');
legend('Podatni (S)', 'Zakażeni (I)', 'Ozdrowieńcy (R)');
title('Model SIR - Symulacja rozprzestrzeniania choroby');
grid on;

% Symulacja losowych interakcji
% Ustawienia środowiska miejskiego
num_individuals = 100;     % Liczba osób w mieście
city_size = [100, 100];    % Wymiary miasta (np. 100x100 jednostek)
infection_radius = 5;      % Zasięg zakażenia
prob_infection = 0.2;      % Prawdopodobieństwo zakażenia przy kontakcie

% Generacja początkowych pozycji
positions = rand(num_individuals, 2) .* city_size;
infected = false(num_individuals, 1);
infected(1:I0) = true;  % Początkowi zakażeni

% Animacja symulacji
figure;
for t = 1:T
    % Ruch losowy osób
    positions = positions + randn(num_individuals, 2);
    positions = mod(positions, city_size);  % Zapętlenie w granicach miasta
    
    % Sprawdzanie zakażeń
    for i = 1:num_individuals
        if infected(i)
            for j = 1:num_individuals
                if ~infected(j)
                    dist = norm(positions(i, :) - positions(j, :));
                    if dist < infection_radius && rand < prob_infection
                        infected(j) = true;
                    end
                end
            end
        end
    end
    
    % Rysowanie miasta
    clf;
    scatter(positions(~infected, 1), positions(~infected, 2), 50, 'b', 'filled'); hold on;
    scatter(positions(infected, 1), positions(infected, 2), 50, 'r', 'filled');
    xlim([0 city_size(1)]);
    ylim([0 city_size(2)]);
    title(['Symulacja zakażeń w mieście - dzień ', num2str(t)]);
    legend('Podatni', 'Zakażeni');
    drawnow;
end
