%{
Convert fNIRS Voltage data from .txt file to .nirs file which can be used
by Homer2
variable in nirs file: t, d, SD, s, ml, aux
.txt matrix: [#time point] by [3*channels] 
%}
%%
clear all
clc
%load Voltage .txt file
[filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
path_file_n = [pathn filen];
if filen(1) == 0 | pathn(1) == 0
    return;
end
fid = fopen(path_file_n);
disp('Loading data...');
tline=fscanf(fid,'%c',Inf);
d=str2num(tline);
t=d(:,1); %time vector
stim=d(:,2); %stim vector
d(:,[1:4])=[]; 
disp(size(d));
wavelengths=[780 805 830];



%% stimulus vector
stim(find(stim==2))=0;
for i=1:length(stim)
    if i==length(stim)
        break;
    end
    if (stim(i+1)==1)&(stim(i)==0)
        stim(i+1)=2;
    end
    if (stim(i+1)==0)&(stim(i)==1)
        stim(i)=-1;
    end
end
stim(find(stim==1))=0;
stim(find(stim==2))=1;


%% SD matrix
SD.Lambda = transpose(wavelengths);
SD.MeasList = [];

    SD.nSrcs = 3; %#transmiters
    SD.nDets = 3; %#detectors
    %prob position
    SD.SrcPos = [96.79,115.5,197.3; 126.95,142.1, 189.5;157.1, 115.5, 200.3];%[8 5 3]
    SD.DetPos = [96.79,142.1, 209.6; 126.95,115.5,187.2;157.1,142.1, 204.3];%[7 6 5]
    
    SD.MeasList(1,:) =  [1 2 1 1];
    SD.MeasList(4,:) =  [3 2 1 1];
    SD.MeasList(7,:) =  [1 1 1 1];
    SD.MeasList(10,:) =  [2 2 1 1];
    SD.MeasList(13,:) =  [3 3 1 1];
    SD.MeasList(16,:) =  [2 1 1 1];
    SD.MeasList(19,:) =  [2 3 1 1];
    
    SD.MeasList(2,:) =  [1 2 1 2];
    SD.MeasList(5,:) =  [3 2 1 2];
    SD.MeasList(8,:) =  [1 1 1 2];
    SD.MeasList(11,:) =  [2 2 1 2];
    SD.MeasList(14,:) =  [3 3 1 2];
    SD.MeasList(17,:) =  [2 1 1 2];
    SD.MeasList(20,:) =  [2 3 1 2];
    
    SD.MeasList(3,:) =  [1 2 1 3];
    SD.MeasList(6,:) =  [3 2 1 3];
    SD.MeasList(9,:) =  [1 1 1 3];
    SD.MeasList(12,:) =  [2 2 1 3];
    SD.MeasList(15,:) =  [3 3 1 3];
    SD.MeasList(18,:) =  [2 1 1 3];
    SD.MeasList(21,:) =  [2 3 1 3];

fs=1/0.055;
aux = t;
disp(size(d));
s = stim;
ml = SD.MeasList;

%% Save all parameters to .nirs file
disp('I have all the information I need... Saving...');
save(strcat(pathn,filen(1:length(filen)-3),'nirs'),'fs','t', 'd', 'SD', 's', 'ml', 'aux');
disp('Done!');
