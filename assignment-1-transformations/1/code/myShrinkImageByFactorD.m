function y = myShrinkImageByFactorD(im,d)
%a = downsample(im.',d);
%y = downsample(a.',d);
y = im(1:d:end,1:d:end);