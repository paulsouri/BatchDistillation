function [RminU] = Underwood(RelVolB,RelVolT,RelVolO,xbotBen,xbotTol,xbotXyl,xdisBen,xdisTol,xdisXyl,step)
%Finding phi of the Underwood equation
    phi = fzero(@(phi)RelVolB.*xbotBen./(RelVolB-phi)...
                +RelVolT.*xbotTol./(RelVolT-phi)+RelVolO.*xbotXyl./(RelVolO-phi),[RelVolO+step RelVolB-step]);
    %Step is added and susbtracted to keep the limit values finite for fzero function

    RminU = -1+ RelVolB.*xdisBen./(RelVolB-phi)...
                +RelVolT.*xdisTol./(RelVolT-phi)+RelVolO.*xdisXyl./(RelVolO-phi);
end 