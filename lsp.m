function [res,param] = lsp()
%LSP Solves the least squares problem with the basis functions given in 
% the assignment.
% res = norm of the residual for n=1:3
% param = contains the values of the parameters a_i,b_i,c_i
%
% Authors : Weicker David & Goyens Florentin
close all;

mauna = load('mauna.dat');
Q = mauna(:,2:13)';
b = Q(:);
m = length(b);
t = (1:m)';

alpha = 0.00037;
e = ones(m,1);
res = zeros(3,1);
param = zeros(8,3);

for n=1:3
    A = [e exp(alpha*t) cos(2*pi*t*(1:n)/12) sin(2*pi*t*(1:n)/12)];
    [q,r] = qr(A);
    x = r\(q'*b);
    res(n) = norm(A*x-b);
    param(1:2+2*n,n) = x;
end

%Plot for n=3
plot(t,b,'bx',t,A*x,'r-');title('LSQ with QR-factorization');xlabel('Time (months)');
ylabel('CO2 concentration (ppm)');

end

