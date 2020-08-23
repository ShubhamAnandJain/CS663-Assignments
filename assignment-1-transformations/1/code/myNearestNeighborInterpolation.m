function y = myNearestNeighborInterpolation(bar)
dim = size(bar);
length =dim(1,1);

temp=zeros(3*length-2,2*length-1);
temp(1:3:end,1:2:end)=bar(1:1:end,1:1:end);
temp(1:3:end,2:2:end)=bar(1:1:end,1:1:end-1);
temp(2:3:end,1:1:end)=temp(1:3:end-1,1:1:end);
temp(3:3:end,1:1:end)=temp(4:3:end,1:1:end);
temp=uint8(temp);
y=temp;