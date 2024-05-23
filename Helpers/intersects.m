function intersecting = intersects(sources, point, wall)
    intersecting = false;

    % Iterate over each source
    for i = 1:numel(sources)
        source_position = sources(i).position;

        % Check if the line segment intersects with the wall
        if is_intersecting(source_position, point, wall)
            intersecting = true;
            return;
        end
    end
end

function intersecting = is_intersecting(source_position, point, wall)
    % Unpack wall coordinates
    x1 = wall.start(1);
    y1 = wall.start(2);
    x2 = wall.end(1);
    y2 = wall.end(2);

    % Unpack source and point coordinates
    x3 = source_position(1);
    y3 = source_position(2);
    x4 = point(1);
    y4 = point(2);

    % Check if the line segment intersects with the wall using cross products
    denominator = (y2 - y1) * (x4 - x3) - (x2 - x1) * (y4 - y3);
    if denominator == 0
        % Lines are parallel or coincident
        intersecting = false;
    else
        % Calculate intersection parameters
        ua = ((x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1)) / denominator;
        ub = ((x4 - x3) * (y3 - y1) - (y4 - y3) * (x3 - x1)) / denominator;

        % Check if intersection occurs within line segments
        intersecting = (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1);
    end
end
