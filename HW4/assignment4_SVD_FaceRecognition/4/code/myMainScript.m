%% MyMainScript

tic;
%% Your code here
% Extracting Files
% orldir = '../../../ORL';
% %people =  dir(orldir);
% %LOAD TRAINING DATA
% imgrownum = 112;
% imgcolnum = 92;
% trainnumface =32;
% trainnumimg =6;
% totimg= 10;
% kretain = 50;
% trainvecspace = zeros(imgrownum*imgcolnum,trainnumface*trainnumimg);
% testvecspace = zeros(imgrownum*imgcolnum,trainnumface*(totimg-trainnumimg));
% for i = 1:trainnumface
%     currsubfolderDir = append(orldir,'/s',num2str(i));
%     myFiles = dir(fullfile(currsubfolderDir,'*.pgm'));
%     for k = 1:totimg%length(myFiles)
%         baseFileName = myFiles(k).name;
%         fullFileName = fullfile(currsubfolderDir, baseFileName);
%         currface = imread(fullFileName);
%         %disp(size(currface))
%         currcolvec = reshape(currface,[imgrownum*imgcolnum 1]);
%         %disp(size(currcolvec))
%         if k <= trainnumimg
%             trainvecspace(:,(i-1)*trainnumimg+k)=currcolvec;
%         else
%             testvecspace(:,(i-1)*(totimg-trainnumimg)+k-trainnumimg)=currcolvec;
%         end
%         %imshow(img)
%     end
% end

[trainvecspace, testvecspace, trainnumimg, testnumimg] = orldataloader();
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
[U,S,V] = svd(trainvecspace,'econ');

%%

%Sred = S(1:kretain,1:kretain);
kretain = 20;
Ured = zeros(size(U));
Ured(:,1:kretain) = U(:,1:kretain);
eigenvec = normc(Ured');
searchspace = eigenvec*trainvecspace;

%%
for k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170]
    Ured = zeros(size(U));
    Ured(:,1:k) = U(:,1:k);
    eigenvec = normc(Ured');
    searchspace = eigenvec*trainvecspace;
    toterr=0;
    dist = 0
    for i = 1:size(testvecspace,2)
        queryimg = eigenvec*(testvecspace(:,i)-meanvec);
        [idx,Dist] = knnsearch(searchspace',queryimg');
        if floor((idx-1)/trainnumimg) ~= floor((i-1)/(testnumimg))
            toterr = toterr+1;
        end
    end
    disp(toterr)
end
%%
%redrep = U*S*V';

%facevecspace = U*S*V'.
% USV' = imspace
%US = facevecspace;
%% Search
%[minValue,closestIndex] = min(abs(bsxfun(@minus,A, V')))
queryimg = eigenvec*(testvecspace(:,9)-meanvec);
[idx,Dist] = knnsearch(searchspace',queryimg');
disp(idx)
disp(Dist)
%% Calculate error
toterr=0;
for i = 1:size(testvecspace,2)
    queryimg = eigenvec*(testvecspace(:,i)-meanvec);
    [idx,Dist] = knnsearch(searchspace',queryimg');
    if floor((idx-1)/trainnumimg) ~= floor((i-1)/(testnumimg))
        toterr = toterr+1;
    end
end
disp(toterr)
%%
oneimg = reshape(meanvec, [imgrownum imgcolnum]);
imshow(uint8(oneimg))
%%
toc;

%% References
% https://in.mathworks.com/matlabcentral/answers/166629-is-there-any-way-to-list-all-folders-only-in-the-level-directly-below-a-selected-directory
% https://in.mathworks.com/matlabcentral/answers/341843-load-files-from-relative-path