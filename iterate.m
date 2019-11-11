function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa)

% Get fx and fy
filter_x = [-1 1];
filter_y = [-1 ;1];

fx = conv2(Eext,filter_x,'same');
fy = conv2(Eext,filter_y,'same');

% x_grid = 1 : 0.0001 :size(fx,1);
% y_grid = 1 : 0.0001 :size(fx,2);
% [xq ,yq] = meshgrid(x_grid,y_grid);
% fx_float = interp2(fx,xq,yq);
% 
% x_grid = 1 : 0.0001 :size(fy,1);
% y_grid = 1 : 0.0001 :size(fy,2);
% [xq ,yq] = meshgrid(x_grid,y_grid);
% fy_float = interp2(fy,xq,yq);

% Iterate
newX = Ainv * (gamma * x - kappa *  interp2(fx,x,y) );
newY = Ainv * (gamma * y - kappa *  interp2(fy,x,y) );

% Clamp to image size
newX(newX>size(fx,2))=size(fx,2);
newY(newY>size(fx,1))=size(fx,1);
 
newX(newX<1)=1;
newY(newY<1)=1;

end

