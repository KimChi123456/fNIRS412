clear all
clc
currentFolder=pwd;
% [filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
% path_file_n = [pathn filen];
% if filen(1) == 0 | pathn(1) == 0
%     return;
% end
% fid = fopen(path_file_n);
% disp('Loading data...');
% tline=fscanf(fid,'%c',Inf);
% data=str2num(tline);
load('fNIRSdata2/Chi_short_001/ChiK13_short_1282_Hb.TXT');
data=ChiK13_short_1282_Hb;
% classify data
% t=data(:,1);
Fs=1/data(2,1);
data(:,[1:4])=[];

% Oxy=data(:,[1:3:size(data,2)]);
oxy=data(:,1);
Deoxy=data(:,[2:3:size(data,2)]);
% HeartTXT=data(:,end-1);
lengthData=length(oxy);
% oxy=mean(Oxy,2);
Test=oxy;
% Channel=size(oxy,2);
% Fs=1/data(2,1);         %18.1818
lengthData1=lengthData;

%% arrange data (15s)

time=250;
Window=round(time*Fs);      
length15=Window*floor(lengthData1/Window);
% oxy=mean(oxy,2);

% I=floor(lengthData1/Window);                             %Number of interval
I=1;
% Heart=reshape(HeartTXT(1:(I*Window),1),Window,I);
oxy=reshape(oxy(1:(I*Window),1),Window,I); 
fftO=abs(fft(oxy));
L=length(oxy);
figure
plot(fftO)
title('oxy data in freq domain');

for n=1:I
   if (mode(n,5)==0)
%        figure
   end
    moxy=oxy(:,n);
%     mHeart=Heart(:,n);
    OXY=(oxy(:,n)-mean(moxy(:,1)))/max(oxy(:,n)-mean(moxy(:,1)));
%     heart=(Heart(:,n)-mean(mHeart(:,1)))/max(Heart(:,n)-mean(mHeart(:,1)));
    cd([currentFolder '\package_emd\EMDs']);


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
%    plot(A,'r');

end
fftA=abs(fft(A));
% L=length(oxy);
figure
plot(fftA)
title('heart data in freq domain');
fftt=fftO-fftA';
figure
plot(fftt);