function output = cartesian_3D(N)
  Ninit = N^(1/3);
  numbers_1D = cartesian_1D(Ninit);
  V_1D = numbers_1D(:, 1, 1);
  A_1D = numbers_1D(1:Ninit, 1:Ninit, 3);
  [Vx, Vy, Vz] = meshgrid(V_1D, V_1D, V_1D);
  V_3D = [Vx(:), Vy(:), Vz(:)];
  vertex_xcoords = Vx(:);
  vertex_ycoords = Vy(:);
  vertex_zcoords = Vz(:);
  E_3D = zeros(N*3, 6);
  %first 3 columns represent each point in the shape
  %second set of 3 columns is the next point to which that point is connected
  edgerow = 1;
  for i=1:N %iterates over each index in vertex_xcoords
    %same x and z, different y 
    x1 = vertex_xcoords(i);
    y1 = vertex_ycoords(i);
    z1 = vertex_zcoords(i);
    x2 = vertex_xcoords(i);
    y2 = mod(y1, Ninit)+1; %same transformation as for 1
    z2 = vertex_zcoords(i);
    E_3D(edgerow, 1) = x1;
    E_3D(edgerow, 2) = y1;
    E_3D(edgerow, 3) = z1;
    E_3D(edgerow, 4) = x2;
    E_3D(edgerow, 5) = y2;
    E_3D(edgerow, 6) = z2;
    edgerow = edgerow + 1;
  end
  for i=1:N %iterates over each index in vertex_xcoords
    %same y and z, different x 
    x1 = vertex_xcoords(i);
    y1 = vertex_ycoords(i);
    z1 = vertex_zcoords(i);
    x2 = mod(x1, Ninit)+1;
    y2 = vertex_ycoords(i); %same transformation as for 1D
    z2 = vertex_zcoords(i);
    E_3D(edgerow, 1) = x1;
    E_3D(edgerow, 2) = y1;
    E_3D(edgerow, 3) = z1;
    E_3D(edgerow, 4) = x2;
    E_3D(edgerow, 5) = y2;
    E_3D(edgerow, 6) = z2;
    edgerow = edgerow + 1;
  end
  for i=1:N %iterates over each index in vertex_xcoords
    %same x and y, different z 
    x1 = vertex_xcoords(i);
    y1 = vertex_ycoords(i);
    z1 = vertex_zcoords(i);
    x2 = vertex_xcoords(i);
    y2 = vertex_ycoords(i); %same transformation as for 1D
    z2 = mod(z1, Ninit)+1;
    E_3D(edgerow, 1) = x1;
    E_3D(edgerow, 2) = y1;
    E_3D(edgerow, 3) = z1;
    E_3D(edgerow, 4) = x2;
    E_3D(edgerow, 5) = y2;
    E_3D(edgerow, 6) = z2;
    edgerow = edgerow + 1;
  end
  I1 = eye(Ninit);
  I2 = eye(Ninit^2);
  A_2D = kron(A_1D, I1) + kron(I1, A_1D); %NxN  
  A_3D = kron(A_2D, I1) + kron(I2,A_1D);
  output = zeros(N*3, N, 3);
  output(1:N, 1:3, 1) = V_3D;
  output(:, 1:6, 2) = E_3D;
  output(1:N, 1:N, 3) = A_3D;
end