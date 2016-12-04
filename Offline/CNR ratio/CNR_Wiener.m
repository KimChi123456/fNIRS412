close all, clear all, clc

load('D:\IU\project(filtering fNIRS)\GUI\data testNIRS\rest\Tuan4.mat');
data=sav_data; Task=data(:,1);
oxy=data(:,2:8);
size(oxy)
deoxy=data(:,9:end);
[length ch]=size(oxy);
rest_find=find(Task==1);

task_mark=rest_find(1);

rest_oxy=oxy(1:task_mark,1:ch);
rest_deoxy=deoxy(1:task_mark,1:ch);
task_oxy=oxy(task_mark+1:end,1:ch);
task_deoxy=deoxy(task_mark+1:end,1:ch);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PCA
oxyRaw=oxy;

K=size(rest_oxy,1)/1;

check_size=2*K

segments=fix(length/K);
Remains=rem(length,K);
remains=Remains;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=K/4;
cnr=[];
Filt=[];
NFFT=2^nextpow2(K);
for CH=1:ch
    final=[];
   %%%%%%%%%%%%%%%%%%%%%%%%NOISE (REFERENCE)
   noise=rest_oxy(1:K,CH);
   N=fft(noise,NFFT);
   Pnn=N.*conj(N);
   
   for i=0:segments-1
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       s=oxy(i*K+1:(i+1)*K,CH);
       S=fft(s,NFFT);
       Pss=S.*conj(S);
   
       %%%%%%%%%%%%%%%%%WIENER TRANSFER FUNCTION
       Wiener=(Pss-Pnn)./(Pss);
       Y=S.*Wiener; %Filtered transfer funtion
       y=ifft(Y,NFFT);
       output=real(y(1:K));
       final=[final;output];
   end
   s=oxy(end-K+1:end,CH);
   S=fft(s,NFFT);
   Pss=S.*conj(S);
   
   %%%%%%%%%%%%%%%%%WIENER TRANSFER FUNCTION
   Wiener=(Pss-Pnn)./(Pss);
   Y=S.*Wiener; %Filtered transfer funtion
   y=ifft(Y,NFFT);
   output=real(y(1:K));
   output=output(end-Remains+1:end);
   final=[final;output];
   
   Filt=[Filt final];
   
   figure
   subplot(2,1,1)
   plot(oxy(1:end,CH))
   subplot(2,1,2)
   plot(Filt(:,CH),'r')
   
   %%CNR
   CNR_filt=(mean(Filt(:,CH))-mean(oxyRaw(:,CH)))/sqrt((std(Filt(:,CH))).^2+(std(oxyRaw(:,CH))).^2);
   cnr=[cnr CNR_filt];
end




cnr_filt=cnr
mean_cnr=mean(cnr_filt)