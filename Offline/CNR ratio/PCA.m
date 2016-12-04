function output=PCA(rest,x,k)
   H_base=rest;
   [length1 ch]=size(H_base)
   mH_base=mean(H_base);
   H_base=H_base-repmat(mH_base,[length1 1]);
   C = (1/length1)*(H_base')*(H_base); % Covariance matrix

    [U S]=eig(C); %

% [U S V] = svd(C,'econ')
    U=U(1:k,:)';
    I=zeros(size(U,1));
    for i=1:size(U,1)
        I(i,i)=1;
    end
%     X=x;
    X=x-repmat(mean(x),[size(x,1) 1]);
    output= (X*(I-(U*U'))); size(output)
end