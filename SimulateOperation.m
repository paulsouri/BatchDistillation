function [success,tol,yield]  = SimulateOperation(F,dF,N,R,xbotTol,xbotBen,xbotXyl,step,B,T,O,TempUpper,TempLower)
%Check if we can reach Wb<0.0025 for a fixed N and R for particular F and
%dF
Rmin = 0;
Nmin = 0;
still = F;
xoinit = xbotXyl;
Wb = (xbotBen.*78.11)/(xbotBen.*78.11+xbotTol.*92.14+xbotXyl.*106.16);
Wbinit = Wb;
nbytes = 0;  
tol = 0;
    while(Wb>0.0025)
        if(Rmin>R || Nmin>N)
            break;
        end
        [success,tol,Nmin,Rmin,xdisBen,xdisTol,~] = OptimiseC1(N,R,xbotTol,xbotBen,xbotXyl,step,B,T,O,TempUpper,TempLower);
        if(success == false)
            %disp("N:"+N+"R:"+R+"Unsolved");
            break;
        end 
        if(xdisBen<xbotBen || xdisTol<xbotTol)
            break;
            disp("Distillate error");
        end 
        dxb =(dF/still)*(xdisBen-xbotBen);
        dxt = (dF/still)*(xdisTol-xbotTol);
        if(dxt<0 || dxb<0)
           disp("Check logic dxt and dxb is less than zero");
           break;
        end
        %Update the mole fraction of individual components
        xbotBen = xbotBen- dxb;
        xbotTol = xbotTol- dxt;
        xbotXyl = 1-(xbotBen+xbotTol);
        still = still-dF;
        Wb = (xbotBen*78.11)/(xbotBen*78.11+xbotTol*92.14+xbotXyl*106.16);
    end
    
yield = (still*xbotXyl)/(F*xoinit); 
N = N +1;
if(success == true && tol<=step*10 && yield>0.9)
    fileID = fopen('ResultConstantReflux.txt','a+');
    fprintf(fileID,'\n');
    nbytes = fprintf(fileID,' N:%d R:%d Yield:%d Wbinit: %d Wb:%d xbotXyl:%d xoinit:%d',N,R,yield,Wbinit,Wb,xbotXyl,xoinit);
    fclose(fileID);
end 
if(nbytes>0)
    disp("Printed"+nbytes);    
end 

end 