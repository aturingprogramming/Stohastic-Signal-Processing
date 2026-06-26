% An AR random process of order 2 is given by the recursive difference  equation X[n] = 2r cos(2π f_0)X[n -1] -r^2X[n - 2]+U[n], where U[n] is white 
% Gaussian noise with variance σ_u^2 = 1. For r = 0.7,f_0 = 0.1 and also for 
% r = 0.95, f_0 = 0.1 plot the PSD of X[n]. Can you explain your results? Hint: Determine the pole locations of H(z). 



clear; close all; clc;

f = linspace(-0.5, 0.5, 1000); % frequency axis (normalized)
f0 = 0.1; % given frequency

%% CASE 1 (r = 0.7, f0 = 0.1)
r1 = 0.7;

% Frequency response of AR(2) system 
H_f = 1 ./ (1 - 2*r1*cos(2*pi*f0)*exp(-1i*2*pi*f) + r1^2*exp(-4*1i*pi*f));

PSD = abs(H_f).^2; % PSD 

figure;
plot(f, PSD, 'LineWidth', 2, 'Color', 'blue');
xlabel('f'); ylabel('P_X(f)');
title('Power Spectral Density of X[n] for r = 0.7 and f₀ = 0.1');
grid on;

% Poles 
p1 = r1 * exp(1i*2*pi*f0);
p2 = r1 * exp(-1i*2*pi*f0);


%% CASE 2 (r = 0.95, f0 = 0.1)
r2 = 0.95;

% Frequency response of AR(2) system 
H_f = 1 ./ (1 - 2*r2*cos(2*pi*f0)*exp(-1i*2*pi*f) + r2^2*exp(-1i*4*pi*f));

PSD = abs(H_f).^2; %PSD

figure;
plot(f, PSD, 'LineWidth', 2, 'Color', 'blue');
xlabel('f'); ylabel('P_X(f)');
title('Power Spectral Density of X[n] for r = 0.95 and f₀ = 0.1');
grid on;

% Poles
p3 = r2 * exp(1i*2*pi*f0);
p4 = r2 * exp(-1i*2*pi*f0);


%% Pole Plot
figure;
hold on;

% Unit circle
theta = linspace(0, 2*pi, 2000);
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 2);

% Plot poles for both cases
plot(real(p1), imag(p1), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p2), imag(p2), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p3), imag(p3), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
plot(real(p4), imag(p4), 'rx', 'MarkerSize', 10, 'LineWidth', 2);

grid on;
axis equal;
xlim([-1.2 1.2]); ylim([-1.2 1.2]);

xlabel('Real Part'); ylabel('Imaginary Part');
title('Pole Locations of the AR(2) System for r = 0.7 and r = 0.95 (f₀ = 0.1)');

legend('Unit Circle', ...
       'Poles (r = 0.7)', '', ...
       'Poles (r = 0.95)', '', ...
       'Location', 'northeast');