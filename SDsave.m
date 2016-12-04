wavelengths=[780 805 830];
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
save('SD','SD');