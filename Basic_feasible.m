clc
clear all
A  = [2 3 -1 4; 1 2 6 -7];
B = [8; -3];
C = [2 3 4 7];
n = size(A,2);
m = size(A,1);
if n>m
    no = nchoosek(n,m);
    p = nchoosek(1:n,m);
    sol = [];
    for i=1:no
        y = zeros(1,n);
        a1 = A(:,p(i,:));
        X = a1\B;
        if all(X>=0)
            y(:,p(i,:)) = X;
            sol = [sol; y];
        end
    end
    an = sol*C';
else
    fprintf('Error')
end
[ANS, ind] = max(an);
fprintf('Maximum value : %f at the point [%f %f %f %f]\n', ANS, sol(ind, :))