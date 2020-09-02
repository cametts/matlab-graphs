function V = draw_mobius(r, x, y, z)
  if x==0 && y==0 && z==0
      x = -10;
  end
  N = 20000;
  u = 2*pi*rand(N, 1);
  v = -r + (r+r)*rand(N,1);
  d = 5; %noise 
  depth = 85; %radius of the biggest ball investigated
  XX = (10 + v./2 .* cos(u/2)).*cos(u) + d*(rand(N, 1) - 0.5); %set x coordinates for all points
  YY = (10 + v./2 .* cos(u/2)).*sin(u) + d*(rand(N, 1) - 0.5); %y coords for all points
  ZZ = v./2 .*sin(u/2); %z coords for all points 
  %edit the below numbers to change the starting node
  XX(1) = x;
  YY(1) = y; 
  ZZ(1) = z; 
  V = [XX, YY, ZZ];
end