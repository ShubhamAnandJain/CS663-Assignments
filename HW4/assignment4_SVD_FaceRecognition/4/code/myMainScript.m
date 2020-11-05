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
clear;
[trainvecspace, testvecspace, trainnumimg, testnumimg, imgrownum, imgcolnum] = orldataloader();
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
    %totdist = 0;
    for i = 1:size(testvecspace,2)
        queryimg = eigenvec*(testvecspace(:,i)-meanvec);
        [idx,Dist] = knnsearch(searchspace',queryimg');
        if floor((idx-1)/trainnumimg) ~= floor((i-1)/(testnumimg))
            toterr = toterr+1;
        end
        %totdist = totdist + Dist;
    end
    disp(toterr)
    %disp(totdist)
end
%%
%redrep = U*S*V';

%facevecspace = U*S*V'.
% USV' = imspace
%US = facevecspace;
%% Search
%[minValue,closestIndex] = min(abs(bsxfun(@minus,A, V')))
%queryimg = eigenvec*(testvecspace(:,9)-meanvec);
%[idx,Dist] = knnsearch(searchspace',queryimg');
%disp(idx)
%disp(Dist)
%%
clear;
[trainvecspace, testvecspace, imgrownum, imgcolnum, corrtraintag, corrtesttag] = yaledataloader();
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
testvecspace = bsxfun(@minus,testvecspace,meanvec);
[U,S,V] = svd(trainvecspace,'econ');
%%
startk = 4;
%for k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000]
for k = [1000]
    Ured = zeros(size(U));
    %Ured(:,1:k) = U(:,1:k);
    Ured(:,startk:startk+k-1) = U(:,startk:startk+k-1);
    eigenvec = normc(Ured');
    searchspace = eigenvec*trainvecspace;
    toterr=0;
    %totdist = 0;
    
    queryimgs = eigenvec*testvecspace;
    [idx, Dist] = knnsearch(searchspace',queryimgs');
    
    for i = 1:size(testvecspace,2)
        %queryimg = eigenvec*(testvecspace(:,i)-meanvec);
        %disp(idx(i))
        %[idx,Dist] = knnsearch(searchspace',queryimg');
        if corrtesttag(i) ~= corrtraintag(idx(i))
            toterr=toterr +1;
        end
    end
    disp(toterr)
        %if floor((idx-1)/trainnumimg) ~= floor((i-1)/(testnumimg))
        %    toterr = toterr+1;
        %end
        %totdist = totdist + Dist;
    %end
    %disp(toterr)
    %disp(totdist)
end
%% To view output
trial = Ured*searchspace*V';
%%
oneimg = reshape(trial(:,82), [imgrownum imgcolnum]);
imshow(uint8(oneimg))
%%
toc;
% B18 -63
% B17 - 63
% B16 - 62
% B15 - 63
% B13 - 60
% B12 - 60
% B11 - 60
%% References
% https://in.mathworks.com/matlabcentral/answers/166629-is-there-any-way-to-list-all-folders-only-in-the-level-directly-below-a-selected-directory
% https://in.mathworks.com/matlabcentral/answers/341843-load-files-from-relative-path
% https://in.mathworks.com/matlabcentral/answers/40018-delete-zeros-rows-and-columns