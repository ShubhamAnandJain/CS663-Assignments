

tic;
%%
clear;
[trainvecspace, testvecspace, trainnumimg, testnumimg, imgrownum, imgcolnum] = orldataloader();
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
[U,S,V] = svd(trainvecspace,'econ');

%% Plot eigen vectors
array = [];
for val = 1:25
    array = [array S(val,val)];
end
figure
plot(array)
title('Top 25 eigenvalues')
xlabel('Eigen Value number (descending)')
ylabel('Eigen Value')
%% Reconstruction of Images
% for k = [2, 10, 20, 30, 50, 75, 100, 125, 150, 170]
for k = [2, 10, 20, 30, 50, 75, 100, 125, 150, 170]
    Ured = zeros(size(U));
    Ured(:,1:k) = U(:,1:k);
    image = Ured*S*V';
    image = bsxfun(@plus,image,meanvec);
    oneimg = reshape(image(:,82), [imgrownum imgcolnum]);
    figure
    imshow(uint8(oneimg))
    var = [];
    var = append(num2str(k),' eigenvalues retained');
    title(var)
end
%%
toc;
