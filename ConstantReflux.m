%Ternary Distillation of Benzene, Toluene, O-Xylene
%Clearing the command window and workspace
clear
clc
%Define the characteristics of the feed
F = 25.0068240291;
dF = F/10000;
xbotBen = 0.01351172854;
xbotTol = 0.01718148116;
xbotXyl = 1-(xbotBen+xbotTol);
tol = Inf;
ptarget = 1.1;
step = 0.001;
B = [4.72583	1660.652	-1.461];
T = [4.07827	1343.943	-53.773];
O = [4.12928	1478.244	-59.076];
R = 0;
N = 8;
fileID = fopen('ResultConstantReflux.txt','w');
fprintf(fileID,'----------Starting Operation---------%s--------------',datetime('now'));
[TempUpper,TempLower] = OptimiseTemp(B,O,1.1,500,300);
        while R<30
            disp("N"+N+"R"+R);
            [success,tol,~] = SimulateOperation(F,dF,N,R,xbotTol,xbotBen,xbotXyl,step,B,T,O,TempUpper,TempLower);
            if(success == true && tol<=step*10)
                disp("Done");
                break;    
            end 
            R = R+step*100;
        end

