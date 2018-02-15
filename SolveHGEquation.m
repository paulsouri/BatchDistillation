function [C1,xdisBen,xdisTol,xdisXyl,xdisTot] = SolveHGEquation(B,T,O,TempUpper,TempLower,xbotBen,xbotTol,xbotXyl,xdisBenTarget,InitC1,step)

RelVolTolBen = RelVol(T,B,TempUpper,TempLower);
RelVolXylBen = RelVol(O,B,TempUpper,TempLower);

K = xbotBen/xdisBenTarget;
C1 = fzero(@(C1)xbotBen+RelVolTolBen^C1*xbotTol+RelVolXylBen^C1*xbotXyl-K,InitC1);
if(C1<0)
    disp("SolveHGEquation failed to solve. Check your code.")
end

RelVolB = RelVol(B,T,TempUpper,TempLower);
RelVolT = RelVol(T,T,TempUpper,TempLower);
RelVolO = RelVol(O,T,TempUpper,TempLower);
[xdisBen,xdisTol,xdisXyl,xdisTot] = HGEquation(RelVolB,RelVolT,RelVolO,xbotBen,xbotTol,xbotXyl,C1,step);
if(abs(xdisBen-xdisBenTarget)>step)
    disp("Inside SolveHGEquation --> xdisBen and xdisBenTarget mismatch");
end
end 