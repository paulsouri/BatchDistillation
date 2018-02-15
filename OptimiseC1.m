function [success,tol,Nmin,RminU,RminG,xdisBen,xdisTol,xdisXyl]  = OptimiseC1(N,R,xbotTol,xbotBen,xbotXyl,step,B,T,O,TempUpper,TempLower)
    RelVolB = RelVol(B,T,TempUpper,TempLower);
    RelVolT = RelVol(T,T,TempUpper,TempLower);
    RelVolO = RelVol(O,T,TempUpper,TempLower);
    InitC1 = 0;
    tol = 1000;
    RminUloop = 0;
    RminGloop = 0;
    xdisloopBen = 0;
    xdisloopTol=0;
    xdisloopXyl =0;
    while(InitC1<N)
            if(tol<=step)
                break;
            end 
     [xdisloopBen,xdisloopTol,xdisloopXyl,~] = HGEquation(RelVolB,RelVolT,RelVolO,xbotBen,xbotTol,xbotXyl,InitC1,step);
     RminUloop = Underwood(RelVolB,RelVolT,RelVolO,xbotBen,xbotTol,xbotXyl,xdisloopBen,xdisloopTol,xdisloopXyl,step);
     [success,RminGloop] = Gilliland (InitC1,R,N,step);
            
    tol = Error (RminGloop,RminUloop,R);
        if(RminGloop>R || RminUloop>R)
            success = false;
            break; 
        end 
    InitC1 = InitC1 + step;
    end
    
    
    if(InitC1<N && success == true)
        success = true;
    else
        success = false;
    end 
    Nmin = InitC1;
    RminU = RminUloop;
    RminG = RminGloop;
    xdisBen = xdisloopBen;
    xdisTol = xdisloopTol;
    xdisXyl = xdisloopXyl;
    
end 