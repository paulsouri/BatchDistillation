function [RelVolatility] = RelVol(ConsArray1,ConsArray2,TempUpper,TempLower)
    RelVolatilityUpper = AntoinePressure(ConsArray1, TempUpper)/AntoinePressure(ConsArray2, TempUpper);
    RelVolatilityLower = AntoinePressure(ConsArray1, TempLower)/AntoinePressure(ConsArray2, TempLower);
    RelVolatility = sqrt(RelVolatilityUpper*RelVolatilityLower);    
end