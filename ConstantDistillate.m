%Ternary Distillation of Benzene, Toluene, O-Xylene
%Clearing the command window and workspace
clear
clc
%Define the characteristics of the feed
F = 25.0068240291;
dF = F/100000;
xbotBen = 0.01351172854;
xbotTol = 0.01718148116;
xbotXyl = 1-(xbotBen+xbotTol);
tol = Inf;
ptarget = 1.1;
step = 0.001;
B = [4.72583	1660.652	-1.461];
T = [4.07827	1343.943	-53.773];
O = [4.12928	1478.244	-59.076];
fileID = fopen('ResultConstantDistillate.txt','w');
fprintf(fileID,'----------Starting Operation Constant Distillate---------%s--------------',datetime('now'));
[TempUpper,TempLower] = OptimiseTemp(B,O,1.1,500,300);
xdisBenTarget = 0.5;
N = 10;
while (N <11)
      while(xdisBenTarget<0.98)  
      [success,yield,R]  = SimulateConstantDistillateOperation(F,dF,N,xbotTol,xbotBen,xbotXyl,xdisBenTarget,step,B,T,O,TempUpper,TempLower);
            if(success == true && R<5)
                disp("Done");
                disp("N:"+N+" R:"+R+" xDisBenTarget:"+xdisBenTarget);
                break;    
            end
      disp("N:"+N+"R:"+R+"xDisBenTarget:"+xdisBenTarget);
      xdisBenTarget = xdisBenTarget + step;
      end 
N = N+1;
end




