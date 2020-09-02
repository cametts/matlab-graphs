classdef SierpinskiCube < handle
    properties
        vertices
        edges
        adjacency    
    end
    methods
        function shape=SierpinskiCube(N)
            cubeedge = 3^N;
            edgelength = 3^N;
            cube = CartesianCube(edgelength, edgelength, edgelength);
            
            for i=1:N
                %num_centers = 3^((i-1)*3);
                num_centers = 3^(3*(i-1));
                if i==1
                    center = ((edgelength^3)+1)/2; %center of the cube
              
                else
                    clear plane_centers
                    parfor k=1:3^(3*(i-2))
                        remlength = edgelength/3;
                        plane_centers{k} = center(k)-remlength:remlength:center(k)+remlength;
                    end
                    plane_centers = cat(1, plane_centers{:});
                    reshape(plane_centers, 1, []);
                    %all centers of cubes to be removed from the same plane
                    %as the original center
                    centerplanerange = -offset/(3^(i-1)):offset/(3^(i-1)):offset/(3^(i-1));
                    [centerx, centery] = meshgrid(plane_centers, centerplanerange); 
                    plane_centers = round(centerx + centery);
                    center_range = -offset*remlength:offset*remlength:offset*remlength;
                    [centersx, centersy] = meshgrid(center_range, plane_centers);
                    center = centersx+centersy;
                    edgelength = edgelength / 3;
                end
                for j=1:num_centers
                    remlength = edgelength / 3; %length of central cube to cut out
                    offset = 3^(2*N); %difference in indices of neighboring 
                    %vertices in different levels 
                    centerdiff = (remlength - 1)/2; %difference between center vertex
                    %and those on same row to be removed 
                    centerstrip = (center(j)-centerdiff:center(j)+centerdiff); %row of vertices
                    %surrounding the middle
                    planerange = -centerdiff*cubeedge:cubeedge:centerdiff*cubeedge;
                    [planex, planey] = meshgrid(centerstrip, planerange);
                    centerplane = planex + planey; %vertices in middle plane to be removed
                    cuberange = -centerdiff*offset:offset:centerdiff*offset;
                    [cubex, cubey] = meshgrid(centerplane, cuberange);
                    centercube = cubex + cubey;
                    centercube = reshape(centercube, 1, []);
                    cube.delete_vertices(centercube);                                     
                end
                shape.vertices = cube.vertices;
                shape.adjacency = cube.adjacency;            
            end    
        end
    end
end
  