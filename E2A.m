%% Function to convert a matrix to a sparse matrix
function A = E2A( N, E )
    %only works for 1D Cartesian shapes
    A = sparse(E(:,1), E(:,2), 1, N,N);
    A = A + A';
end
