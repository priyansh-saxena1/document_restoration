function display_image_info(img, title_str)
% DISPLAY_IMAGE_INFO Displays an image with its histogram and key statistics
%   display_image_info(img, title_str)
%
%   Parameters:
%   img - Input grayscale image
%   title_str - Title string for the plot

    if nargin < 2
        title_str = 'Image Information';
    end
    
    % Create figure with 3 subplots
    figure('Name', title_str);
    
    % Display image
    subplot(1,3,1);
    imshow(img);
    title('Image');
    
    % Display histogram
    subplot(1,3,2);
    imhist(img);
    title('Histogram');
    
    % Display statistics
    subplot(1,3,3);
    axis off;
    
    % Calculate statistics
    min_val = min(img(:));
    max_val = max(img(:));
    mean_val = mean(img(:));
    std_val = std(double(img(:)));
    
    % Calculate entropy (measure of information content)
    entropy_val = entropy(img);
    
    % Calculate dynamic range
    dynamic_range = max_val - min_val;
    
    % Display statistics as text
    stats_text = sprintf(['Min: %d\nMax: %d\nMean: %.2f\nStd Dev: %.2f\n' ...
                         'Dynamic Range: %d\nEntropy: %.2f\n'], ...
                         min_val, max_val, mean_val, std_val, ...
                         dynamic_range, entropy_val);
    
    text(0.1, 0.5, stats_text, 'FontSize', 12);
    title('Statistics');
    
    % Add overall title
    sgtitle(title_str);
end
