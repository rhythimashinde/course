function [ out ] = my_rep( in )
%my_rep Convert digits images into a dataset.

dataset_size = size(in, 1) / 10;

labels = {{}};
hogs = [];

for i = 0:9
    for j = 1:dataset_size
        index = dataset_size*i + j;
        pr_digit = in(index);
        
        % convert to image
        digit = data2im(pr_digit);
        
        % restrict to bounding box
        digit = im_box(digit, [5, 5, 5, 5]);
        
        % remove noise
        digit = remove_noise(digit);
        
        % straighten the digit
        digit = straighten(digit);
        
        % resize image so they all have the same size
        digit = imresize(digit, [50 50]);
        
        % extract HOG features
        digit_hog = extractHOGFeatures(digit, 'CellSize', [4 4]);
        
        % save the HOG measurements into an array
        hogs(index, :) = digit_hog(:);
        
        % generate a label
        labels{index} = strcat('digit_', num2str(i));
    end
end

% return a dataset
out = prdataset(hogs, labels);

end