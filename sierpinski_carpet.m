function [V, E, x, y] = sierpinski_carpet( N )

% edgelength of carpet
el = 3.^N;

% hole-indices for N = 1
xi = 2;
xj = 2;

% bootstrap hole-indices for higher N
for n = 1:(N-1)
    [ ci, cj ] = ndgrid( 3.^n+(1:3.^n) );
    xi = [ xi, 3.^n+xi, 2*3.^n+xi, xi, 2*3.^n+xi, xi, 3.^n+xi, 2*3.^n+xi, ci(:)' ];
    xj = [ xj, xj, xj, 3.^n+xj, 3.^n+xj, 2*3.^n+xj, 2*3.^n+xj, 2*3.^n+xj, cj(:)' ];    
end

% get linear index of hole indices
xk = sub2ind( [el, el], xi, xj );

%carpet = ones( 3.^N );
%carpet( xk ) = 0;

% save x,y coords of vertices
[ x, y ] = ndgrid( 1:el );
y = el - y;

% construct full adjacency matrix of square
Ap=spdiags(ones(el,1),1,el,el); 
A=kron(Ap,speye(el))+kron(speye(el),Ap);

% remove edges belonging to holes
A(xk,:) = [];
A(:,xk) = [];

% sanity check: do we get the right amount of edges?
ne = 8;
for n=1:(N-1)
    ne = 8*(ne + 3.^n);
end
if ne ~= nnz(A)
    error( 'edge number does not match' );
end

% remove vertex coordinates
y( xk ) = [];
x( xk ) = [];

nv = length(y);
if nv ~= 8.^N
    error( 'vertex number does not match' );
end

[ ei, ej ] = find( A );
E = [ei, ej];
V = 1:nv;

figure;
axis off;
plot(x, y, 'ro'); hold on;
plot(x(edges'), y(edges'), 'b-');
axis equal; axis off; box off; 
return