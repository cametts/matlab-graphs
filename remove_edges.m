function [edges, adjacency_matrix] = remove_edges(output, percent)
  vertices = output(:, 1:3, 1);
  edges = output(:, 1:6, 2);
  adjacency_matrix = output(:, :, 3);
  [maxr, ~] = find(edges, 1, 'last');
  edges = edges(1:maxr, :); %remove nonzero rows from the array
  percent = percent/100;
  num_removed = round(percent * maxr); %determine how many edges are removed
  removed_edges = zeros(num_removed, 1);
  i = 1;
  while i <= num_removed %iterate over the list of edges to be removed
      j = randi(maxr);
      if any(j==removed_edges)==0
        removed_edges(i) = j;
        %identify coordinates of the endpoints of removed edge
        x1 = edges(j, 1);
        y1 = edges(j, 2);
        z1 = edges(j, 3);
        x2 = edges(j, 4);
        y2 = edges(j, 5);
        z2 = edges(j, 6);
        %row indices of the endpoints in question
        vertex1 = find(vertices(:, 1)==x1 & vertices(:, 2)==y1 & vertices(:, 3)==z1);
        vertex2 = find(vertices(:, 1)==x2 & vertices(:, 2)==y2 & vertices(:, 3)==z2);
        %remove the edge in the adjacency matrix 
        adjacency_matrix(vertex1, vertex2) = 0;
        adjacency_matrix(vertex2, vertex1) = 0;
        i = i+1;
      end
  end
  edges(removed_edges, :) = 0;
end