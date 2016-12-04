function [x, cost, u, v, a] = sass2(y, d, fc, K, lam, pen, rho, Nit, u_init)
% [x, cost] = sass2(y, d, fc, K, lam, pen, rho, Nit)
% Sparsity-assisted signal smoothing (SASS)
% Signal model: y = f + g + noise
% f : low-pass signal
% g : sparse order-K derivative
%
% This version (version 2) of the program checks for the occurrence of
% zero-locking and corrects for it by rerunning the algorithm
% with unlocked values.
%
% INPUT
%   y - noisy data
%   d - filter degree parameter (d = 1, 2, 3)
%   fc - cut-off frequency (normalized, 0 < fc < 0.5)
%   K - order of sparse derivative (1 <= K <= 2d)
%   lam - regularization parameter
%   pen - penalty function ('L1', 'log', or 'atan')
%   rho - normalized non-convexity parameter (0 <= rho <= 1)
%	note: rho is ignored for 'L1' penalty
%   Nit - number of iterations
%
% OUTPUT
%   x - output of SASS algorithm
%   u - sparse signal
%   v - filtered signal, A\(B1*u)
%   cost - cost function history
%
% Use sass2(..., u_init) to specify initial u.
% Use [x, cost, u, v, a] = sass2(...) to obtain also:
%   u - sparse signal
%   v - filtered signal, A\(B1*u)
%   a - non-convexity parameter

% Ivan Selesnick,  NYU-Poly, 2012
% Reference: Sparsity-Assisted Signal Smoothing
% http://eeweb.poly.edu/iselesni/sass

switch pen
    case 'L1'
        phi = @(x, a) abs(x);
        psi = @(x, a) abs(x);
        rho = 0;
    case 'log'
        phi = @(x, a) 1/a * log(1 + a*abs(x));
        psi = @(x, a) abs(x) .* (1 + a*abs(x));
    case 'atan'
        phi = @(x, a) 2./(a*sqrt(3)) .* (atan((2*a.*abs(x)+1)/sqrt(3)) - pi/6);
        psi = @(x, a) abs(x) .* (1 + a.*abs(x) + a.^2.*abs(x).^2);
    otherwise
        disp('penalty must be L1, log, or atan')
        s = []; u = []; v = []; cost = [];
        return
end

y = y(:);                                       % Convert to column
cost = zeros(1,Nit);                            % Cost function history
N = length(y);

% [A, B, B1] = ABfilt(d, fc, N, K);               % Banded filter matrices
[A, B, B1, D, a, b, b1, H1norm] = ABfilt(d, fc, N, K);

a = rho * H1norm^2/lam;                         % a : controls non-convexity of penalty


H = @(x) A\(B*x);                               % H : high-pass filter
AAT = A*A';                                     % A*A' : banded matrix [sparse]
Hy = H(y);
b = B1'*(AAT\(B*y));
if exist('u_init', 'var')                       % Initialization
    u = u_init;
else
    u = diff(y, K);
end

MaxRuns = 5;
for i = 1:MaxRuns
    
  for k = 1:Nit
    Lam = spdiags(psi(u, a)/lam, 0, N-K, N-K);  % Lam : diagonal matrix
    Q = AAT + B1*Lam*B1';                       % Q : banded matrix
    u = Lam * (b - (B1'*(Q\(B1*(Lam*b)))));     % Update
    cost(k) = 0.5 * sum( abs(Hy-A\(B1*u)).^2 ) + lam * sum(phi(u, a));
  end
    
  r = B1'*(AAT\(B*y-B1*u)) / lam;
  k = abs(r) > 1.02;                            % Margin of 0.02
  u(k) = ( A \ B1(:, k) ) \ ( Hy - A\(B1(:, ~k) * u(~k)) );   
    
  NZL = sum(k);                                 % NZL : Number of falsely locked zeros
  fprintf('Run %d: %d incorrectly locked zeros detected.\n', i, NZL);
  
  if NZL == 0
      break
  end
  
end

v = A\(B1*u);
v = [nan(d,1); v; nan(d,1)];                    % extend signal to length N

x = y - [nan(d,1); Hy; nan(d,1)] + v;           % Total solution L(y) + A\(B1*u)

