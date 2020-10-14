function y = myMeanShiftSegmentation(im,sp_sig,col_sig,stopiter,numneighbour,lambda)
%Generate Space Gaussian Kernel
%global Gauss colsig
%densp=1/(sp_sig*sqrt(2*pi));
%excoefsp= -1/(2*sp_sig^2);
%threshold = 0.045;
%for i = 1:size(im,1)
%    expi = exp((i^2)*excoefsp)*densp;
%    if expi <threshold
%        pad= i-1;
%        break
%    end
%end
%Gauss = zeros(2*pad+1,2*pad+1);
%for i = 1:2*pad+1
%    for j = 1:2*pad+1
%        Gauss(i,j)=exp(((i-pad-1)^2+(j-pad-1)^2)*excoefsp)*densp;
%    end
%end
%colsig = col_sig;
%Continue

%densp=1/(sp_sig*sqrt(2*pi));
excoefsp= -1/(2*sp_sig^2);
%dencol=1/(col_sig*sqrt(2*pi));
excoefcol= -1/(2*col_sig^2);
[X,Y] = meshgrid(1:size(im,1),1:size(im,2));
%featurespace = cat(3,X/sp_sig,Y/sp_sig,im(:,:,1)/col_sig,im(:,:,2)/col_sig,im(:,:,3)/col_sig);

for i = 1:size(im,1)
    for j = 1:size(im,2)
        featurespace((i-1)*size(im,2)+j,:)=[X(i,j)/sp_sig,Y(i,j)/sp_sig,im(i,j,1)/col_sig,im(i,j,2)/col_sig,im(i,j,3)/col_sig];
    end
end
a=1-lambda;

for it = 1:stopiter
   [idx,D]=knnsearch(featurespace,featurespace,'k',numneighbour); 
   for val = 1:size(featurespace,1)
      %[idx,D] = knnsearch(featurespace,featurespace(val,:),'k',numneighbour); 
      coef=exp(-(D(val,:).^2)/2);
      coef = coef'./sum(coef);
      %temp =sum(featurespace(idx,:).*coef);
      grad(val,:)=sum(featurespace(idx(val,:),:).*[coef coef coef coef coef]);
   end
   featurespace=a*featurespace+lambda*grad;
end
%for it = 1:stopiter
%   for i = 1:size(im,1)
%      for j = 1:size(im,1)
%         [curr(i+pad,j+pad,:),X(i+pad),Y(j+pad)] = MSS(curr(i:i+2*pad,j:j+2*pad,:),X(i:i+2*pad,j:j+2*pad),Y(i:i+2*pad,j:j+2*pad)); 
%      end
%   end
%end
%for it = 1:stopiter
%    result = nlfilter(curr(:,:,1),[2*pad+1 2*pad+1], @(x) MSS(x));
%    curr = result;
%end
for i = 1:size(im,1)
    for j = 1:size(im,2)
        curr(i,j,:)=featurespace((i-1)*size(im,2)+j,3:5)*col_sig;
    end
end
y = curr;