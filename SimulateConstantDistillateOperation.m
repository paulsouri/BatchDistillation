function [success,yield,R]  = SimulateConstantDistillateOperation(F,dF,N,xbotTol,xbotBen,xbotXyl,xdisBenTarget,step,B,T,O,TempUpper,TempLower)
%Check if we can reach Wb<0.0025 for a fixed N and R for particular F and
%dF
still = F;
xoinit = xbotXyl;
Wb = (xbotBen.*78.11)/(xbotBen.*78.11+xbotTol.*92.14+xbotXyl.*106.16);
Wbinit = Wb;
nbytes = 0;  

InitC1 = step;
    while(Wb>0.0025)
        [success,R,xdisBen,xdisTol,~] = CalculateRefluxRate(B,T,O,xbotBen,xbotTol,xbotXyl,xdisBenTarget,TempUpper,TempLower,N,InitC1,step);
        if(success == false)
            disp("Inside Wb loop-->Unsolved N:"+N);
            break;
        end 
        dxb =(dF/still)*(xdisBen-xbotBen);
        dxt = (dF/still)*(xdisTol-xbotTol);
        %Update the mole fraction of individual components
        if(dxt<0 || dxb<0)
           disp("Check logic dxt and dxb is less than zero");
           break;
        end
        xbotBen = xbotBen- dxb;
        xbotTol = xbotTol- dxt;
        xbotXyl = 1-(xbotBen+xbotTol);
        still = still-dF;
        Wb = (xbotBen*78.11)/(xbotBen*78.11+xbotTol*92.14+xbotXyl*106.16);
    end
    
yield = (still*xbotXyl)/(F*xoinit);
N = N +1;
if(success == true && yield>0.9)
    fileID = fopen('ResultConstantDistillate.txt','a+');
    fprintf(fileID,'\n');
    nbytes = fprintf(fileID,' N:%d R:%d Yield:%d Wbinit: %d Wb:%d xbotXyl:%d xoinit:%d',N,R,yield,Wbinit,Wb,xbotXyl,xoinit);
    fclose(fileID);
end 
if(nbytes>0)
    disp("Printed:"+nbytes);    
end 

end 