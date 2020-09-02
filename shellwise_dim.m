function dimension = shellwise_dim(shells, m, k, knotpos)
  if m==0
      m = 1;
  end
  if k==0
      k = 1;
  end
  shellsize = size(shells);
  depth = shellsize(2);
  maxr = depth;
  b = zeros(depth, 1);
  for r=1:depth
    countr = tabulate(shells(:, r)); %counts the number of 1s and 0s in each shell
    if size(countr) == [1 3] %means an empty shell has been reached
      maxr = r-1;
      break
    else
      b(r, 1) = log10(countr(2,2)); %countr(2, 2) is the number of 1's in shell
    end
  end
  b = b(1:maxr, 1);
  Alpha = zeros(maxr, 2);
  for rows=1:maxr
    Alpha(rows, 1) = log10(rows);
    Alpha(rows, 2) = 1;
  end
  clear rows
  %[dimension, extraneous] = Alpha \ b
  %calculate dimension of each vertex based on its neighbors (m behind, k
  %ahead)
  dimension = zeros(maxr, 1);
  dimension(1) = 3;
  for shl=2:(maxr-1)
    Aa = Alpha((shl-m):(shl+k), :);
    bb = b((shl-m):(shl+k), :);
    c = Aa\bb;
    dimension(shl) = c(1);  
  end
  x = 1:maxr;
  dimeplot = slmengine(x, dimension, 'degree', 0, 'knots', [knotpos(1),...
    knotpos(2), knotpos(3)-4, knotpos(4)+1], 'plot', 'on'); hold on;
  axis([0 knotpos(4)+5 -5 5])
  eqs = slm2pp(dimeplot);
  coefs = eqs.coefs;
  dime1 = coefs(1,1) + 1;
  dime2 = coefs(2,1) + 1;
  dime3 = coefs(3,1) + 1;
  title('Dimension based upon "accepted" knot estimates');
  text(x(5), dimension(5), ['dim = ', num2str(dime1)], 'FontSize', 13,...
    'VerticalAlignment', 'Top')
%   text(x(20), dimension(20), ['dim = ', num2str(dime2)], 'FontSize', 13,...
%     'VerticalAlignment', 'Top')
  
  

end