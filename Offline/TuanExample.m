clear all, close all, clc

load('D:\IU\project(filtering fNIRS)\SASS_toolbox\SASS_toolbox\RAWDATA.mat')
data=(RawData+0.4*randn(size(RawData)))';

% load ('dataECG')
N = size(data,1);
n = 0:N-1;
sigma = sqrt(0.4); 
figure('Name','Thay Tam','NumberTitle','on')
ax(1)=subplot(4,1,1)
plot(data,'r')
title('Raw data');
set(ax(1),'xtick',[])
%%
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

%%%%Low-pass filter:%%%%%
x_lpf = L(y);

err = RawData' - x_lpf;
RMSE_LPF = sqrt(mean(err(K+1:end-K).^2));

ax(2)=subplot(4,1,2)
plot(x_lpf)
title('Lowpass');
ylabel(num2str(RMSE_LPF));
set(ax(2),'xtick',[])
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

% figure('Name','SASS (L1 norm)','NumberTitle','on')

err = RawData' - x_L1;
RMSE_L1 = sqrt(mean(err(K+1:end-K).^2));
ax(3)=subplot(4,1,3);
plot(x_L1)
title('SASS (L1 norm)');
ylabel(num2str(RMSE_L1));
set(ax(3),'xtick',[])
%-----------------------------------------------------------------------


%%%%%%%%%%%%%%%%%%% SASS (atan penalty)%%%%%%%%%%%%%%%%%%%
% The arctangent (atan) penalty function is non-convex

% rho : Controls non-convexity of penalty (0 <= rho <= 1)
rho = 0.5;
% 
% % initialize with L1 solution
% [x_atan1, cost_atan1, u_atan1, v_atan1, a] = sass(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);
% 
% % figure('Name','SASS (atan penalty)','NumberTitle','on')
% subplot(4,1,3);
% 
% err = RawData' - x_atan1;
% RMSE_atan1 = sqrt(mean(err(K+1:end-K).^2))
% 
% plot(x_atan1);
% title('SASS (atan penalty)');
% ylabel(num2str(RMSE_atan1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-------------Correct for zero-locking-------------
[x_atan, cost_atan, u_atan, v_atan, a] = sass2(y, d, fc, K, lam, 'atan', rho, Nit, u_L1);

oxy_filt2=x_atan;

err = RawData' - x_atan;
RMSE_atan = sqrt(mean(err(K+1:end-K).^2))

% figure('Name','Correct for zero-locking','NumberTitle','on')
ax(4)=subplot(4,1,4);
plot(x_atan)
ylabel(num2str(RMSE_atan));
set(ax(4),'xtick',[])
%---------------------------------------------------

title('SASS (Correct for zero-locking)');
% clc

%%
% % % %%Kalman
% % % data=repmat(data,1,7);
% % % figure('Name','Kalman','NumberTitle','on')
% % % 
% % % % plot(data,'r');
% % % % title('Raw data');
% % % % set(ax(1),'xtick',[]);
% % % 
% % % 
% % % % load('D:\IU\project(filtering fNIRS)\GUI\data testNIRS\rest\Tuan4.mat');
% % % % data=sav_data; Task=data(:,1);
% % % % % oxy=data(:,2:8);
% % % % oxy=data(:,2);
% % % % A=oxy;
% % % 
% % % DIM = size(data,2)
% % % LEN = size(data,1)
% % % 
% % % % this is the output:
% % % S = [];
% % % SS = [];
% % % 
% % % % assume measurement matrix H is identical:
% % % H = eye(DIM);
% % % 
% % % % and the state transition matrix T as well:
% % % T = eye(DIM);
% % % 
% % % % init
% % % p = H*data(1,:)';
% % % P = eye(DIM)*1; % just an initial guess
% % % 
% % % Q = eye(DIM)*1;
% % % R = eye(DIM)*150; 
% % % 
% % % % loop for the entire dataset:
% % % 
% % % for i=2:LEN,
% % % 
% % %           % estimate step:
% % % 
% % %           p_est = T*p;
% % %           P_est = T*P*T'+Q; 
% % % 
% % %           % correction step:
% % % 
% % %           K = P_est*H'*inv(H*P_est*H'+R);
% % %           p = p_est + K*( data(i,:)' - H*p_est );
% % %           P = (eye(DIM) - K*H)*P_est;
% % % 
% % %           S = [S p];
% % % 
% % %           SS = [SS; P(1,1) P(1,2) P(2,1) P(2,2)];
% % % %           SS = [SS; P(1,1)];
% % % end
% % % 
% % % S = S';
% % % DATA=RawData';
% % % err = DATA(1:end-1,1) - S(:,1) ;
% % % RMSE_Kalman = sqrt(mean(err(K+1:end-K).^2))
% % % 
% % % % plot(A(2:length(A),2),'r');
% % % ax(1)=subplot(4,1,1);
% % % plot(data,'r');
% % % title('Raw data');
% % % set(ax(1),'xtick',[]);
% % % 
% % % ax(2)=subplot(4,1,2);
% % % plot(S(:,1));
% % % title('Kalman');
% % % set(ax(1),'xtick',[]);