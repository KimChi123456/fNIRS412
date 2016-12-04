function y = preproc(r, M, x)
% y = preproc(r, M, x)
%
% Preprocess signal x prior to SASS in order to reduce
% the potential occurrence of transients at start and end of signal.
%
% The preprocessing replaces the M samples at both ends
% with a polynomial least square approximation of degree r.
% 
% INPUT
%    r : degree of polynomial
%    M : number of end-point samples to use for fitting the polynomial
%    x : 1D signal 
%
% OUTPUT
%    y : 1D signal

% Ivan Selesnick,  2012


% convert to row vector

trans = false;
if size(x, 1) > 1
    x = x.';
    trans = true;
end

m = 1:M;

y = x;

% polynomial approximation of start of signal

p = polyfit(m, x(m), r);

y(m) = polyval(p, m);

% polynomial approximation of end of signal

N = length(x);

p = polyfit(m, x(end+1-m), r);

y(end+1-m) = polyval(p, m);




if trans
    y = y.';
end

