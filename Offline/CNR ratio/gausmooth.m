function Gau=gausmooth(wsize,alpha,x)
    windowWidth = int16(wsize);
    halfWidth = windowWidth / 2;
    gaussFilter = gausswin(wsize,alpha);
    gaussFilter = gaussFilter / sum(gaussFilter);
    Gau=conv(x, gaussFilter);

end