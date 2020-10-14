function [imint,xup,yup] = MSS(inpim,x,y)
global Gauss colsig
dencol=1/(colsig*sqrt(2*pi));
excoefcol= -1/(2*colsig^2);
len=size(inpim,1);
mid = int16(len/2);
z = Gauss;
coef = zeros(len,len);
for i = 1:len
   for j = 1:len
       coef(i,j)= Gauss(i,j)*exp(sqrt(sum((inpim(i,j,:)-inpim(mid,mid,:)).^2,'all'))*excoefcol)*dencol;  
   end
end
rati = inpim(mid,mid,:);
temp =inpim;
b=0.2;
a=1-b;
rati(1,1,1) =a*inpim(mid,mid,1)- b*sum(temp(:,:,1).*coef)/sum(coef);
rati(1,1,2) =a*inpim(mid,mid,2)- b*sum(temp(:,:,2).*coef)/sum(coef);
rati(1,1,3) =a*inpim(mid,mid,3)- b*sum(temp(:,:,3).*coef)/sum(coef);
xup = a*x(mid,mid)- b*sum(x.*coef)/sum(coef);
yup = a*y(mid,mid)- b*sum(y.*coef)/sum(coef);
%rati = conv2(inpim,coef)/sum(coef);
imint=rati;