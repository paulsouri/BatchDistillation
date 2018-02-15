%Calculate the temperatures at the upper and lower portion of the column
function [Tupper,Tlower] = OptimiseTemp(B,O,pressure,Testimate1,Testimate2)
      Tupper = fzero(@(Temp) AntoinePressure(B,Temp)- pressure,Testimate1);  
      Tlower = fzero(@(Temp)AntoinePressure(O,Temp)- pressure,Testimate2);
end