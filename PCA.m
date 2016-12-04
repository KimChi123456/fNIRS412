% [yc, svs, nSV] = enPCAFilter( y, SD, tInc, nSV )
%
% UI NAME:
% PCA_Filter
%
% [yc, svs, nSV] = enPCAFilter( y, SD, tInc, nSV )
% Perform a PCA filter on the data matrix y. 
%
% INPUT:
% y: This is the data matrix where rows are time points. If y is wavelength
%    data, then the columns are channels as described in SD.MeasList. If
%    y is concentration data, then the third dimension is channels and the
%    second dimension indicates HbO and HbR.
% SD: This is the source detector structure.
% tInc: This is a vector of length number of time points and is 1 to
%    indicate that a time point is included in the analysis and 0 if it is to
%    be excluded. This is useful for ignoring periods of time with strong
%    artifacts.
% nSV: This is the number of principle components to remove filter from the
%    data. This can be an integer to indicate the number of components to
%    remove. Or it can be a fraction less than 1 to indicate that enough
%    components should be removed to remove up to that fraction of the
%    variance in the data. If nSV is a single number it is applied to all
%    channels of data. This is useful for filtering motion artifacts. If it is
%    2 or more numbers, then it is applied to each wavelength or concentration
%    separately using the corresponding number.
%
%
% OUTPUT:
% yc: The filtered data matrix.
% svs: The singuler value spectrum from the PCA.
% nSV: This is the number of components filtered from the data.
%

function [yc, svs, nSV] = PCA( y, SD, nSV )

if ~exist('nSV')
    disp('USAGE: [yc,svs,nSV] = enPCAFilter( y, SD, tInc, nSV )');
    yc = [];
    svs = [];
    nSV = [];
    return
end
if any(isinf(y(:)))
    disp('WARNING: [yc,svs,nSV] = enPCAFilter( y, SD, tInc, nSV )');
    disp('      The data matrix y can not have any Inf numbers.');
    yc = [];
    svs = [];
    nSV = [];
    return
end
tInc=ones(size(y,1),1);
lstInc = find(tInc==1);
ml = SD.MeasList;
nMeas = size(ml,1);
nLambda = length(SD.Lambda);
for ii=1:nLambda
    nMeasPerLambda(ii) = length(find(ml(:,4)==ii));
end

if ~isfield(SD,'MeasListAct')
    SD.MeasListAct = ones(nMeas,1);
end

% do the PCA
ndim = ndims(y);

    % PCA on wavelength data
 %%   
    if length(nSV)==1
        % apply PCA to all data
        lstAct = find(SD.MeasListAct==1);
        yc = y;
        
        yo = y(lstInc,lstAct);
        
        y = squeeze(yo);

        c = y.' * y;
        [V,St,foo] = svd(c);
        svs = diag(St) / sum(diag(St));

        if nSV<1 % find number of SV to get variance up to nSV
            svsc = svs;
            for idx = 2:size(svs,1)
                svsc(idx) = svsc(idx-1) + svs(idx);
            end        
            ev = diag(svsc<nSV);
            nSV = find(diag(ev)==0,1)-1;
        else
            ev = zeros(size(svs,1),1);
            ev(1:nSV) = 1;
            ev = diag(ev);
        end 
       
        yc(lstInc,lstAct) = yo - y*V*ev*V';
%%
    

    else
        warndlg( 'enPCAFilter was not passed proper arguments', 'hmrPCAFilter' )
    end
end
