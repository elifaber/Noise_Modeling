function plot_combined_noise_levels(sources, x_range, y_range, locate, walls,levels)
    % PLOT_COMBINED_NOISE_LEVELS Plots the combined noise levels on a contour plot.
    % 
    %   plot_combined_noise_levels(sources, x_range, y_range, locate) plots the combined noise levels
    %   from multiple sources on a contour plot, highlighting the contour line closest
    %   to the specified dB level.
    %
    %   Inputs:
    %       sources: Array of structs representing noise sources, 
    %                each with fields 'position' and 'dB'
    %       x_range: Range of X positions for the grid
    %       y_range: Range of Y positions for the grid
    %       locate: dB level to draw a new contour line
    %       walls(OPTIONAL): Array of structs representing walls with start
    %       and end points as well as an stc
    %   Outputs:
    %       None (Generates a plot)


    % Create a meshgrid for the area
    [X, Y] = meshgrid(x_range, y_range);
    
    % Initialize the resultant dB SPL array
    Z = zeros(size(X));
    
    % Calculate SPL at each grid point
    for i = 1:numel(X)
        % Get the coordinates of the current grid point
        point = [X(i), Y(i)];
        
        % Check if the point is within the circle around any source
        within_circle = false;
        for j = 1:length(sources)
            distance_to_source = sqrt((point(1) - sources(j).position(1))^2 + (point(2) - sources(j).position(2))^2);
            if distance_to_source <= 1 % If the point is within 1 meter of any source
                within_circle = true;
                Z(i) = sources(j).dB; % Assign the dB value of that source to the point
                break; % No need to check other sources
            end
        end
        % If the point is not within any circle, calculate SPL
        if ~within_circle
            Z(i) = SPL_point(sources, point, walls);
        end
    end
    
    % Apply Gaussian filter for smoothing
    sigma = 1; % Adjust sigma for desired smoothing effect
    Z_smoothed = imgaussfilt(Z, sigma);
    % Perform interpolation
    Z_smooth = interp2(X, Y, Z_smoothed, X, Y, 'spline');
        
    % Plot the combined noise levels using contour
    figure;
    [~, ~] = contourf(X, Y, Z_smooth, levels);
    colorbar;
    hold on;
    
    % Plot the noise sources
    for i = 1:length(sources)
        % Plot a circle around each noise source
        th = 0:pi/50:2*pi;
        x_circle = sources(i).position(1) + 1 * cos(th);
        y_circle = sources(i).position(2) + 1 * sin(th);
        plot(x_circle, y_circle, 'k-', 'LineWidth', 1);
    end
    % Plot the walls as dotted red lines
    for i = 1:numel(walls)
        wall = walls(i);
        plot([wall.start(1), wall.end(1)], [wall.start(2), wall.end(2)], 'r--', 'LineWidth', 1.5,'DisplayName',"Wall");
    end
    % Label contour lines with dB increments
    c = contourc(x_range, y_range, Z_smooth, levels);
    clabel(c, 'LabelSpacing', 500);
    
    % Draw a new contour line at the specified dB level
    [~, h] = contour(X, Y, Z_smooth, [locate, locate], 'LineWidth', 2, 'LineColor', 'b');
    legend(h, sprintf('dB: %g', locate));
    

    
    title('Noise Level Contours');
    xlabel('X Position (meters)');
    ylabel('Y Position (meters)');
    grid on;
    hold off;

end
