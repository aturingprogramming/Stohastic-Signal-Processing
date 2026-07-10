% Suppose we are trying to detect a signal of arbitrary amplitude A that alters with the addition 
% of Gaussian noise \textbf{n} of zero mean value and variance $\sigma^2$. In the receiver, the
% received signal plus noise is compared to a threshold T . The cost of making a correct
% decision (i.e., to detect a signal at the receiver when a signal was actually transmitted or
% to not detected a signal when no signal was actually transmitted) is zero, while the cost of
% a wrong decision is one. Derive the curve of average probability of error as a function of
% signal transmission probability p. Calculate the threshold curve T as a function of signal
% transmission probability p.

clear;
clc;
close all;

%% Parameters

A = 1;              % Signal amplitude
sigma = 1;          % Noise standard deviation

%% Q-function

Q = @(x) 0.5 * erfc(x/sqrt(2));

%% Prior probability range

p = linspace(0.000001,0.999999,1000000);


%% Optimal Threshold Curve T*(p)

%T*(p) = A/2 + (sigma^2/A) * ln((1-p)/p)
T_opt = A/2 + (sigma^2/A) .* log((1-p)./p);

figure;

plot(p,T_opt,'LineWidth',2);

xlabel('p');
ylabel('T(p)');

title('Optimal threshold curve');

grid on;


%% Minimum Probability of Error Curve R_min(p)

%R = (1-p)*Q(T/sigma) + p*Q((A-T)/sigma)
R_min = zeros(size(p));

for k = 1:length(p)

    T = T_opt(k);

    % False alarm probability
    P_FA = Q(T/sigma);

    % Miss probability
    P_M = Q((A-T)/sigma);

    % Bayes risk / probability of error
    R_min(k) = (1-p(k))*P_FA + p(k)*P_M;

end

figure;

plot(p,R_min,'LineWidth',2);

xlabel('p');
ylabel('R(p)');

title('Average Probability of Error');

grid on;


%% Gaussian PDFs and Optimal Threshold


% Example prior probability
p_example = 0.5;

% Corresponding optimal threshold
T_example = A/2 + (sigma^2/A)*log((1-p_example)/p_example);

x = linspace(-4*sigma, A+4*sigma, 2000);

% Gaussian PDFs
pdf_H0 = (1/(sqrt(2*pi)*sigma)) * exp(-(x.^2)/(2*sigma^2));

pdf_H1 = (1/(sqrt(2*pi)*sigma)) * exp(-((x-A).^2)/(2*sigma^2));

figure;

plot(x,pdf_H0,'LineWidth',2);
hold on;

plot(x,pdf_H1,'LineWidth',2);

xline(T_example,'k--','LineWidth',2);

xlabel('x');
ylabel('Probability Density');

title('Gaussian PDFs under H_0 and H_1');

legend('f_{Y|H_0}(x)', ...
       'f_{Y|H_1}(x)', ...
       'Optimal Threshold T^*');

grid on;
