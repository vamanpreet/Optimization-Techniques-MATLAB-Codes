clc
clear all
syms x1 x2
f = x1^2 - x1*x2 + x2^2;
f1 = inline(f);
fx = @(X) f1(X(1), X(2));
g = gradient(f);
g1 = inline(g);
gx = @(X) g1(X(1), X(2));
H = hessian(f);
X0 = [1 1/2];
tol = 0.05;
i = 0;
i_max = 5;
while norm(gx(X0)) > tol && i<i_max
    S = -gx(X0);
    lembda = (S'*S)/(S'*H*S);
    X1 = X0 + lembda*S';
    X0 = X1;
    i = i + 1;
end
fx(X0)