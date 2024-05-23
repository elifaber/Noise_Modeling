function resultant_dB = SPL_point(sources, point, walls,ref_pressure)
    % SPL_point - Computes SPL at a point from multiple noise sources
    %
    % Syntax: resultant_dB = SPL_point(sources, point, ref_pressure)
    %
    % Inputs:
    %    sources - Struct array with fields 'position' ([x, y]) and 'dB' (scalar)
    %    point - Position [x, y] of the point where SPL is calculated
    %    ref_pressure (optional) - Reference pressure level (default is 20 µPa)
    %
    % Output:
    %    resultant_dB - Resultant dB SPL at the specified point

    if nargin < 3
        ref_pressure = 20e-6;
        walls = create_wall(0,0,0);
    end
    if nargin < 4
        ref_pressure = 20e-6;
    end

    num_sources = length(sources);
    dB_values = zeros(1, num_sources);

    for i = 1:num_sources
        source = sources(i);
        distance = norm(point - source.position);
        dB_values(i) = SPL_decay(source.dB, distance);
        for j=1:length(walls)
            if intersects(source,point,walls(j))
                dB_values(i)=dB_values(i)-walls(j).stc;
            end
        end
    end

    resultant_dB = SPL_add(dB_values,ref_pressure);
end
