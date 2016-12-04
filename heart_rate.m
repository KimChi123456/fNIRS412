% clear all
clc
currentFolder=pwd;
% [filen, pathn] = uigetfile('*.mat','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);
data=HbO;
% classify data
% t=data(:,1);
Fs=1/t(2,1);
data(:,[1:4])=[];

Oxy=data(:,[1:3:size(data,2)]);
Deoxy=data(:,[2:3:size(data,2)]);
% HeartTXT=data(:,end-1);
lengthData=length(Oxy);
oxy=mean(Oxy,2);
Test=oxy;
Channel=size(oxy,2);
% Fs=1/data(2,1);         %18.1818
lengthData1=lengthData;

%% arrange data (15s)

time=20;
Window=round(time*Fs);      
length15=Window*floor(lengthData1/Window);
% oxy=mean(oxy,2);
% I=floor(lengthData1/Window);                             %Number of interval
I=1;
% Heart=reshape(HeartTXT(1:(I*Window),1),Window,I);
oxy=reshape(oxy(1:(I*Window),1),Window,I); 
figure
plot (oxy)
% Breath=reshape(BreathTXT(1:length15,1),Window,[]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
for n=1:I
   if (mode(n,5)==0)
       figure
   end
    moxy=oxy(:,n);
%     mHeart=Heart(:,n);
    OXY=(oxy(:,n)-mean(moxy(:,1)))/max(oxy(:,n)-mean(moxy(:,1)));
%     heart=(Heart(:,n)-mean(mHeart(:,1)))/max(Heart(:,n)-mean(mHeart(:,1)));
    cd([currentFolder '\package_emd\EMDs']);

% y1=(heart-sgolayfilt(heart,3,41));
% y1=smooth(y1,10);
% y1(end)=mean(y1);
% y1(1)=mean(y1);
% fNorm = 2.5 / (Fs/2);               %# normalized cutoff frequency
% type='low';N=2;
% [b,a] = butter(N, fNorm, type);  %# 10th order filter
% y2 = filtfilt(b, a, y1);
% y2=y2';y2=y2/max(y2);
% % y2=ones(size(y2));
% Sensor=y2;
% Sensor=(Sensor-mean(Sensor))/max(Sensor-mean(Sensor));
% y3(n,:)=Sensor;
X=OXY';
% Y=Sensor';%%%%%%%%%%%%%%%%
for j=1:4
    XX = emd(X);
%     YY=emd(Y);
end

%% ICA

cd([currentFolder '\FastICA_25']);

[c] = fastica(XX);              % compute and plot unminxing using fastICA	
% c=XX;
% s = fastica (YY);%%%%%%%%%%%%%%%%%%%
cd(currentFolder);

% Sensor=breath;
% Sensor=(Sensor-mean(Sensor))/max(Sensor-mean(Sensor));

cd([currentFolder '\Correntropy_spectral_density']);
HeartCheck=0;
 
%  if (i<(5))
      subplot(I,1,n);
% 
%       label=data(n*Window,1);
%       
%      % plot(HeartTXT((i*Window-Window+1):(i*Window),:),'color',[0,0,1]);
%      plot(Sensor,'color',[0,0,1]);
%      hold on;
%      A=zeros(size(oxy,1));
for i=1:size(c,1)
   
    C=(c(i,:)/max(c(i,:)))-mean(c(i,:)/max(c(i,:)));
%     S=(s(i,:)/max(s(i,:)))-mean(s(i,:)/max(s(i,:)));
    [CSD,F] = CSD_function(c(i,:),Fs);
%     [CSD2,F2]=CSD_function(s(i,:),Fs)
    if i==1
        C0=zeros(size(c,1),length(CSD));
%         S0=zeros(size(s,1),length(CSD2))
    end
    C0(i,:)=CSD(:,1);
    [maxVals,maxLocs]=findpeaks(CSD);
%     S0(i,:)=CSD2(:,1);
%     [MaxVals2,MaxLocs2]=findpeaks(CSD2);
    if size(maxLocs,1)*size(maxLocs,2)>0
        [maxVal,maxLoc]=max(maxVals); maxLoc=maxLocs(maxLoc);
    else
        [maxVal,maxLoc]=max(CSD);
    end
    if F(maxLoc)>0.5&& F(maxLoc)<3 %%check Max belongs to [0.5-3Hz]
        if maxVal>HeartCheck
            HeartComponent=i;
            HeartCheck=maxVal;
%               plot(C,'r');
            F(maxLoc) 
            A=C;    
            
        end
    else
        maxVal=max(maxVals(F(maxLocs)>0.14&F(maxLocs)<1));        
    end
    
    axis tight
  
end
 B(n,:)=A;
   plot(A,'r');
%    hold on;
%     [acor,lag]=xcorr(A,y2);
%     xcor(n,:)=acor;
%     l(n,:)=lag;
%     com(n,:)=A;
%     sen(n,:)=Sensor;
% title(label);
% cor=(A*y2')/(norm(A)*norm(y2))
%cor=corr2(A,y2)
%cor=corr(A,Sensor)
% [pks,locs]=findpeaks(Sensor,'MinPeakDistance',10);
% text(locs,pks,'*');
% title(cor)
% ylabel(length(pks));
end
oxy1=oxy(:,1)-oxy(:,2);
figure
subplot (2,1,1)
plot (oxy1);
% subplot (2,1,2)
% plot (oxy1(2,:));
% to compare
%    figure
%    title('compare');
%   S=Sensor;
%  for i=1:I
%      C=(B(i,:)/max(B(i,:)))-mean(B(i,:)/max(B(i,:)));
%      y2=y3(i,:);
% %      [CSD,F] = CSD_function(c(i,:),Fs);
% %      [CSD2,F2] = CSD_function(y3(i,:),Fs);
% %      cor=corr2(CSD,CSD2);
% %      subplot(I,1,i),plot(CSD)
% %      hold on
% %      plot(CSD2,'r');
% %      [maxVals,maxLocs]=findpeaks(CSD);
% %      [maxVals2,maxLocs2]=findpeaks(CSD2);
% %      [max1,maxf1]=max(CSD);
% %      [max2,maxf2]=max(CSD2);
% %      cor=maxf1-maxf2
% %     if size(maxLocs,1)*size(maxLocs,2)>0
% %         [maxVal,maxLoc]=max(maxVals); maxLoc=maxLocs(maxLoc);
% %     else
% %         [maxVal,maxLoc]=max(CSD);
% %     end
% %      if size(maxLocs2,1)*size(maxLocs2,2)>0
% %         [maxVal2,axLoc2]=max(maxVals2); MaxLoc2=maxLocs2(MaxLoc2);
% %     else
% %         [maxVal2,MaxLoc2]=max(CSD2);
% %     end
% %    maxLoc
% %    MaxLoc2
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %Power Spectral Density Estimates Using FFT
% 
% pxxC=pwelch(C,[],[],[],Fs);
% pxxY=pwelch(y2,[],[],[],Fs);
% L=length(pxxC)*2-2;
% F = Fs*(0:(L/2))/L;
% plot(F,pxxC,'r');hold on
% plot(F,pxxY);
% [max1,fm1]=max(pxxC);
% [max2,fm2]=max(pxxY);
% error=abs(fm1-fm2)/mean([fm1,fm2]);
% cor(1,i)=1-error;
% f1(1,i)=F(fm1);
% heart_rate_estimated(1,i)=f1(1,i)*60;
% f2(1,i)=F(fm2);
% heart_rate_measured(1,i)=f2(1,i)*60;
% % [peak1,loc1]=findpeaks(fft1);
% % [peak2,loc2]=findpeaks(fft2);
% % maxf1=max(peak1)
% % maxf2=max(peak2)
% % subplot(I,1,i),plot(fft1);hold on
% % plot(fft2,'r');
%   end
%  
