%% Example 2: ECG signal denoising with the SASS algorithm
% This example shows the use of the sparsity-assisted signal smoothing (SASS)
% algorithm for ECG filtering. In this example, the QRS waveform is modeled
% as piecewise quadratic, so we use K = 3 in SASS.
%
%  Ivan Selesnick
% selesi@poly.edu
% 2013

%% Start

clc
clear
load('')
printme = @(filename) print('-dpdf', sprintf('figures/Example2_%s', filename));


%% Make ECG signal
% Use 'ecgsyn.m' by
% P. E. McSharry, G. D. Clifford, L. Tarassenko, and L. A. Smith.
% A dynamical model for generating synthetic electrocardiogram signals.
% Trans. on Biomed. Eng., 50(3):289-294, March 2003.
% http://www.physionet.org/physiotools/ecgsyn/

addpath ecg
randn('state', 0);
rand('state', 1);               % Set rand/randn states for reproducibility

Fs = 256;                       % Fs : sampling frequency (samples/sec)

ecg_10 = ecgsyn(Fs, 10);        % Simulate 10 heart beats

%%
% 

M = 2;                          % M : number of beats
ecg = ecg_10(Fs/2+(1:M*Fs));    % Extract M beats from simulated ECG 

N = length(ecg);
n = 0:N-1;

sigma = 0.1;                    % sigma : noise standard deviation

noise = sigma * randn(N, 1);    % noise : white Gaussian noise

data = ecg + noise;             % data : noisy ECG

%%
% Display ECG signals

ax1 = [0 N -1.0 2.0];

figure(1)
clf
subplot(2,1,1)
plot(n, ecg)
title('ECG (noise-free)')
axis(ax1)

subplot(2,1,2)
plot(n, data)
title('ECG + noise');
axis(ax1)


%% Perform preprocessing
% The SASS algorithm may introduce transients at the beginning and end of
% the signal. To reduce the transients, replace first and last samples
% of the data by a low-order polynomial approximation.

r = 2;
M = 15;
y = preproc(r, M, data);

figure(1)
clf
subplot(2, 1, 1)
plot(n, y)
axis(ax1)
title('Preprocessed data')


%% Filter matrices
% Define filter matrices for SASS.

d = 2;                          % filter is of order 2d
fc = 0.03;                      % fc : cut-off frequency (0 < fc < 0.5) (cycles/sample)
K = 3;                          % K : order of sparse derivative

% Banded filter matrices:
[A, B, B1, D, a, b, b1, H1norm HTH1norm] = ABfilt(d, fc, N, K);

H = @(x) [nan(d,1); A\(B*x); nan(d,1)];     % H: high-pass filter
L = @(x) x - H(x);                          % L: low-pass filter

txt_filt = sprintf('d = %d, fc = %.3f', d, fc);


%% Low-pass filter

x_lpf = L(y);

txt_LPF = sprintf('Low-pass filtering (%s)', txt_filt);

err = ecg - x_lpf;
RMSE_LPF = sqrt(mean(err(K+1:end-K).^2))

figure(1)
clf
subplot(2, 1, 1)
plot(n, x_lpf)
title(txt_LPF)
axis(ax1)


%% SASS (L1 norm)

beta = 3;
lam = beta * sigma * HTH1norm;  % lam : regularization parameter

Nit = 100;                      % Nit : number of iterations

[x_L1, cost_L1, u_L1, v_L1] = sass(y, d, fc, K, lam, 'L1', [], Nit);
% x : denoised signal
% u : sparse order-K derivative
% v : inv(A)*B1*u
% cost : cost function history

txt_L1 = sprintf('SASS (L1, K = %d, \\lambda = %.2f, %s)', K, lam, txt_filt)

err = ecg - x_L1;
RMSE_L1 = sqrt(mean(err(K+1:end-K).^2))


%%
% Cost function
figure(1)
clf
plot(cost_L1)
title('Cost function history');
xlabel('Iteration')

%%
% Denoised signal
figure(1)
clf
subplot(2, 1, 1)
plot(n, x_L1)
title(txt_L1)
axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_L1))

%%
% Optimality scatter plot
figure(1)
clf
plot_scatter(A, B, B1, y, u_L1, lam, 'L1', []);
title(sprintf('L1 optimality scatter plot (%d iterations)', Nit))
printme('L1_scatter')

%%
% Components
figure(1)
clf
plot_components(n, data, x_lpf, x_L1, u_L1, v_L1, txt_L1);
printme('L1_components')



%% SASS (atan penalty)
% The arctangent (atan) penalty function is non-convex

% rho : Controls non-convexity of penalty (0 <= rho <= 1)
rho = 0.5;

% initialize with L1 solution
[x_atan1, cost_atan1, u_atan1, v_atan1, a] = sass(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);


%% Correct for zero-locking

[x_atan, cost_atan, u_atan, v_atan, a] = sass2(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);

cost_delta = cost_atan1(end) - cost_atan(end);

fprintf('Zero-locking correction improved cost function value by %g\n', cost_delta);

%%
% Display scatter plot before and after zero-locking correction

figure(2)
clf
subplot(2, 1, 1)
plot_scatter(A, B, B1, y, u_atan1, lam, 'atan', a);
ax_scatter = [-0.005 0.005 0.5 1.3];
axis(ax_scatter)
title('Without zero-locking correction (not optimal)')

subplot(2, 1, 2)
plot_scatter(A, B, B1, y, u_atan, lam, 'atan', a);
axis(ax_scatter)
title('With zero-locking correction (locally optimal)')

orient tall
printme('atan_scatter_detail')

%%

txt_atan = sprintf('SASS (atan, K = %d, \\lambda = %.2f, \\rho = %.2f, %s)', K, lam, rho, txt_filt);

err = ecg - x_atan;
RMSE_atan = sqrt(mean(err(K+1:end-K).^2))


%%
% Cost function
figure(1)
clf
plot(cost_atan)
title('Cost function history');
xlabel('Iteration')

%%
% Denoised signal
figure(1)
clf
subplot(2, 1, 1)
plot(n, x_atan)
title(txt_atan)
axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_atan))

%%
% Optimality scatter plot
figure(1)
clf
plot_scatter(A, B, B1, y, u_atan, lam, 'atan', a);
title(sprintf('atan optimality scatter plot (%d iterations)', Nit))
printme('atan_scatter')

%%
% Components
figure(1)
clf
plot_components(n, data, x_lpf, x_atan, u_atan, v_atan, txt_atan);
printme('atan_components')


%% Save figure to pdf file

ax1 = [0 N -0.5 1.5];

set(0, 'DefaultAxesFontSize', 8);

figure(2)
clf

subplot(5, 1, 1)
plot(n, ecg)
title('ECG (noise-free)');
axis(ax1)

subplot(5, 1, 2)
plot(n, data)
title('ECG + noise');
axis(ax1)

subplot(5, 1, 3)
plot(n, x_lpf);
title(txt_LPF);
axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_LPF))

subplot(5, 1, 4)
plot(n, x_L1);
title(txt_L1);
axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_L1))

subplot(5, 1, 5)
plot(n, x_atan);
title(txt_atan);
axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_atan))

orient tall
print -dpdf figures/Example2_fig1


set(0, 'DefaultAxesFontSize', 'remove');



