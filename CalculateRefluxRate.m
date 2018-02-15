function [success,R,xdisBen,xdisTol,xdisXyl] = CalculateRefluxRate(B,T,O,xbotBen,xbotTol,xbotXyl,xdisBenTarget,TempUpper,TempLower,N,InitC1,step)
RelVolB = RelVol(B,T,TempUpper,TempLower);
RelVolT = RelVol(T,T,TempUpper,TempLower);
RelVolO = RelVol(O,T,TempUpper,TempLower);

[C1,xdisBen,xdisTol,xdisXyl,~] = SolveHGEquation(B,T,O,TempUpper,TempLower,xbotBen,xbotTol,xbotXyl,xdisBenTarget,InitC1,step);
Rmin = Underwood(RelVolB,RelVolT,RelVolO,xbotBen,xbotTol,xbotXyl,xdisBen,xdisTol,xdisXyl,step);

if(C1>N)
    error('C1 or Nmin is greater than N');
elseif(C1==N)
    error('C1 is equal to N');
end 

Y = (N-C1)/(N+1);
        if(Y<1 && Y>0)
            X = fzero(@(X)1-Y-exp((1+54.4*X)*(X-1)/(11+117.2*X)/sqrt(X)),[0+step 1-step]);
            success = true;
        else 
            %disp('Gilliland equation not solved check the arguments');
            X = Inf;
            success = false;
        end
        
R = (Rmin+X)/(1-X);

end 