clear all;
close all;

% Parametry symulacji
N = 900;              % Liczba osób
beta = 0.3;           % Współczynnik zakażania
gamma = 0.1;          % Współczynnik wyzdrowienia
area_size = 500;      % Rozmiar obszaru
infection_radius = 5; % Promień zakażenia
recovery_time = 69;  % Czas do wyzdrowienia (w iteracjach)

% Początkowe pozycje i stany
rng(42);  % Inicjalizacja generatora liczb losowych
positions = area_size * rand(N, 2);     % Losowe pozycje
velocities = randn(N, 2);              % Losowe prędkości
states = zeros(N, 1);                  % Stany: 0 = podatni, 1 = zakażeni, 2 = ozdrowieńcy
states(1) = 1;                         % Jeden początkowo zakażony
infection_timer = zeros(N, 1);         % Licznik czasu zakażenia

% Kolory dla różnych stanów
colors = [0, 0, 1;  % Podatni (niebiescy)
          1, 0, 0;  % Zakażeni (czerwoni)
          0, 1, 0]; % Ozdrowieńcy (zieloni)

% Ustawienia animacji
figure;
hold on;
xlim([0, area_size]);
ylim([0, area_size]);
h = scatter(positions(:, 1), positions(:, 2), 50, colors(states+1, :), 'filled');
title('Symulacja SIR');
xlabel('X');
ylabel('Y');

% Pętla symulacji
num_steps = 600;  % Liczba iteracji
for step = 1:num_steps
    % Aktualizacja pozycji
    positions = positions + velocities;
    
    % Odbicia od ścian
    velocities(positions <= 0 | positions >= area_size) = ...
        -velocities(positions <= 0 | positions >= area_size);
    positions = max(0, min(area_size, positions)); % Ograniczenie do obszaru

    % Zakażanie
    for i = 1:N
        if states(i) == 1  % Jeśli osoba jest zakażona
            % Sprawdź, kto znajduje się w promieniu zakażenia
            distances = sqrt(sum((positions - positions(i, :)).^2, 2));
            susceptible = find(states == 0 & distances < infection_radius);
            if ~isempty(susceptible)
                infection_chance = rand(size(susceptible));
                new_infections = susceptible(infection_chance < beta);
                states(new_infections) = 1;
            end
        end
    end
    
    % Wyzdrowienie
    infection_timer(states == 1) = infection_timer(states == 1) + 1; % Zwiększ licznik
    recovered = find(infection_timer >= recovery_time); % Osoby, które wyzdrowiały
    states(recovered) = 2; % Zmiana stanu na "ozdrowieńcy"
    infection_timer(recovered) = 0; % Reset licznika dla ozdrowieńców
    
    % Aktualizacja animacji
    set(h, 'XData', positions(:, 1), 'YData', positions(:, 2), ...
        'CData', colors(states+1, :));
    drawnow;
end

