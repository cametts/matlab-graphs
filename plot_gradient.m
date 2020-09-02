function plot_gradient(V, shells, dimension)
  figure();
  %plot the initial point
  XX = V(:, 1);
  YY = V(:, 2);
  ZZ = V(:, 3);
  shellsize = size(shells);
  N = shellsize(1);
  maxr = shellsize(2);
  ttt = randi(20,N,1); %Nx1 array of random integers between 1 and 20
  plot3(XX(1), YY(1), ZZ(1), 'k.', 'MarkerSize', 25); hold on;
  %plot the rainbow shape
  for r=1:maxr
    shell = shells(:, r);
    dim = dimension(r);
    if dim < 0
      %red
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[1,0,0]');hold on; 
    elseif dim < 0.5 %0 to 0.5
      %yellow
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[1,1,0]');hold on;   
    elseif dim < 1 %0.5 to 1
      %lime
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[0.2,1,0]');hold on;  
    elseif dim < 1.5 %1 to 1.5
      %teal
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[0.2,0.6,0.8]');hold on;
    elseif dim < 2 %1.5 to 2
      %blue
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[0,0,0.8]');hold on;    
    elseif dim < 2.5 %2 to 2.5
      %purple
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[0.6,0,1]');hold on;    
    elseif dim < 3 %2.5 to 3
      %pink
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[1,0,0.8]');hold on;
    elseif dim < 3.5 %3 to 3.5
      %brown
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[0.4,0,0]');hold on;
    else 
      %salmon
      plot3(XX(shell==1 & ttt<2),YY(shell==1 & ttt<2),ZZ(shell==1 & ttt<2), '.', 'Color', '[1,0.6,0.6]');hold on;  
    end
  
  end
end