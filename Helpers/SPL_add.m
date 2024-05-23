function total_dB = SPL_add(dB_array, ref_pressure)
    % SPL_add - Adds the dB SPL values of several sources
    %
    % Syntax: total_dB = SPL_add(dB_array, ref_pressure)
    %
    % Input:
    %    dB_array - Array of dB SPL values (vector)
    %    ref_pressure (optional) - Reference pressure level (default is 20 µPa)
    %
    % Output:
    %    total_dB - Total dB SPL value after summing the sources

    % Check if input is a non-empty vector
    if nargin < 2
        ref_pressure = 20e-6;
    end

    if isempty(dB_array) || ~isvector(dB_array)
        error('Input must be a non-empty vector');
    end

    % Convert dB SPL values to linear scale (pressure values)
    pressure_values = 10 .^ (dB_array / 20);

    % Scale pressure values by the reference pressure
    pressure_values = ref_pressure * pressure_values;

    % Sum the pressure values
    total_pressure = sum(pressure_values);

    % Convert the summed pressure value back to dB SPL
    total_dB = 20 * log10(total_pressure / ref_pressure);
end
