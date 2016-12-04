function plot_components(t, y, x_lpf, x, u, v, txt)

% Display components of SASS output signal
%
% plot_components(t, y, x_lpf, x, u, v, txt)
%
% See Example1.m and Example2.m


N = length(y);
L = length(u);

del = 1.3 * max(abs(y));
un = u/max(abs(u))*del/2;       % un : normalized version of u

plot(t, x_lpf)
line(t(1:L), un - del)
line(t, v - 2*del)
line(t, x - 3*del)
line(t, y + del)

m1 = max(y) + del;
m2 = min(x) - 3*del;
ylim([m2 m1] + (m1-m2)*[-0.05 0.05])

set(gca, 'ytick', [])

title(txt)

if 1
    Vtpt = -0.2 * max( abs(y) );
    Hzpt = t( round(0.02*N) );    
    FoSi = get(gca,'FontSize') - 1;
    
    text( Hzpt, Vtpt + x(20)  + del,   'Data',               'fontsize', FoSi, 'background', 'white');
    text( Hzpt, Vtpt + x_lpf(20),      'L y',                'fontsize', FoSi, 'background', 'white')
    text( Hzpt, Vtpt + un(20) - del,   'u'  ,                'fontsize', FoSi)
    text( Hzpt, Vtpt + v(20)  - 2*del, 'A^{-1} B_1 u'  ,     'fontsize', FoSi)
    text( Hzpt, Vtpt + x(20)  - 3*del, 'L y + A^{-1} B_1 u', 'fontsize', FoSi)    
end

xlim([0 N])


