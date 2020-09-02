function eccentricity=vertex_eccentricity(A, depth, V0)
  
  if depth==0
      depth = 1000;
  end
  if V0==0
      V0=1;
  end
  balls = calculate_balls(A, depth, V0);
  shells = calculate_shells(balls);
  for i=1:depth
      shellsum = sum(shells(:, i));
      if shellsum == 0
          eccentricity = i;
          break
      end
  end
end