function [U S V] = mySVD(A)
% Computes the Singular Value Decomposition of any mxn matrix A
[m n] = size(A);
    if(m<=n)
        [U S] = eig(A*A');
        S = sqrt(S);
        V = S\(U'*A); %this will only have m vectors, the rest are null vectors
        S = cat(2,S,zeros(m,n-m));
        Z = null(A);
        V = cat(2, V',Z);

    else
        [V S] = eig(A'*A);
        S = sqrt(S);
        U = (A*V)/S;
        S = cat(1,S,zeros(m-n,n));
        Z = null(A');
        U = cat(2, U,Z);
    end

end
