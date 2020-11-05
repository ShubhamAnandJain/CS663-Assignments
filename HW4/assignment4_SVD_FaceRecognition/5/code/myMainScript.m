%% MyMainScript

tic;
%% Your code here
clear;
[trainvecspace, testvecspace, trainnumimg, testnumimg, imgrownum, imgcolnum] = orldataloader();
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
[U,S,V] = svd(trainvecspace,'econ');
kretain = 20;
Ured = zeros(size(U));
Ured(:,1:kretain) = U(:,1:kretain);
eigenvec = normc(Ured');
searchspace = eigenvec*trainvecspace;
oneimg = reshape(testvecspace(:,82), [imgrownum imgcolnum]);
imshow(uint8(oneimg))

for k = [2, 10, 20, 30, 50, 75, 100, 125, 150, 170]
    Ured = zeros(size(U));
    Ured(:,1:k) = U(:,1:k);
    
end
%%
toc;
