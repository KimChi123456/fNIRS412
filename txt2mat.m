%% included combining channels and plot PCAHbO vs BpfHbO

%% 36
clear all
clc
load('PCAHbO_005_ch36.txt');
ch36=PCAHbO_005_ch36;
t=ch36(:,1);
t(1,:)=[];
ch36(:,1)=[];

%% 57

load('PCAHbO_005_ch57.txt');
ch57=PCAHbO_005_ch57;
ch57(:,1)=[];

%% 214
load('PCAHbO_005_ch214.txt');
ch214=PCAHbO_005_ch214;
ch214(:,1)=[];

%%
m=[ch214 ch57 ch36];

PCAHbO_005=zeros(size(m));
%rearange
index=m(1,:);
for i=1:7
   [r,c,i]=find(index);
   PCAHbO_005(:,i)=m(:,c);
end
PCAHbO_005(1,:)=[];
save('Chi_PCAHbO_005.mat','PCAHbO_005');
save('t.mat','t');

%% plot
figure
for i=1:7
   subplot(7,1,i), plot(t,PCAHbO_005(:,i));
   if (i==7) 
     xlabel ('PCA HbO Concentration 005');  
   end
end
print ('Chi_005_PCAHbO','-dpng');

%Power Spectral Density Estimates Using FFT
% Fs=1/0.055;
% pxx=[];
% fmIndex=[];
% for i=1:7
%     pxx(:,i)=pwelch(BpfHbO_005(:,i),[],[],[],Fs);
%     [max,fmIndex(1,i)]=max(pxx(:,i));
% end
% % pxxC=pwelch(C,[],[],[],Fs);
% % pxxY=pwelch(y2,[],[],[],Fs);
% L=length(pxx)*2-2;
% F = Fs*(0:(L/2))/L;
% fm=[];
% for i=1:7
%     fm(1,i)=F(fmIndex(1,i));
%     subplot(7,1,i), plot(F,pxx(:,i),'r');
% end





