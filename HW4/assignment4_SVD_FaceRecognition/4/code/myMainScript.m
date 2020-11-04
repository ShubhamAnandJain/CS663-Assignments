%% MyMainScript

tic;
%% Your code here
% Extracting Files
orldir = '../../../ORL';
%people =  dir(orldir);
%LOAD TRAINING DATA
imgrownum = 112;
imgcolnum = 92;
trainnumface =32;
trainnumimg =6;
totimg= 10;
kretain = 50;
trainvecspace = zeros(imgrownum*imgcolnum,trainnumface*trainnumimg);
testvecspace = zeros(imgrownum*imgcolnum,trainnumface*(totimg-trainnumimg));
for i = 1:trainnumface
    currsubfolderDir = append(orldir,'/s',num2str(i));
    myFiles = dir(fullfile(currsubfolderDir,'*.pgm'));
    for k = 1:totimg%length(myFiles)
        baseFileName = myFiles(k).name;
        fullFileName = fullfile(currsubfolderDir, baseFileName);
        currface = imread(fullFileName);
        %disp(size(currface))
        currcolvec = reshape(currface,[imgrownum*imgcolnum 1]);
        %disp(size(currcolvec))
        if k <= trainnumimg
            trainvecspace(:,(i-1)*trainnumimg+k)=currcolvec;
        else
            testvecspace(:,(i-1)*(totimg-trainnumimg)+k-trainnumimg)=currcolvec;
        end
        %imshow(img)
    end
end
%%
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
%covmatrix = facevecspace*facevecspace'./(trainnumface*trainnumimg-1);
[U,S,V] = svd(trainvecspace,'econ');
%Sred = S(1:kretain,1:kretain);
Ured = zeros(size(U));
Ured(:,1:kretain) = U(:,1:kretain);
searchspace = Ured'*trainvecspace;
%redrep = U*S*V';

%facevecspace = U*S*V'.
% USV' = imspace
%US = facevecspace;
%% Search
%[minValue,closestIndex] = min(abs(bsxfun(@minus,A, V')))
queryimg = Ured'*(testvecspace(:,9)-meanvec);
[idx D] = knnsearch(searchspace',queryimg');
disp(idx)
disp(D)
%%
oneimg = reshape(meanvec, [imgrownum imgcolnum]);
imshow(uint8(oneimg))
%%
toc;

%% References
% https://in.mathworks.com/matlabcentral/answers/166629-is-there-any-way-to-list-all-folders-only-in-the-level-directly-below-a-selected-directory
% https://in.mathworks.com/matlabcentral/answers/341843-load-files-from-relative-path