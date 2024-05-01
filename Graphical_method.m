clc
clear all
A = [-1 3; 1 1; 1 -1; 1 0; 0 1];
B = [10; 6; 2; 0; 0];
C = [1 5];
x1 = 0:max(B)
x =[]
for i=1:size(A,1)
    x(i,:) = (B(i)-A(i,1)*x1)/A(i,2)
    x(i,:) = max(0,x(i,:))
end
plot(x1, x(1,:),'r',x1,x(2,:),'b',x1, x(3,:),'g')
xlabel('x1')
ylabel('x2')
legend('-x1+3x2<=10','x1+x2<=6','x1-x2<=2')
sol =[]
for i=1:size(A,1)-1
    a1 = A(i,:)
    b1 = B(i)
    for j=i+1:size(A,1)
        a2 = A(j,:)
        b2 = B(j)
        a3 = [a1; a2]
        b3 = [b1; b2]
        X = a3\b3
        sol = [sol X]
    end
end
sol = sol'
for i=1:3
    h = find(A(i,1)*sol(:,1) + A(i,2)*sol(:,2) > B(i))
    sol(h,:) = []
end
for i=4:5
    h = find(A(i,1)*sol(:,1) + A(i,2)*sol(:,2) < B(i))
    sol(h,:) = []
end
an = []
for i=1:size(sol,1)
    an = [an sol(i,:)*C']
end
[ANS ind] = max(an)
sol(ind,:)
fprintf('Optimal solution : %f at point [%f %f]\n',ANS,sol(ind,:))