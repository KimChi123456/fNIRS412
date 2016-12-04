function [CSD,F] = CSD_function(signal,fs)
%{
Function for computing the Correntropy-Based Spectral Density (CDS) of a 
signal. 

The Yule-Walker method is used in  the estimation.

INPUTS:
        signal: the signal itself
        fs: the sample frequency in Hz
OUTPUTS:
        CSD: the CDS of the signal; Length = 2*(length(signal))+1
        F: a vector frequency between 0 and fs/s to plot, if needed, the
        CDS. If one does no want to use it, put '~' in the call of the
        function.

PROJECT: Research Master in signal theory and bioengineering - Univeristy of Valladolid

DATE: 6/05/2015

VERSION: 1º

AUTHOR: Jesús Monge Álvarez
%}
%% Checking the input parameters of the function:
control = ~isempty(signal);
assert(control,'You must introduce an input signal.');
control = ~isempty(fs);
assert(control,'You must introduce an frequency sample of the input signal in Hz.');

%% Computation of centered correntropy function:
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
% plot([1,100],[1,1]'*[lconf,uconf],'r')
% title('Reflection Coefficients by Lag'); xlabel('Lag');
% ylabel('Reflection Coefficent');
lim1 = find(reflect_coeffs>uconf);
lim2 = find(reflect_coeffs<lconf);
Order = max([lim1;lim2]);

%% Computation of the Correntropy Spectral Density (CSD) by means of Yule-Walker method:
[CSD,F] = pyulear(V,Order,N,fs);
% figure; plot(F,CSD./max(CSD)); title('Normalized CSD');

end % End of the 'CSD_function.m'
