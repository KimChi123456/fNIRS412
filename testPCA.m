load('Chi_001.TXT');
y=Chi_001;
y(:,[1:4])=[];
load('SD');
nSV=5;
fs=1/0.055;
hpf=0.01;
lpf=0.5;
ppf=[6 6 6];
dod = hmrIntensity2OD( y );
[yc, svs, nSV] = PCA( dod, SD, nSV );
[y2,ylpf] = hmrBandpassFilt( yc, fs, hpf, lpf );
dc = hmrOD2Conc( y2, SD, ppf );
for i=1:7
subplot(7,1,i),plot(dc(:,1,i));
end



