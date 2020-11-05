function [trainvecspace, testvecspace, imgrownum, imgcolnum] = yaledataloader()
%Directory Location
yaledir = '../../../CroppedYale';
%people =  dir(orldir);
%LOAD TRAINING DATA
imgrownum = 192;
imgcolnum = 168;
trainnumface =39;
totimg= [];
trainnumimg =40;
%testnumimg= totimg-trainnumimg;
trainvecspace = zeros(imgrownum*imgcolnum,trainnumface*trainnumimg);
testvecspace = zeros(imgrownum*imgcolnum,trainnumface*(totimg-trainnumimg));
for i = 1:trainnumface
    if i ~= 14
        if i < 10
            currsubfolderDir = append(yaledir,'/yaleB0',num2str(i));
        else
            currsubfolderDir = append(yaledir,'/yaleB',num2str(i));
        end
        myFiles = dir(fullfile(currsubfolderDir,'*.pgm'));
        totimg = size(myFiles,1);
        %disp(totimg)
        for k = 1:totimg%length(myFiles)
            baseFileName = myFiles(k).name;
            fullFileName = fullfile(currsubfolderDir, baseFileName);
            currface = imread(fullFileName);
            %disp(size(currface))
            currcolvec = reshape(currface,[size(currface,1)*size(currface,2) 1]);
            %disp(size(currcolvec))
            if k <= trainnumimg
                trainvecspace(:,(i-1)*trainnumimg+k)=currcolvec;
            else
                testvecspace(:,(i-1)*(totimg-trainnumimg)+k-trainnumimg)=currcolvec;
            end
            %imshow(img)
        end
    end
end
trainvecspace( :, all(~trainvecspace,1) ) = [];
testvecspace( :, all(~testvecspace,1) ) = [];