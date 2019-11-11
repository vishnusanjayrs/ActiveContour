clear all;

% Parameters (play around with different images and different parameters)
N = 200;
alpha = 0.4;
beta = 0.5;
gamma = 0.5;
kappa = 0.15;
Wline = 0.6;
Wedge = 0.2;
Wterm = 0.5;
sigma = 0.5;




% Load image
I = imread('images/brain.png');
% I = imread('images/circle.jpg');
size(I)
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y] = initializeSnake(I);

% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
I_gauss = imgaussfilt(I, sigma);
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrixBonus(size(x,2), alpha, beta, gamma);

x = x';
y = y';

% Iterate and update positions
displaySteps = floor(N/10);
figure;
imshow(I);
hold on;
h1 = plot(x, y,'r' );
for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);

    % Plot intermediate result
%     imshow(I); 
%     hold on;

    h1.XData = [x ;x(1)];
    h1.YData = [y ;y(1)];
    
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.05)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end