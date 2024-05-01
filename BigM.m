clc
clear all
M = 10000000;
A = [1 2 -1 1 0 0 2; 3 1 0 0 1 0 3; 1 0 0 0 0 1 4];
C = [-1 3 0 -M 0 0 0];
BV = [4 5 6];
Zj = C(BV)*A - C;
table = [Zj; A];
simplex_table = array2table(table, 'VariableNames',{'x1', 'x2', 's1', 'A1', 's2', 's3', 'sol'})
while true
    if any(Zj(1:end-1)<0)
        [minValue, pvtCol] = min(Zj(1:end-1));
        if (all(A(:,pvtCol) <= 0))
            error('Unbounded Solution')
        else
            sol = A(:,end);
            col = A(:,pvtCol)
            ratio = zeros(1,size(A,1));
            for i=1:size(A,1)
                if col(i)>0
                    ratio(i) = sol(i)/col(i);
                else
                    ratio(i) = inf;
                end
            end
            [minRatio, pvtRow] = min(ratio);
        end
        BV(pvtRow) = pvtCol;
        pvtKey = A(pvtRow, pvtCol);
        A(pvtRow,:) = A(pvtRow,:)/pvtKey;
        for i=1:size(A,1)
            if i~=pvtRow
                A(i,:) = A(i,:) - A(i,pvtCol)*A(pvtRow,:);
            end
        end
        Zj = C(BV)*A - C;
        table = [Zj; A];
        simplex_table = array2table(table, 'VariableNames',{'x1', 'x2', 's1', 'A1', 's2', 's3', 'sol'})
    else
        optimal = Zj(end);
        fprintf('Optimal Solution : %f\n', optimal)
        break;
    end
end