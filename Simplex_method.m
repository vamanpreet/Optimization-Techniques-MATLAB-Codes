clc
clear all
A = [3 -1 1 1 0 0 7; -1 2 0 0 1 0 6; -4 3 8 0 0 1 10];
C = [-1 3 -3 0 0 0 0];
bvIndex = [4 5 6];
Zj = C(bvIndex)*A - C;
table = [Zj; A];
simplex_table = array2table(table,'VariableNames',{'x1','x2','x3','s1','s2','s3','sol'});
run = true;
while(run)
    if any(Zj(1:end-1)<0)
        [minValue, pvtCol] = min(Zj(1:end-1));
        if all(A(:,pvtCol)<=0)
            error('Unbounded Solution')
        else
            sol = A(:,end);
            col = A(:,pvtCol);
            ratio = zeros(1,size(A,1));
            for i=1:size(A,1)
                if col(i) > 0
                    ratio(i) = sol(i)/col(i);
                else
                    ratio(i) = inf;
                end
                [minRatio, pvtRow] = min(ratio);
            end
            bvIndex(pvtRow) = pvtCol;
            pvtKey = A(pvtRow, pvtCol);
            A(pvtRow,:) = A(pvtRow,:)/pvtKey;
            for i=1:size(A,1)
                if i~=pvtRow
                    A(i,:) = A(i,:) - A(i,pvtCol)*A(pvtRow,:);
                end
            end
            Zj = C(bvIndex)*A - C;
            table = [Zj; A];
            simplex_table = array2table(table,'VariableNames',{'x1','x2','x3','s1','s2','s3','sol'});
        end
    else
        run = false;
        optimalValue = Zj(end);
        fprintf('Optimal Value is %f\n',optimalValue)
    end
end