function [isPathPossible, intersectionPoint] = checkPath(S1, E1, P1, P2)
    % Input: S1, E1, P1, P2 are 1x2 vectors representing points [x, y]
    % Output: isPathPossible is a boolean indicating if the path is possible
    %         intersectionPoint is the point of intersection if it exists

    % Helper function to reflect a point E1 across the line segment P1P2
    function E1_reflected = reflectPoint(E1, P1, P2)
        % Vector along the line segment
        v = P2 - P1;
        % Vector from P1 to E1
        w = E1 - P1;
        % Project w onto v
        proj = dot(w, v) / dot(v, v) * v;
        % Calculate the perpendicular component
        perp = w - proj;
        % Reflect E1
        E1_reflected = E1 - 2 * perp;
    end

    % Reflect E1 across the line segment P1P2
    E1_reflected = reflectPoint(E1, P1, P2);

    % Helper function to check if two line segments intersect and find intersection point
    function [intersect, intersectPoint] = doLineSegmentsIntersect(A1, A2, B1, B2)
        % Function to check if two line segments A1A2 and B1B2 intersect
        function val = crossProduct(P, Q, R)
            val = (Q(1) - P(1)) * (R(2) - P(2)) - (Q(2) - P(2)) * (R(1) - P(1));
        end

        function val = isOnSegment(P, Q, R)
            val = (min(P(1), Q(1)) <= R(1)) && (R(1) <= max(P(1), Q(1))) && ...
                  (min(P(2), Q(2)) <= R(2)) && (R(2) <= max(P(2), Q(2)));
        end

        d1 = crossProduct(B1, B2, A1);
        d2 = crossProduct(B1, B2, A2);
        d3 = crossProduct(A1, A2, B1);
        d4 = crossProduct(A1, A2, B2);

        if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) && ...
            ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0)))
            intersect = true;
        elseif (d1 == 0 && isOnSegment(B1, B2, A1))
            intersect = true;
        elseif (d2 == 0 && isOnSegment(B1, B2, A2))
            intersect = true;
        elseif (d3 == 0 && isOnSegment(A1, A2, B1))
            intersect = true;
        elseif (d4 == 0 && isOnSegment(A1, A2, B2))
            intersect = true;
        else
            intersect = false;
        end

        if intersect
            % Calculate the intersection point
            t = ((B1(1) - A1(1)) * (B1(2) - B2(2)) - (B1(2) - A1(2)) * (B1(1) - B2(1))) / ...
                ((A1(1) - A2(1)) * (B1(2) - B2(2)) - (A1(2) - A2(2)) * (B1(1) - B2(1)));
            intersectPoint = A1 + t * (A2 - A1);
        else
            intersectPoint = [];
        end
    end

    % Check if the line segment S1 to E1_reflected intersects P1P2
    [isPathPossible, intersectionPoint] = doLineSegmentsIntersect(S1, E1_reflected, P1, P2);
end
