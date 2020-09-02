function balls=calculate_balls(A, depth, V0)
  if depth==0
      depth = 100;
  end
  if V0==0
      V0=1;
  end
  sizeA = size(A);
  N = sizeA(1);
  balls = zeros(N, depth);
  balls(:, 1) = A(:, V0);
  d_phi = zeros(depth,1);
  phi = zeros(N,1); %Nx1 array of zeros
  phi(V0) = 1; 
  for d = 1:depth
    n_phi = (speye(N)+A)*phi; %NxN identity matrix plus A, times phi
    n_phi( n_phi > 1 ) = 1; %if n_phi is greater than 1, make it 1
    d_phi(d) = d_phi(d) + sum(n_phi) - sum(phi); %sum does the sum of the columns
    %changes the value of d_phi at the specified index 
    phi = n_phi;
  balls(:, d) = n_phi;  
  end
  

end