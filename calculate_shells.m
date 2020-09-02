function shells = calculate_shells(balls)
  ballsize = size(balls);
  N = ballsize(1);
  depth = ballsize(2);
  shells = zeros(N, depth);
  for r=1:depth
    if r==1 
      shells(:, r) = balls(:, 1);
    else
      shells(:, r) = balls(:, r) - balls(:, (r-1));
    end
  end
end