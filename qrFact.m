function [table, condA, estimCondA] = qrFact()
% qrFact Solve the task one for the lab7 that is the analysis of the
% solution for an ill-posed system with qr-factorization
%
% table(:,1) is norm(E) for rank = [8,7,6,5]
% table(:,2) is norm(res) for rank = [8,7,6,5]
% table(:,3) is cond(R11) for rank = [8,7,6,5]
% table(:,4) is estimationCond(R11) for rank = [8,7,6,5]
% table(:,5) is norm(xhat) for rank = [8,7,6,5]
%
% Authors : Weicker David & Goyens Florentin
close all;
format long
[A,b] = illposed(8);

table = zeros(4,5);

[q,r,p] = qr(A);
d = q'*b;
condA = cond(A);
estimCondA = estimationCond(A,b,8);
rank = 8:-1:5;
for i=1:4
    % compute norm(E)
    table(i,1) = norm(r(rank(i)+1:8,rank(i)+1:8));
    % compute cond(R11)
    r11 = r(1:rank(i),1:rank(i));
    table(i,3) = cond(r11);
    % compute estimationCond(R11)
    dhat = d(1:rank(i));
    table(i,4) = estimationCond(r11,dhat,rank(i));
    % compute norm(xhat)
    yhat = r11\dhat;
    xhat = p*[yhat;zeros(8-rank(i),1)];
    table(i,5) = norm(xhat);
    % compute norm(res)
    table(i,2) = norm(A*xhat-b);
end

titre = {'norm(E)','norm(res)','cond(R11)', 'estimationCond(R11)'};
%Plot the results
for i=1:4
    subplot(2,2,i);
    semilogy(rank,table(:,i));title(titre{i});
    xlabel('rank(E)');
end
end

function [condA] = estimationCond(A,b,n)
% Estimates the condition number of matrix A with variation on b
% n is the size of A

condA = 0;
for j=1:1000    
    deltaB = 1e-8*(rand(n,1)+1);

    x = A\b;
    y = A\(b+deltaB);

    condA = max(condA,norm(b)*norm(x-y)/(norm(deltaB)*norm(x)));
end
end
