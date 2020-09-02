%% Creates a torus of random points, determines connections based on distance
%Requires slm toolbox 
clear all;
close all;
clc;

N = 20000; %number of nodes in the graph
r = 6; %wheel radius
w = 10; %wheel width
d = 5; %noise
depth = 50; %radius of the largest ball
theta = 2*pi*rand(N,1); 

%set coordinates to all points
XX = r*cos(theta) + d*(rand(N,1)-0.5);
YY = r*sin(theta) + d*(rand(N,1)-0.5); 
ZZ = w*rand(N,1) + d*(rand(N,1)-0.5); 

%change the below to change the starting vertex 
XX(1) = r;  
YY(1) = 0; 
ZZ(1) = w*0.5; 

plot3(XX,YY,ZZ, '.');hold on; %plots the wheel by point (no connections yet)
plot3(XX(1),YY(1),ZZ(1), 'r.'); %plots the first point in red 


V = [XX,YY,ZZ]; 

epsilon = 0.6; %connection length 

A = sparse( N, N ); %makes an NxN matrix of all zeros 
h = waitbar( 0, 'building graph' ); %waitbar while graph is made

for i = 1:N 
    dist = sum( (V-repmat(V(i,:), N, 1)).^2, 2 ); 
    %V is the matrix of all of the points
    %Calculates the squared distance from the point in question to all
    %other points
    dist(1:i) = inf; %prevents redundancy 
    j = find( dist <= epsilon^2 );   
    A = A + sparse( i*ones(size(j)), j, ones(size(j)), N, N );   
    waitbar(i/N, h);
end
close(h);

A = A+A';

%%
close all;

d_phi = zeros(depth,1);

phi = zeros(N,1); 
phi(1) = 1; 
ttt = randi(20,N,1); %Nx1 array of random integers between 1 and 20
for d = 1:depth
    n_phi = (speye(N)+A)*phi; 
    n_phi( n_phi > 1 ) = 1; 
    d_phi(d) = d_phi(d) + sum(n_phi) - sum(phi); 
    %changes the value of d_phi at the specified index 
    phi = n_phi;    
    if ismember( d, [3,11,23,45] ) %numbers are the chosen radii 
        figure;  
        plot3(XX(n_phi==0 & ttt==1),YY(n_phi==0 & ttt==1),ZZ(n_phi==0 & ttt==1), '.', 'Color', '[0.8,0.8,0.8]');hold on;
        plot3(XX(n_phi==1 & ttt==1),YY(n_phi==1 & ttt==1),ZZ(n_phi==1 & ttt==1), 'r.');
        axis equal; axis off; view(43,80);
        %matlab2tikz( ['localdimgraph' num2str(d) '.tikz'], 'height', '0.225\textwidth', 'width', '0.225\textwidth');
    end
end
%% viz

x_trans = log10(1:depth);
y_trans = log10(d_phi);
dimplot = slmengine(x_trans, y_trans,  'interiorknots', ...
    'free', 'knots', 4, 'degree', 1, 'plot', 'on');
title('Dimension of a torus');
xlabel('log(radius of enclosing ball)');
ylabel('log(number of vertices in enclosing ball)');
eqs = slm2pp(dimplot);
coefs = eqs.coefs;
dim1 = coefs(1,1) + 1
dim2 = coefs(2,1) + 1
dim3 = coefs(3,1) + 1
text(x_trans(6), y_trans(6), ['dim = ', num2str(dim1)], 'FontSize', 13,...
    'VerticalAlignment', 'Top')
text(x_trans(15), y_trans(15), ['dim = ', num2str(dim2)], 'FontSize', 13,...
    'VerticalAlignment', 'Top')
text(x_trans(50), y_trans(50), ['dim = ', num2str(dim3)], 'FontSize', 13,...
    'VerticalAlignment', 'Top')

%figure; semilogy(d_phi);

%{
h = figure;
subplot(141);
[s1, i1] = logfit( 1:depth, d_phi, 'loglog', 'skipBegin', 0, 'skipEnd', length(d_phi)-5);
s1+1
subplot(142);
[s2, i2] = logfit( 1:depth, d_phi, 'loglog', 'skipBegin', 5, 'skipEnd', length(d_phi)-9);
s2+1
subplot(143);
[s3, i3] = logfit( 1:depth, d_phi, 'loglog', 'skipBegin', 13, 'skipEnd', length(d_phi)-30);
s3+1
subplot(144);
[s4, i4] = logfit( 1:depth, d_phi, 'loglog', 'skipBegin', length(d_phi)-12, 'skipEnd', 5);
s4+1
close(h);

figure; %(10^intercept)*x.^(slope);
loglog( 1:depth, d_phi, 'ko' ); hold on;
dd = 1:6;
loglog( dd, (10.^i1)*dd.^s1, 'g' );

dd = 6:10;
loglog( dd, (10.^i2)*dd.^s2, 'b' );

dd = 13:31;
loglog( dd, (10.^i3)*dd.^s3, 'r' );

dd = (depth-11):(depth-6);
loglog( dd, (10.^i4)*dd.^s4, 'c' );

box off;
xlabel( 'ball radius' );
ylabel( 'ball mass growth' );

matlab2tikz( 'localdimgrowth.tikz', 'height', '0.35\textwidth', 'width', '0.7\textwidth');
%}
%figure; loglog(1:depth, cumsum(d_phi));