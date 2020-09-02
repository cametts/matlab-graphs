function V = draw_swissroll(h, c, z)
  %z is the roll height
  %c is the pi value for the starting vertex
  N = 20000;
  theta = 6*pi*(rand(N,1).^0.5);
  d = 3; %noise 
  depth = 150; %radius of the biggest ball investigated
  XX = theta .* cos(theta) + d*(rand(N, 1)-0.5); %set x coordinates for all points
  YY = theta .* sin(theta) + d*(rand(N, 1)-0.5); %y coords for all points
  ZZ = h*rand(N, 1) + d*(rand(N, 1)-0.5); %z coords for all points
  %edit the below numbers to change the starting node
  XX(1) = c*pi*cos(c*pi);
  YY(1) = c*pi*sin(c*pi); %first element of YY is 0
  ZZ(1) = z; %first element of ZZ is 1/2 the height
  V = [XX, YY, ZZ];
end