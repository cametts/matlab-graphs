%% Calculates adjacency matrix
%optimized for parallel computing
function A = calculate_A_meri(V, epsilon)
  if epsilon == 0
      epsilon = 1.1;
  end
  sizevert = size(V);
  N = sizevert(1);
  parfor i = 1:N
    dist = sum( (V-repmat(V(i,:), N, 1)).^2, 2 ); %distance (squared) from 
    %vertex in question to all other vertices 
    dist(1:i) = inf; %prevents redundancy 
    j = find( dist <= epsilon^2 ); %identify all adjacent vertices by index
    I{i} = i*ones(size(j)); %I and J are cell arrays
    J{i} = j;
    %I is composed of the vertex number, repeated once for each adjacent
    %vertex
    %J is all adjacent vertices 
  end
  cat(1, I{:})
  A = sparse( cat(1,I{:}), cat(1,J{:}), 1, N, N );
  %cat makes I and J into column vectors 
  %the position at (i, j) is assigned to 1
  %size is NxN
  A = A+A';

end