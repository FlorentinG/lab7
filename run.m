% script de test
n = 8;
[A,b] = illposed(n);
tol = 0.1;
sol = A\b;
[x, normE]=qrsolve(A,b,tol);

Error1 = norm(A*sol-b)
Error2 = norm(A*x-b)
