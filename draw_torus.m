function V = draw_torus(r, w, x, y, z)
  if x==0 && y==0 & z==0
      x = r;
      z = 0.5*w;
  end
  %r is radius 
  %w is width
  N = 20000;
  noise = 5; %noise
  depth = 50; %radius of the largest ball
  theta = 2*pi*rand(N,1); %rand(N, 1) returns a 20000x1 matrix of random numbers between 0 and 1
  XX = r*cos(theta) + noise*(rand(N,1)-0.5); %set x coordinates for all points
  YY = r*sin(theta) + noise*(rand(N,1)-0.5); %y coords for all points
  ZZ = w*rand(N,1) + noise*(rand(N,1)-0.5); %z coords for all points
  %change the below to change the starting vertex 
  XX(1) = x;  
  YY(1) = y; 
  ZZ(1) = z; 
  V = [XX, YY, ZZ];
end
