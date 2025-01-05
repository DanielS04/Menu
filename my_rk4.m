% -------------------------
% % Arguments
% f     <- function
% tspan <- time span [ t0, t1 ]
% y0    <- starting conditions
% h     <- time-step
% -------------------------
% results <- [ t, y ]
% t     <- time vector
% y     <- matrice of results ( every row corresponding to conditions at given time )
% -------------------------

function [ t, y ] = my_rk4( f, tspan, y0, h )
    % Initialization
    t0 = tspan( 1 );
    t1 = tspan( 2 );
    t = t0 : h : t1;                % time vector
    n = length( t );                % amount of steps
    y = zeros( n, length( t0 ) );   % matrice fo results
    y( 1, : ) = y0;                 % starting conditions

    % Iterating RK4 method
    for i = 1 : ( n-1 )
        t_n = t( i );
        y_n = y( i, : ).';

        % Calculating k(1-4) coefficients
        k1 = h * f(     t_n      ,      y_n       );
        k2 = h * f( ( t_n + h/2 ), ( y_n + k1/2 ) );
        k3 = h * f( ( t_n + h/2 ), ( y_n + k2/2 ) );
        k4 = h * f(  ( t_n + h ) ,  ( y_n + k3 )  );

        % Actualization of results
        y_r = y_n + ( 1/6 ) * ( k1 + 2*k2 + 2*k3 + k4 ).';
        y( ( i+1 ), : ) = y_r;
    end
end