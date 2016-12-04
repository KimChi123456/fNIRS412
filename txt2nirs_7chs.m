clear all
clc
[filen, pathn] = uigetfile('*.txt','Select the Voltage txt file');
path_file_n = [pathn filen];
if filen(1) == 0 | pathn(1) == 0
    return;
end
fid = fopen(path_file_n);
disp('Loading data...');
tline=fscanf(fid,'%c',Inf);
d=str2num(tline);
% [r,c]=size(d);
% d(:,[36:c])=[];
disp(size(d));
% t=[0:0.055:ceil(r*0.055)-0.45]';
t=d(:,1);
% stim start here
stim=d(:,2);
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
% stim and here
wavelengths=[780 805 830];
SD.Lambda = transpose(wavelengths);
SD.MeasList = [];
disp(size(t));
d(:,[1:4])=[];
% d(:,[1:4:27])=[];
    SD.nSrcs = 3;
    SD.nDets = 3;
    SD.SrcPos = [-1,0,0; 0,-1,0; 1,0,0];%[8 5 3]
    SD.DetPos = [-1,-1,0; 0,0,0; 1,-1,0];%[7 6 5]
    
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
%     
%     SD.MeasList(2,:) =  [1 4 1 2];
%     SD.MeasList(5,:) =  [2 5 1 2];
%     SD.MeasList(8,:) =  [1 1 1 2];
%     SD.MeasList(11,:) =  [2 1 1 2];
%     SD.MeasList(14,:) =  [1 2 1 2];
%     SD.MeasList(17,:) =  [3 1 1 2];
%     SD.MeasList(20,:) =  [2 3 1 2];
%     SD.MeasList(23,:) =  [3 2 1 2];
%     SD.MeasList(26,:) =  [3 3 1 2];
%     SD.MeasList(3,:) =  [1 1 1 3];
%     SD.MeasList(6,:) =  [1 2 1 3];
%     SD.MeasList(9,:) =  [1 4 1 3];
%     SD.MeasList(12,:) =  [2 1 1 3];
%     SD.MeasList(15,:) =  [2 3 1 3];
%     SD.MeasList(18,:) =  [2 5 1 3];
%     SD.MeasList(21,:) =  [3 3 1 3];
%     SD.MeasList(24,:) =  [3 2 1 3];
%     SD.MeasList(27,:) =  [3 1 1 3];

fs=1/0.055;
aux = t;
disp(size(d));
s = stim;
ml = SD.MeasList;
disp('I have all the information I need... Saving...');
save(strcat(pathn,filen(1:length(filen)-3),'nirs'),'fs','t', 'd', 'SD', 's', 'ml', 'aux');
disp('Done!');
