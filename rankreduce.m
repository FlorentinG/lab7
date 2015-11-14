function [Q, R11, R12, E, P]=rankreduce(A,tol)
n = length(A);
[Q,R,P] = qr(A);

% find size of E = m x m
E = R;
for i = 1:n
    if norm(E,2)<= tol
        break;
    else
        E = E(2:end,2:end);  
    end
end
m = length(E);

E = R(n-m+1:end, n-m+1:end);
R12 = R(1:(n-m), n-m+1:end);
R11 = R(1:(n-m), 1:(n-m));

end