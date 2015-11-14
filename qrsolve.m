function [x, normE]=qrsolve(A,b,tol)
n = length(b);
x = zeros(n,n);
[Q, R11, ~, E, P]=rankreduce(A,tol);
m = length(E);
d = Q'*b;
d = d(1:(n-m));
y = R11\d;
x = P*[y; zeros(m,1)];
normE = norm(E,2);
end



