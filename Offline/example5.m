%% Example 2: NIRS signal denoising with the SASS algorithm
% This example shows the use of the sparsity-assisted signal smoothing (SASS)
% algorithm for NIRS filtering. In this example, the QRS waveform is modeled
% as piecewise quadratic, so we use K = 3 in SASS.
%
%  Ivan Selesnick
% selesi@poly.edu
% 2013

%% Start

clc, close all,
clear

printme = @(filename) print('-dpdf', sprintf('figures/Example2_%s', filename));


%% Make NIRS signal
% Use 'NIRSsyn.m' by
% P. E. McSharry, G. D. Clifford, L. Tarassenko, and L. A. Smith.
% A dynamical model for generating synthetic electrocardiogram signals.
% Trans. on Biomed. Eng., 50(3):289-294, March 2003.
% http://www.physionet.org/physiotools/NIRSsyn/

% addpath NIRS
% randn('state', 0);
% rand('state', 1);               % Set rand/randn states for reproducibility
% 
% Fs = 256;                       % Fs : sampling frequency (samples/sec)
% 
% NIRS_10 = NIRSsyn(Fs, 10);        % Simulate 10 heart beats

%%
% 

% M = 2;                          % M : number of beats
% NIRS = NIRS_10(Fs/2+(1:M*Fs));    % Extract M beats from simulated NIRS 

load('D:\IU\project(filtering fNIRS)\SASS_toolbox\SASS_toolbox\RawData.mat');
load('D:\IU\project(filtering fNIRS)\SASS_toolbox\SASS_toolbox\noisyData.mat');
%-----------------------------------------------------------------------------------------------------------------------
% load('D:\IU\project(filtering fNIRS)\SASS_toolbox\Free noise\Tuan_rest.mat');
load('D:\IU\project(filtering fNIRS)\SASS_toolbox\Free noise\Giang_rest.mat');
%-----------------------------------------------------------------------------------------------------------------------


N = length(sav_data);

NIRS=RawData(1:N,1);

n = 0:N-1;

ax1 = [0 N -1.0 2.0];

sigma = 0.1;                    % sigma : noise standard deviation

scale=2;
noise = scale*sav_data(:,8);
Nlow=14; Nband=1;

% data = noisyData(:,1);             % data : noisy NIRS
data = noise+NIRS;

%%
% Display NIRS signals

% ax1 = [0 N -1.0 2.0];
% 
% figure(1)
% clf
% subplot(2,1,1)
% plot(n, NIRS)
% title('NIRS (noise-free)')
% axis(ax1)
% 
% subplot(2,1,2)
% plot(n, data)
% title('NIRS + noise');
% axis(ax1)


%% Perform preprocessing
% The SASS algorithm may introduce transients at the beginning and end of
% the signal. To reduce the transients, replace first and last samples
% of the data by a low-order polynomial approximation.

r = 2;
M = 15;
y = preproc(r, M, data);

% figure(1)
% clf
% subplot(2, 1, 1)
% plot(n, y)
% axis(ax1)
% title('Preprocessed data')


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

err = NIRS - x_lpf;
RMSE_LPF = sqrt(mean(err(K+1:end-K).^2))



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

err = NIRS - x_L1;
RMSE_L1 = sqrt(mean(err(K+1:end-K).^2))


%%



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

txt_atan = sprintf('SASS (atan, K = %d, \\lambda = %.2f, \\rho = %.2f, %s)', K, lam, rho, txt_filt);

err = NIRS - x_atan;
RMSE_atan = sqrt(mean(err(K+1:end-K).^2))



%% Save figure to pdf file

ax1 = [0 N -0.5 1.5];

set(0, 'DefaultAxesFontSize', 8);

figure('Name','Thay Tam')
clf

subplot(5, 1, 1)
plot(n, NIRS)
title('NIRS (noise-free)');
% axis(ax1)

subplot(5, 1, 2)
plot(n, data)
title('NIRS + noise');
% axis(ax1)

subplot(5, 1, 3)
plot(n, x_lpf);
title(txt_LPF);
% axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_LPF))

subplot(5, 1, 4)
plot(n, x_L1);
title(txt_L1);
% axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_L1))

subplot(5, 1, 5)
plot(n, x_atan);
title(txt_atan);
% axis(ax1)
axnote(sprintf('RMSE = %.4f', RMSE_atan))

orient tall
print -dpdf figures/Example2_fig1


set(0, 'DefaultAxesFontSize', 'remove');


clc
max(NIRS(:,1))

%%
%-----------------------------------------------------------------------------


%-----------------------------------------------------------------------------


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load('D:\IU\project(filtering fNIRS)\GUI\data testNIRS\rest\Tuan4.mat');
% data=sav_data; Task=data(:,1);
% % oxy=data(:,2:8);
% oxy=data(:,2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





