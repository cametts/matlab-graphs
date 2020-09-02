function knotpos = loglog_dim(shells)
  shellnum = size(shells);
  maxr = shellnum(2);
  shell_size = zeros(maxr, 1);
  for r=1:maxr
      target_shell = shells(:, r);
      shell_size(r) = sum(target_shell);
  end
  x_trans = log10(1:maxr);
  y_trans = log10(shell_size);
  dimplot = slmengine(x_trans, y_trans, 'knots', 3, 'interiorknots', ...
    'free', 'degree', 1, 'plot', 'on');
  title('Dimension');
  xlabel('log(radius of enclosing ball)');
  ylabel('log(number of vertices in enclosing ball)');
  eqs = slm2pp(dimplot);
  coefs = eqs.coefs
  dim1 = coefs(1,1) + 1;
  dim2 = coefs(2,1) + 1;
%   dim3 = coefs(3,1) + 1;
  text(x_trans(2), y_trans(2), ['dim = ', num2str(dim1)], 'FontSize', 13,...
    'VerticalAlignment', 'Top')
  text(x_trans(6), y_trans(6), ['dim = ', num2str(dim2)], 'FontSize', 13,...
    'VerticalAlignment', 'Top')
%   text(x_trans(25), y_trans(25), ['dim = ', num2str(dim3)], 'FontSize', 13,...
%     'VerticalAlignment', 'Top')
  knotpos = 10.^(dimplot.knots);
end