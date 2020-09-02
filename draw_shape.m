function draw_shape(V)
  XX = V(:, 1);
  YY = V(:, 2);
  ZZ = V(:, 3);
  plot3(XX,YY,ZZ, 'b.');hold on; %plots the wheel by point (no connections yet)
  plot3(XX(1),YY(1),ZZ(1), 'r.'); %plots the first point in red 
end