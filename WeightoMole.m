     
    function r = WeightoMole(weightxylene,weightben,weighttol) 
    molwtben = 78.11;
    molwttol = 92.14;
    molwtxyl = 106.16;
    molxylene = weightxylene/molwtxyl;
    molben = weightben/molwtben;
    moltol = weighttol/molwttol;
    
    r.molperxylene = 100*molxylene/(molxylene+molben+moltol);
    r.molperben = 100*molben/(molxylene+molben+moltol);
    r.molpertol = 100*moltol/(molxylene+molben+moltol);
    
    end
    
    