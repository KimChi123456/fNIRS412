function r = plot_scatter(A, B, B1, y, u, lam, pen, a)

% Display optimality scatter plot for SASS
%
% plot_scatter(A, B, B1, y, u, lam, pen, a)
%
% See Example1.m and Example2.m


switch pen
    case 'L1'
        phi = @(x) abs(x);
        dphi = @(x) sign(x);
        psi = @(x) abs(x);
    case 'log'
        phi = @(x) 1/a * log(1 + a*abs(x));
        dphi = @(x) 1./(1 + a*abs(x)) .* sign(x);
        psi = @(x) abs(x) .* (1 + a*abs(x));
    case 'atan'
        phi = @(x) 2./(a*sqrt(3)) .* (atan((2*a.*abs(x)+1)/sqrt(3)) - pi/6);
        dphi = @(x) 1./(1 + a.*abs(x) + a.^2.*abs(x).^2) .* sign(x);
        psi = @(x) abs(x) .* (1 + a.*abs(x) + a.^2.*abs(x).^2);
    otherwise
        disp('penalty must be L1, log, or atan')
        r = [];
        return
end


GC = [1 1 1] * 0.5;  % GC : gray color

AAT = A*A';

r = B1'*(AAT\(B*y-B1*u)) / lam;

m = max(abs(u));

% Display optimality scatter plot

t = linspace(-eps, -m*1.5, 100);
plot(t, dphi(t), 'color', GC )

t = linspace(eps, m*1.5, 100);
line(t, dphi(t), 'color', GC)

line([0 0], dphi([-eps eps]), 'color', GC )

line(u, r, 'line', 'none', 'marker', '.', 'markersize', 7);

title('Optimality Scatter Plot')

ylabel('B_1^T (AA^T)^{-1} (B y - B_1 u) / \lambda')
xlabel('u')

ylim([-1 1]*1.5)
xlim([-1 1]*1.2*m)

shg

