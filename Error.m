%Checking tolerance to optimise C1
function [tol] = Error (RminG,RminU,R)
    tol = RminG./R-RminU./R;
    tol = abs(tol);
end