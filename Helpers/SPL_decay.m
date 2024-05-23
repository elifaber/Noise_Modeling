function decayed_dB = SPL_decay(initial_dB, distance, start_distance)
    % SPL_decay - Calculates the decay of sound pressure level (dB SPL) with distance
    %
    % Syntax: decayed_dB = SPL_decay(initial_dB, distance, start_distance)
    %
    % Inputs:
    %    initial_dB - Initial dB SPL value at the starting distance (scalar)
    %    distance - Distance away from the source where dB SPL is calculated (scalar)
    %    start_distance (optional) - Starting distance from the source (default is 1 meter)
    %
    % Output:
    %    decayed_dB - Decayed dB SPL value at the specified distance

    % Default starting distance
    if nargin < 3
        start_distance = 1;
    end

    % Check if inputs are scalars and greater than zero
    if ~isscalar(initial_dB) || ~isscalar(distance) || ~isscalar(start_distance)
        error('Initial dB, distance, and start distance must be scalars.');
    end
    if initial_dB <= 0 || distance <= 0 || start_distance <= 0
        error('Initial dB, distance, and start distance must be greater than zero.');
    end

    % Calculate the decayed dB SPL using the inverse square law
    decayed_dB = initial_dB - 20 * log10(distance / start_distance);
end
