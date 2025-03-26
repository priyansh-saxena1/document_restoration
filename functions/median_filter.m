function filtered_img = median_filter(img, window_size)
% MEDIAN_FILTER Applies median filtering to remove noise
%   filtered_img = median_filter(img, window_size)
%   
%   Parameters:
%   img - Input grayscale image
%   window_size - Size of the median filter window (default 3)
%
%   Returns:
%   filtered_img - Filtered image with reduced noise
    
    if nargin < 2
        window_size = 3;
    end
    
    % Apply median filter
    filtered_img = medfilt2(img, [window_size window_size]);
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(1,3,1); 
        imshow(img); 
        title('Original Image');
        
        subplot(1,3,2); 
        imshow(filtered_img); 
        title('Median Filtered');
        
        % Show difference (removed noise)
        subplot(1,3,3);
        diff_img = imabsdiff(img, filtered_img);
        imshow(diff_img, []); % [] auto-scales for better visibility
        title('Removed Noise');
        
        sgtitle(['Median Filter (Window: ' num2str(window_size) 'x' num2str(window_size) ')']);
    end
    
    % Show progress in command window
    fprintf('  Median filter applied with %dx%d window\n', window_size, window_size);
    fprintf('  Peak change in pixel values: %d\n', max(abs(double(filtered_img(:)) - double(img(:)))));
end
