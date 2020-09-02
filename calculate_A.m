%% Calculates and returns the adjacency matrix
%vertices: Nx3 list of vertices (see in draw_* functions)
%epsilon: connection length (recommended 0.6-1.3)
function A=calculate_A(vertices, epsilon)
  if epsilon==0
      epsilon = 1.1;
  end
  sizevert = size(vertices);
  N = sizevert(1);
  A = sparse(N, N);
  h = waitbar( 0, 'building adjacency matrix' ); %waitbar while A is made
  for i = 1:N 
    dist = sum( (vertices-repmat(vertices(i,:), N, 1)).^2, 2 );
    %Calculates the squared distance from the point in question to all
    %other points
    dist(1:i) = inf; %prevents redundancy 
    j = find( dist <= epsilon^2 );   
    A = A + sparse( i*ones(size(j)), j, ones(size(j)), N, N );
    waitbar(i/N, h);
  end
close(h);
A = A+A';
end