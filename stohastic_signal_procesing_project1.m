clear; close all; clc;

mu = [1; 2];      % mean vector
C = [2 1; 1 2];   % covariance vector

invC = inv(C);    % Inverse of covariance matrix
detC = det(C);    % Determinant of covariance matrix

%  Create grid for x and y values
x = -3:0.1:6;
y = -3:0.1:6;
Nx = length(x);
Ny = length(y);
pdf = zeros(Nx,Ny);    % Matrix to store PDF values

%  Compute the bivariate Gaussian PDF
%%  f(x,y) = (1/(2π√|C|)) exp(-1/2 (z-μ)^T C⁻¹ (z-μ))

for i = 1:Nx
    for j = 1:Ny
        
        z = [x(i); y(j)];        % Current point
        diff = z - mu;           % Center around the mean
        
        Q = diff' * invC * diff;   % Quadratic form
        
        % Evaluate PDF using the formula above
        pdf(i,j) = (1/(2*pi*sqrt(detC))) * exp(-0.5*Q);
        
    end
end


%% Contours of the joint PDF

figure;

[Cs,H] = contour(x,y,pdf');    % Plot contour lines
clabel(Cs,H);                  % Show contour values
axis square
grid on
xlabel('X')
ylabel('Y')
title('Contours of the Bivariate Gaussian PDF')
hold on
% Mark the mean 
plot(mu(1),mu(2),'ko','MarkerFaceColor','k')
legend('Contours','Mean');

%% Plot eigenvector directions as lines through the mean

% Line y = x (shifted to pass through mean (1,2))
y1 = (x - 1) + 2;
plot(x, y1, 'k--', 'LineWidth', 1.5);

% Line y = -x (shifted to pass through mean (1,2))
y2 = -(x - 1) + 2;
plot(x, y2, 'k:', 'LineWidth', 1.5);

% Mark the mean 
plot(mu(1),mu(2),'ko','MarkerFaceColor','k')
title('Direction of the contours')
legend('Contours','Mean','y = x direction','y = -x direction');
hold off

%% MMSE line 2+0.5(x-1)
yhat = 2 + 0.5*(x - 1);

%% Contours and MMSE predictor

figure;

[Cs,H] = contour(x,y,pdf');
clabel(Cs,H);

axis square
grid on
xlabel('X')
ylabel('Y')
title('MMSE Prediction E[Y|X=x] on Gaussian Contours')
hold on

% Plot MMSE prediction line
plot(x,yhat,'r','LineWidth',2)

% Mark the mean
plot(mu(1),mu(2),'ko','MarkerFaceColor','k')
legend('PDF contours','MMSE predictor','Mean')
hold off

