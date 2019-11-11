function [x, y] = initializeSnake(I)

% Show figure

figure;
imshow(I);

size(I)



% Get initial points
[x1, y1]=getpts();
points_matrix = [x1 y1];

%add the first point as last point to close the curve
points_matrix(size(points_matrix,1)+1,:)=points_matrix(1,:);

hold on;
plot(points_matrix(:,1),points_matrix(:,2),'x');

% Interpolate
points = points_matrix';
curve = cscvn(points) ;
figure;
imshow(I);
hold on;
fnplt(curve);


xmin = curve.breaks(1,2);
xmax = max(curve.breaks);

ymin = curve.breaks(1,2);
ymax = max(curve.breaks)

x_grid = 1:1:xmax;
y_grid = 1:1:ymax;

[mesh_x ,mesh_y] = meshgrid(x_grid,y_grid);
v = fnval(curve,[mesh_x;mesh_y]);
x = v(1,:,1);
y = v(2,:,1);
xy = [x' y'];
xy = unique(xy,'rows','stable');
x = xy(:,1)';
y = xy(:,2)';

figure;
imshow(I)
size(I,1)
size(I,2)
% Clamp points to be inside of image
x(x>size(I,2))=size(I,2);
y(y>size(I,1))=size(I,1);

x(x<1)=1;
y(y<1)=1;

clf;
imshow(I)
hold on;
x(1,size(x,2)+1)=x(1,1);
y(1,size(y,2)+1)=y(1,1);

plot(x,y,'-o')





end

