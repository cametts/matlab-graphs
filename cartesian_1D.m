function output = cartesian_1D(N)
  V_1D = 1:N; %vertex list 
  E = [V_1D; mod((V_1D), N)+1]'; %list of all edges 
  A_1D = E2A( N, E ); %adjacency matrix 
  output = zeros(N, N, 3);
  E_1D = zeros(N, 6);
  E_1D(:, 1) = V_1D;
  E_1D(:, 4) = mod((V_1D), N)+1;
  output(:, 1, 1) = V_1D;
  output(:, 1:6, 2) = E_1D;
  output(1:N, 1:N, 3) = A_1D;
end
