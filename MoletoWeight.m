function r = MoletoWeight(molexylene,moleben,moletol)
    molwtben = 78.11;
    molwttol = 92.14;
    molwtxyl = 106.16;
    
    weightxylene = molwtxyl*molexylene;
    weighttol = molwttol*moletol;
    weightben = molwtben*moleben;
    
    r.weightperxylene = 100*weightxylene/(weightxylene+weighttol+weightben);
    r.weightpertol = 100*weighttol/(weightxylene+weighttol+weightben);
    r.weightperben = 100*weightben/(weightxylene+weighttol+weightben);
end


