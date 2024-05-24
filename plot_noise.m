function plot_noise(sources, x_range, y_range, locate, walls,num_contour)
    % PLOT_NOISE Function to plot combined noise levels from multiple sources
    % 
    %   plot_noise(sources, x_range, y_range, locate) plots the combined noise levels
    %   from multiple sources on a contour plot, highlighting contour lines near
    %   the specified dB level.
    %
    %   Inputs:
    %       sources: Array of structs representing noise sources, 
    %                each with fields 'position' and 'dB'
    %       x_range(OPTIONAL): Range of X positions for the grid
    %       y_range(OPTIONAL): Range of Y positions for the grid
    %       locate(OPTIONAL): dB level to locate and highlight contour lines within 0.5 dB
    %       walls(OPTIONAL): Array of structs representing walls with start
    %       and end points as well as an stc
    %       num_contour(OPTIONAL): How many contour lines you want
    %
    %   Outputs:
    %       None (Generates a plot)


    %   Example:
    % sources = [
    %     create_source(75,15,0), 
    %     create_source(80,5,5), 
    %     create_source(85,5,0),
    %     create_source(100,-25,25),
    %     create_source(80,25,-25)
    % ];
    % x_range = -50:.5:50;
    % y_range = -50:.5:50;
    % 
    % stc = 50;
    % 
    % walls = [
    %     create_wall([-10,24],[0,24],stc),
    %     create_wall([-10,-50],[0,-50],stc),
    %     create_wall([-10,-50],[-10,24],stc),
    %     create_wall([0,24],[0,-50],25)
    % 
    % ];
    % plot_noise(sources, x_range, y_range,75,walls);
    % plot_noise (sources(1:3));
    % 



    %      % Define the area and grid resolution
    %  If x_range and y_range are not provided, use default values
    
    if nargin < 2
        x_range = -30:0.5:30;
        y_range = -30:0.5:30;
        locate = 0;
        levels = 20;
    end
    if nargin < 4
        locate = 0;
        levels = 20;
    end
    if nargin < 5
        walls=create_wall([0,0],[0,0],0);
        levels = 20;
    end
    if nargin < 6
        levels = 20;
    end
    if nargin == 6
        levels = num_contour;
    
    end

    % Suppress specific warning related to the 'LabelSpacing' property
    warning('off'); 

    % Calculate and plot the combined noise levels
    plot_combined_noise_levels(sources, x_range, y_range,locate,walls,levels);

    % Turn the warning back on after plotting
    warning('on'); 
end





