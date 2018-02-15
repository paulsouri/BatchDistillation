function [success,RminG] = Gilliland (C1,R,N,step) %C1=Nmin
    Y = (N-C1)/(N+1);
    X = Inf;
        if(Y<1 && Y>0)
            X = fzero(@(X)1-Y-exp((1+54.4*X)*(X-1)/(11+117.2*X)/sqrt(X)),[0+step 1-step]);
            success = true;
        else 
            %disp('Gilliland equation not solved check the arguments');
            success = false; 
        end 
    RminG = R-(R+1)*X;
    
end 
