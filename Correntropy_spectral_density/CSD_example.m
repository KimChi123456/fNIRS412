%{
Example of the computing the Correntropy-Based Spectral Density (CDS) of a 
signal. 

PROJECT: Research Master in signal theory and bioengineering - Univeristy of Valladolid

DATE: 28/04/2015

VERSION: 1º

AUTHOR: Jesús Monge Álvarez
%}
clc; clear all; close all;

%% Initializations and variables:
fc = 0.3; % Hz
fm = 0.02; % Hz
fs = 2; % Hz
nu = 1;
t = 0:1/fs:(300-1/fs); % Time vector 
N = length(t);
f = linspace(-fs/2,fs/2,N); % Frequency vector

%% Signal:
Carrier = sin(2*pi*fc*t);
Modulater = sin(2*pi*fm*t);
AM = (1+(nu.*Modulater)).*Carrier;

%% Computation of centered correntropy function:
signal = AM;
signal = signal(:).';
N = length(signal);
SD = std(signal); IQR = iqr(signal);
A = min([SD,IQR]);
sigma = 0.9*A*(N^(-1/5));
cte1 = 1/(sqrt(2*pi));
cte2 = cte1/sigma;
cte3 = 2*((sigma)^2);

V = NaN(1,N);
for m = 1:1:N
    input_kernel = [signal(1:m),signal(m+1:end)-signal(1:(end-m))];

    output_kernel = cte2*(exp(-(input_kernel.^2)/cte3));
    V(m) = (1/(N-m+1))*sum(output_kernel(m:end));
    
    clear('input_kernel','output_kernel');
end

V_rms = rms(V);
V = V - V_rms;

%% Estimation of the order of the AR model:
[~,~,reflect_coeffs] = aryule(signal,100);
uconf = 1.96/sqrt(1000);
lconf = -uconf;
% figure; 
% stem(reflect_coeffs); axis([-0.05 100.5 -1 1]);
% hold on
% plot([1 100],[1 1]'*[lconf uconf],'r')
% title('Reflection Coefficients by Lag'); xlabel('Lag');
% ylabel('Reflection Coefficent');
lim1 = find(reflect_coeffs>uconf);
lim2 = find(reflect_coeffs<lconf);
Order = max([lim1;lim2]);

%% Computation of the Correntropy Spectral Density (CSD) by means of Yule-Walker method:
[Pxx,F] = pyulear(V,Order,N,fs);
figure; plot(F,Pxx./max(Pxx)); title('Correntropy SD');

aux = xcorr(signal,'biased');
[Pxx,F] = pyulear(aux,Order,N,fs);
figure; plot(F,Pxx./max(Pxx)); title('Normal SD');
