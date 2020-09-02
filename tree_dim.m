function tree_dim(shells)
  maxr = size(shells, 2);
  shell_size = zeros(maxr, 1);
  for r=1:maxr
      target_shell = shells(:, r);
      shell_size(r) = sum(target_shell);
  end
  x_trans = (log10(1:maxr))';
  y_trans = log10(shell_size);
  plot(x_trans, y_trans, 'bo'); hold on;
  tree_poly = fit(x_trans, y_trans, 'poly2')
  plot(tree_poly, x_trans, y_trans);
  
 
end