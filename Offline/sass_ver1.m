function [x, cost, u, v] = sass(y, d, fc, K, lam, pen, a, Nit, u_init)
% [x, cost] = sass(y, d, fc, K, lam, pen, a, Nit)
% Sparsity-assisted signal smoothing (SASS)
% Signal model: y = f + g + noise
% f : low-pass signal
% g : sparse order-K derivative
%
% INPUT
%   y - noisy data
%   d - degree of filter is 2d (d = 1, 2, 3)
%   fc - cut-off frequency (normalized frequency, 0 < fc < 0.5)
%   K - order of sparse derivative (1 <= K <= 2d)
%   lam - regularization parameter
%   pen - penalty function ('L1', 'log', or 'atan')
%   a - non-convexity parameter (ignored for 'L1' penalty)
%   Nit - number of iterations
%
% OUTPUT
%   x - output of SASS algorithm
%   cost - cost function history
%
% Use sass(..., u_init) to specify initial u.
% Use [x, cost, u, v] = sass(...) to obtain also:
%   u - sparse signal
%   v - filtered signal, A\(B1*u)

% Ivan Selesnick,  NYU-Poly, 2012
% Reference: Sparsity-Assisted Signal Smoothing
% http://eeweb.poly.edu/iselesni/sass

switch pen
    case 'L1'
        phi = @(x) abs(x);
        psi = @(x) abs(x);
    case 'log'
        phi = @(x) 1/a * log(1 + a*abs(x));
        psi = @(x) abs(x) .* (1 + a*abs(x));
    case 'atan'
        phi = @(x) 2./(a*sqrt(3)) .* (atan((2*a.*abs(x)+1)/sqrt(3)) - pi/6);
        psi = @(x) abs(x) .* (1 + a.*abs(x) + a.^2.*abs(x).^2);
    otherwise
        disp('penalty must be L1, log, or atan')
        s = []; u = []; v = []; cost = [];
        return
end

y = y(:);                                       % Convert to column
cost = zeros(1,Nit);                            % Cost function history
N = length(y);

[A, B, B1] = ABfilt(d, fc, N, K);               % Banded filter matrices
H = @(x) A\(B*x);                               % H : high-pass filter
AAT = A*A';                                     % A*A' : banded matrix [sparse]
Hy = H(y);
b = B1'*(AAT\(B*y));
if exist('u_init', 'var')                       % initialization
    u = u_init;
else
    u = diff(y, K);
end

for k = 1:Nit
    Lam = spdiags(psi(u)/lam, 0, N-K, N-K);     % Lam : diagonal matrix
    Q = AAT + B1*Lam*B1';                       % Q : banded matrix
    u = Lam * (b - (B1'*(Q\(B1*(Lam*b)))));     % Update
    cost(k) = 0.5 * sum( abs(Hy-A\(B1*u)).^2 ) + lam * sum(phi(u));
end

v = A\(B1*u);
v = [nan(d,1); v; nan(d,1)];                    % extend signal to length N

x = y - [nan(d,1); Hy; nan(d,1)] + v;           % Total solution L(y) + A\(B1*u)

% Check for zero-locking
r = B1'*(AAT\(B*y-B1*u)) / lam;
k = abs(r) > 1.02;                              % Use margin of 0.02
NZL = sum(k);                                   % NZL : Number of falsely locked zeros
fprintf('%d incorrectly locked zeros detected.\n', NZL);

