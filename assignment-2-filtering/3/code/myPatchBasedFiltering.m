function y = myPatchBasedFiltering(input_image)

y = nlfilter(input_image, [33,33], @(x) FirstAveraging(x, 10, 10));