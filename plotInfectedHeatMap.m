function plotInfectedHeatMap(positions,infected,city_size)
    grid_size = 10;  
    grid_x = linspace(0, city_size(1), grid_size + 1);  
    grid_y = linspace(0, city_size(2), grid_size + 1);  
    infected_grid = zeros(grid_size, grid_size); 
    
    for i = 1:length(infected)
        if infected(i)
            
            x_idx = find(positions(i, 1) <= grid_x, 1) - 1;
            y_idx = find(positions(i, 2) <= grid_y, 1) - 1;
            
            if x_idx > 0 && y_idx > 0 && x_idx <= grid_size && y_idx <= grid_size
                infected_grid(x_idx, y_idx) = infected_grid(x_idx, y_idx) + 1;
            end
        end
    end
    figure;
    [X, Y] = meshgrid(grid_x(1:end-1), grid_y(1:end-1));
    Z = infected_grid';  
    Z_interp = interp2(X, Y, Z, X, Y, 'linear');  
    surf(X, Y, Z_interp, 'EdgeColor', 'none');  
    colorbar;
    title('Wykres 3D zakarzonych');
    xlabel('X');
    ylabel('Y');
    zlabel('Liczba zakażonych');
    view(3); 
    shading interp;  

end

