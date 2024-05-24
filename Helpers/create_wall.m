function wall = create_wall(start, endp, stc,absorb)
    % CREATE_WALL Helper function to create a struct representing a wall
    % 
    %   wall = create_wall(start, end, stc) generates a struct
    %   representing a wall with its start and end points and the STC rating.
    %
    %   Inputs:
    %       start: Start point of the wall [x, y]
    %       end: End point of the wall [x, y]
    %       stc: Sound Transmission Class (STC) rating of the wall
    %
    %   Output:
    %       wall: Struct representing the wall with fields 'start', 'end',
    %             and 'stc'
    if nargin<4
        absorb=0;
    end

    wall.start = start;
    wall.end = endp;
    wall.stc = stc;
    wall.absorb = absorb;
end
