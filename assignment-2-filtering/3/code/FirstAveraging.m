function y = FirstAveraging(input_image, h, gaussian_sigma)

gaussian_patch = zeros(9,9);
gauss_normal = 0;
for i = 1:9
    for j = 1:9
        exponent = ((i-5).^2 + (j-5).^2)./(2*gaussian_sigma.^2);
        to_add = exp(-exponent);
        gaussian_patch(i,j) = to_add;
        gauss_normal = gauss_normal + to_add;
    end
end
for i = 1:9
    for j = 1:9
        gaussian_patch(i,j) = gaussian_patch(i,j) / gauss_normal;
    end
end

centerX = floor((size(input_image,1)+1)/2);
centerY = floor((size(input_image,2)+1)/2);

centerPatch = input_image(centerX-4:centerX+4, centerY-4:centerY+4);

weightMat = zeros(25,25);

for i = centerX-12:centerX+12
    for j = centerY-12: centerY+12
        
        currPatch = input_image(i-4:i+4, j-4:j+4);
        patchDifference = (centerPatch-currPatch).^2;
        patchDifference = patchDifference .* gaussian_patch;
        totalSum = sum(patchDifference, 'all');
        weightMat(13+centerX-i, 13+centerY-j) = exp(-totalSum/(h.^2));
    end
end

totalWeight = sum(weightMat, 'all');
weightMat = weightMat ./ totalWeight;

intensityContribution = input_image(centerX-12:centerX+12, centerY-12:centerY+12) .* weightMat;
y = sum(intensityContribution, 'all');
