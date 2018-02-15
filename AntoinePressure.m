function [PressureSat] = AntoinePressure(ConsArray, Temp)
    %Antoine equation, Temp in K and P in bar
    log10P = ConsArray(1) - ConsArray(2)./(Temp+ConsArray(3));
    % Computing P
    PressureSat = 10.^log10P;
end