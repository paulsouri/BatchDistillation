function [xdisBen,xdisTol,xdisXyl,xdisTot] = HGEquation(RelVolB,RelVolT,RelVolO,xbotBen,xbotTol,xbotXyl,InitC1,step)
%Finding the distillate compositions
xdisTol = 1/((RelVolB^InitC1*xbotBen/xbotTol)+RelVolT+(RelVolO^InitC1*xbotXyl/xbotTol));    
xdisBen = RelVolB^InitC1*xdisTol/xbotTol*xbotBen;
xdisXyl = RelVolO^InitC1*xdisTol/xbotTol*xbotXyl;
xdisTot = xdisTol+xdisBen+xdisXyl;
    if(abs(xdisTot-1)>=step)
        error('Calculation failed xdisTot not converging');
    end 

end 