clc 
clear all
cost = [5 1 8 7 5; 3 9 6 7 8; 4 2 7 6 5; 7 11 10 4 9];
demand = [30 20 15 10 20];
supply = [15 25 42 35];
if(sum(supply) == sum(demand))
    fprintf('Balanced\n')
else
    fprintf('Unbalanced\n')
    if(sum(supply) < sum(demand))
        cost(end+1,:) = zeros(1,length(demand));
        supply(end+1) = sum(demand) - sum(supply);
    else
        cost(:,end+1) = zeros(length(supply),1);
        demand(end+1) = sum(supply) - sum(demand);
    end
end
disp(cost);
disp(demand);
disp(supply);
[m, n] = size(cost);
X = zeros(m,n);
initial = cost;
while true
    minCost = min(min(cost));        % minCost = min(cost(:))
    if(minCost == inf)
        break;
    end
    [p1, q1] = find(minCost == cost);
    val = min(supply(p1), demand(q1));
    [w, ind] = max(val);
    p = p1(ind);
    q = q1(ind);
    X(p,q) = w;
    supply(p) = supply(p) - w;
    demand(q) = demand(q) - w;
   % cost(p,q) = inf;
   if(supply(p) == 0)
       cost(p,:) = inf;
   else
       cost(:,q) = inf;
   end
end
Z = sum(sum(initial.*X));
disp(Z);