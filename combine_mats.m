clc
clear all
load('BpfConc_001_ch36.mat');
load('BpfConc_001_ch57.mat');
load('BpfConc_001_ch124.mat');
filename='Chi_001_BpfConc.mat';
m=[ch124 ch57 ch36];
BpfConc001=zeros(size(m));
index=m(1,:);
for i=1:7
   [r,c,i]=find(index);
   BpfConc001(:,i)=m(:,c);
end
BpfConc001(1,:)=[];
save(filename,'BpfConc001');