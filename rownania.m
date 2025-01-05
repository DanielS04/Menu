clear all;
close all;

% Parametry Symulacji
N = 1000;               % <- Całkowita populacja
I0 = 10;                % <- Początkowa liczba zakażonych
R0 = 0;                 % <- Początkowa liczba ozdrowieńców 
S0 = N - I0 - R0;       % <- Początkowa liczba podatnych
beta = 2/10;            % <- Wskaźnik zakaźności
gamma = 1/10;           % <- Wskaźnik wyzdrowień
T = 100;                % <- Ilość dni symulacji
y0 = [ S0, I0, R0 ];    % <- Warunki początkowe

% Definicja równań różniczkowych, model SIR
% Z dodanym szumem
% Kolejno: dS/dt ; dI/dt ; dR/dt
szum1 = generateNormalDisrtNumber()*0.1,
szum2 = generateNormalDisrtNumber()*0.1,
sir = @( t, y ) [ (-beta * y(1) * y(2) / N) + szum1 ; 
                  (beta * y(1) * y(2) / N) - (gamma*y(2)) + szum2;
                  gamma * y(2)];

% Rozwiązanie równań różniczkowych
[ t, y ] = my_odeAB( sir, [0, T], y0, 10*T);

% Wyniki
S = y( :, 1 );      % <- Liczba podatnych
I = y( :, 2 );      % <- Liczba zakażonych
R = y( :, 3 );      % <- Liczba ozdrowieńców

% Wizualizacja wyników
figure; hold on; grid on;
plot( t, S, 'b-' );
plot( t, I, 'r-' );
plot( t, R, 'g-' );
xlabel( 'Czas (dni)' );
ylabel( 'Liczba osób' );
legend( 'Podatni (S)', 'Zakażeni (I)', 'Ozdrowieńcy (R)' );
title( 'Model SIR - Symulacja rozprzestrzeniania choroby' );