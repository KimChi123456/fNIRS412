clear all, close all, clc

load('C:\Users\NHUT TUAN\Desktop\SASS_toolbox\SASS_toolbox\signal.mat')

RawData=signal;
noise = 0.05 * randn(15821, 1);
data=signal+noise;

% load ('dataECG')
N = size(data,1);
n = 0:N-1;
sigma = 0.1; 
figure('Name','SIGNAL','NumberTitle','on')
subplot(2,1,1)
plot(data,'r')
title('Noisy data')

subplot(2,1,2)
plot(RawData)
title('Raw data')

%%% Perform preprocessing%%%%%%%%%%%%%%%%%%%%%%%%%
r = 2;
M = 15;
y = preproc(r, M, data);
% figure
% plot(y,'b')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%------------- Filter matrices -------------
% Define filter matrices for SASS.

d = 2;                          % filter is of order 2d
fc = 0.03;                      % fc : cut-off frequency (0 < fc < 0.5) (cycles/sample)
K = 3;                          % K : order of sparse derivative

% Banded filter matrices:
[A, B, B1, D, a, b, b1, H1norm HTH1norm] = ABfilt(d, fc, N, K);

H = @(x) [nan(d,1); A\(B*x); nan(d,1)];     % H: high-pass filter
L = @(x) x - H(x);                          % L: low-pass filter
%-------------------------------------------

figure('Name','Filter','NumberTitle','on')
h=subplot(5,1,1)
plot(RawData,'r')
set(h,'xtick',[])
ylabel('Raw data')


%%%%Low-pass filter:%%%%%
x_lpf = L(y);

err = RawData - x_lpf;
RMSE_LPF = sqrt(mean(err(K+1:end-K).^2))

h=subplot(5,1,2)
plot(x_lpf)
set(h,'xtick',[])
ylabel('Lowpass')
xlabel(['RMSE: ' num2str(RMSE_LPF)])

%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------SASS (L1 norm)----------------------------
beta = 3;
lam = beta * sigma * HTH1norm;  % lam : regularization parameter

Nit = 100;                      % Nit : number of iterations

[x_L1, cost_L1, u_L1, v_L1] = sass(y, d, fc, K, lam, 'L1', [], Nit);
% x : denoised signal
% u : sparse order-K derivative
% v : inv(A)*B1*u
% cost : cost function history

err = RawData - x_L1;
RMSE_XL1 = sqrt(mean(err(K+1:end-K).^2))


h=subplot(5,1,3)
plot(x_L1)
set(h,'xtick',[])
ylabel('SASS (L1 norm)')
xlabel(['RMSE: ' num2str(RMSE_XL1)])

%-----------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%% SASS (atan penalty)%%%%%%%%%%%%%%%%%%%
% The arctangent (atan) penalty function is non-convex

% rho : Controls non-convexity of penalty (0 <= rho <= 1)
rho = 0.5;

% initialize with L1 solution
[x_atan1, cost_atan1, u_atan1, v_atan1, a] = sass(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);

err = RawData - x_atan1;
RMSE_SASS = sqrt(mean(err(K+1:end-K).^2))

h=subplot(5,1,4)
plot(x_atan1)
set(h,'xtick',[])
ylabel('SASS (atan penalty)')
xlabel(['RMSE: ' num2str(RMSE_SASS)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------Correct for zero-locking-------------
[x_atan, cost_atan, u_atan, v_atan, a] = sass2(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);

err = RawData - x_atan;
RMSE_Correct_for_zero_locking = sqrt(mean(err(K+1:end-K).^2))

h=subplot(5,1,5)
plot(x_atan)
set(h,'xtick',[])
ylabel('Correct zero-locking')
xlabel(['RMSE: ' num2str(RMSE_Correct_for_zero_locking)])





