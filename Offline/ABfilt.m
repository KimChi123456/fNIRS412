function [A, B, B1, D, a, b, b1, H1norm, HTH1norm] = ABfilt(deg, fc, N, K)
% [A, B, B1] = ABfilt(d, fc, N, K)
%
% Banded matrices for zero-phase high-pass recursive filter.
% The matrices are created as 'sparse' structures.
%
% INPUT
%   d  : degree of filter is 2d
%   fc : cut-off frequency (normalized frequency, 0 < fc < 0.5)
%   N  : length of signal
%   K  : oder of difference matrix D (need 1 <= K <= 2d)
%
% OUTPUT
%   A, B, B1 : banded filter matrices
%       with B = B1*D where D is the K-th order difference

% Ivan Selesnick,  NYU-Poly, 2012
% Reference: Sparsity-Assisted Signal Smoothing
% http://eeweb.poly.edu/iselesni/sass

b1 = 1;
for i = 1:2*deg-K
    b1 = conv(b1, [-1 1]);
end
b1 = b1 * (-1)^deg;

d = 1;
for i = 1:K
    d = conv(d, [-1 1]);
end

b = conv(b1, d);

omc = 2*pi*fc;
t = ((1-cos(omc))/(1+cos(omc)))^deg;

a = 1;
for i = 1:deg
    a = conv(a, [1 2 1]);
end
a = b + t*a;

A = spdiags( a(ones(N-2*deg,1), :), -deg:deg, N-2*deg, N-2*deg);    % A: Symmetric banded matrix
B1 = spdiags(b1(ones(N,1), :), 0:2*deg-K, N-2*deg, N-K);      % B1: banded matrix
D = spdiags(d(ones(N,1), :), 0:K, N-K, N);               % D: banded matrix
B = B1 * D;                                               % B: banded matrix



% Calculate filter norms

imp = zeros(N-K, 1);
imp(round(N/2)) = 1;                        % imp : impulse signal (located at center to avoid transients)

h1 = A \ (B1 * imp);
H1norm = sqrt( sum( abs( h1 ).^2 ) );       % norm of filter inv(A)*B1

hh = B' * ((A*A') \ (B1 * imp));
HTH1norm = sqrt( sum( abs( hh ).^2 ) );     % norm of filter B'*inv(A*A')*B1
