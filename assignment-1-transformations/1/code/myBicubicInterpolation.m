function y = myBicubicInterpolation(bar)
dim = size(bar);
length =dim(1,1);

%[Xi,Yi]=meshgrid(1:1:length);
%xres = linspace(1,length,2*length+1);
%yres = linspace(1,length,3*length+1);
%[Xq,Yq] =meshgrid(xres,yres);
%y = interp2(Xi,Yi,bar,Xq,Yq);

temp=zeros(3*length-2,2*length-1);
temp(1:3:end,1:2:end)=bar(1:1:end,1:1:end);
temp(1:3:end,2:2:end)=(temp(1:3:end,1:2:end-1)+temp(1:3:end,3:2:end))./2;
temp(2:3:end,1:1:end)=(2.*temp(1:3:end-1,1:1:end)+temp(4:3:end,1:1:end))./3;
temp(3:3:end,1:1:end)=(temp(1:3:end-1,1:1:end)+2.*temp(4:3:end,1:1:end))./3;
temp=uint8(temp);
y=temp;