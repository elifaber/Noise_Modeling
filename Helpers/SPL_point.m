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
    num_walls = length(walls);
    dB_values = zeros(1, num_sources*num_walls);

    for i = 1:num_sources
        source = sources(i);
        distance = norm(point - source.position);
        dB_values(i) = SPL_decay(source.dB, distance);
        
        %check to see if the path intersects with a wall 
        for j=1:length(walls)
            if intersects(source,point,walls(j))
                dB_values(i)=dB_values(i)-walls(j).stc;
            end

            %check for reflections
            S=source.position;
            E=point;
            P1=walls(j).start;
            P2=walls(j).end;
            [verify,sect] = checkPath(E,S,P1,P2);
            if verify
                source2int = norm(sect - source.position);
                int2point = norm(point - sect);
                total_dist = source2int+int2point;
                k=num_sources+j;
                dB_values(k)=SPL_decay(source.dB,total_dist);
                dB_values(k)=dB_values(k)-dB_values(k)*walls(j).absorb-(dB_values(k)-walls(j).stc);
                if dB_values(k)<0
                    dB_values(k)=0;
                end
                %checks to seee if reflections pass through any other walls
                for z=1:j-1
                    if intersects(source,sect,walls(z))
                        dB_values(k)=dB_values(k)-walls(z).stc;
                    end
                end
                for z=j+1:length(walls)
                    if intersects(source,sect,walls(z))
                        dB_values(k)=dB_values(k)-walls(z).stc;
                    end
                end
            end
        end
    end

    resultant_dB = SPL_add(dB_values,ref_pressure);
end
