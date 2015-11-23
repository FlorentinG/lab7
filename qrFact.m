function [table] = qrFact(A,b)
%QRFACT
close all;

%[A,b] = illposed(8);

table = zeros(4,5);
[q,r,p] = qr(A);
d = q'*b;

rank = 8:-1:5;
for i=1:4
    %norm(E)
    table(i,1) = norm(r(rank(i)+1:8,rank(i)+1:8));
    %norm(R11)
    r11 = r(1:rank(i),1:rank(i));
    table(i,2) = cond(r11);
    %estCond(R11)
    dhat = d(1:rank(i));
    table(i,3) = estCond(r11,dhat,rank(i));
    %norm(xhat)
    yhat = r11\dhat;
    xhat = p*[yhat;zeros(8-rank(i),1)];
    table(i,4) = norm(xhat);
    %norm(res)
    table(i,5) = norm(A*xhat-b);
end

%Plot the results
for i=1:5
    subplot(3,2,i);
    semilogy(rank,table(:,i));title(i);
end
end

function [condA] = estCond(A,b,n)
%Estimates the condition number of the given A with variation on b

deltaB = zeros(n,1);
deltaB(ceil(n*rand(n,1))) = (rand(n,1)+1)*eps;

x = A\b;
y = A\(b+deltaB);

condA = norm(b)*norm(x-y)/norm(deltaB)/norm(x);
end

