function output = cartesian_2D(N)
  Ninit = N^0.5;
  numbers_1D = cartesian_1D(Ninit);
  V_1D = numbers_1D(:, 1, 1);
  A_1D = numbers_1D(:, :, 3);
  [Vx, Vy] = meshgrid(V_1D, V_1D);
  V_2D = [Vx(:), Vy(:)]; %list of all possible vertices
  vertex_xcoords = Vx(:);
  vertex_ycoords = Vy(:);
  E_2D = zeros(N*2, 6);
  %first column is each point in the shape
  %second column is the next point to which that point is connected
  edgerow = 1;
  for i=1:N %iterates over each index in vertex_xcoords
    x1 = vertex_xcoords(i);
    y1 = vertex_ycoords(i);
    x2 = vertex_xcoords(i);
    y2 = mod(y1, Ninit)+1; %same transformation as for 1D
    E_2D(edgerow, 1) = x1;
    E_2D(edgerow, 2) = y1;
    E_2D(edgerow, 4) = x2;
    E_2D(edgerow, 5) = y2;
    edgerow = edgerow + 1;
  end
  for j=1:N %iterates over each index in vertex_xcoords
    y1 = vertex_ycoords(j);
    x1 = vertex_xcoords(j);
    y2 = vertex_ycoords(j);
    x2 = mod(x1, Ninit)+1; %1D transformation 
    E_2D(edgerow, 1) = x1;
    E_2D(edgerow, 2) = y1;
    E_2D(edgerow, 4) = x2;
    E_2D(edgerow, 5) = y2;
    edgerow = edgerow + 1;
  end
  I = eye(N^0.5);
  A_2D = kron(A_1D, I) + kron(I, A_1D); %NxN 
  output = zeros(N*2, N, 3);
  output(1:N, 1:2, 1) = V_2D;
  output(:, 1:6, 2) = E_2D;
  output(1:N, 1:N, 3) = A_2D;
end