%% MyMainScript
clear
clc
myNumOfColors = 200;
myColorScale = [ 0:1/(myNumOfColors-1):1 ; 0:1/(myNumOfColors-1):1 ; 0:1/(myNumOfColors-1):1 ];
filenames = {'../data/barbara.png', '../data/TEM.png', '../data/canyon.png', '../data/church.png', '../data/chestXray.png', '../results/a_foreground.png'};
nums = [1 2 3 5 6 7];

%% Q2 a
[image, mask, foreground] = myForegroundMask('../data/statue.png', 30);
f = figure('visible', 'off');
subplot(1,3,1), imagesc(image);
title('original image');
daspect ([1 1 1]);
colorbar;
subplot(1,3,2), imagesc(mask);
title('mask');
daspect ([1 1 1]);
colorbar;
subplot(1,3,3), imagesc(foreground);
title('foreground image');
daspect ([1 1 1]);
colorbar;
axis tight;
colormap gray;
saveas(f,'../results/a_all','png')
% saving only foreground
imwrite(foreground,'../results/a_foreground.png')


%% Q2b
for eg = 1:length(filenames)
    pth = filenames{eg};
    save_name = strcat('../results/b_', string(nums(eg)));
    [original, new] = myLinearContrastStretching(pth);
    f = figure('visible', 'off');
    if eg == 6
        colormap gray
    end
    axis tight;
    subplot(1,2,1), imagesc(original);
    title('original image');
    daspect ([1 1 1]);
    colorbar;
    subplot(1,2,2), imagesc(new);
    title('after linear contrast');
    daspect ([1 1 1]);       
    colorbar;
    
    saveas(f, save_name, 'png');
end

%% Q2c
for eg = 1:length(filenames)
    pth = filenames{eg};
    save_name = strcat('../results/c_', string(nums(eg)));
    [original, new] = myHE(pth);
    f = figure('visible', 'off');
    if eg == 6
        colormap gray
    end
    axis tight;
    subplot(1,2,1), imagesc(original);
    title('original image')
    daspect ([1 1 1]);
    colorbar;
    subplot(1,2,2), imagesc(new);
    title('histogram-equalised image')
    daspect ([1 1 1]);       
    colorbar;
    
    saveas(f, save_name, 'png');
end

%% Q2d
[ref_img, input_img, hm_img] = myHM('../data/retina.png', '../data/retinaRef.png');
f = figure('visible', 'off');
subplot(1,3,1), imagesc(ref_img);
title('reference image');
daspect ([1 1 1]);
colorbar;
subplot(1,3,2), imagesc(input_img);
title('input image');
daspect ([1 1 1]);
colorbar;
subplot(1,3,3), imagesc(hm_img);
title('histogram-matched image');
daspect ([1 1 1]);
colorbar;
axis tight;
saveas(f, '../results/d', 'png');


%% Q2e
filenames = {'../data/barbara.png', '../data/TEM.png', '../data/canyon.png', '../data/chestXray.png'};
nums = [1 2 3 6];
for eg = 1:length(filenames)
    pth = filenames{eg};
    for one_sided_window_size = [5, 20, 40]
        window_size = 2*one_sided_window_size+1;
        save_name = strcat('../results/e_', string(nums(eg)), '_', string(window_size), '_point2');
        [original, new] = myCLAHE(pth, one_sided_window_size);
        f = figure('visible', 'off');
        axis tight;
        subplot(1,2,1), imagesc(original);
        title('original image')
        daspect ([1 1 1]);
        colorbar;
        subplot(1,2,2), imagesc(new);
        t = strcat('CLAHE with N = ', string(window_size), ' and t = 0.2');
        title(t)
        daspect ([1 1 1]);     
        colorbar;    
        saveas(f, save_name, 'png');
    end
    
end

