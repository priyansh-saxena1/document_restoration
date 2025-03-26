function enhanced = histogram_equalization(img)
% HISTOGRAM_EQUALIZATION Applies histogram equalization for contrast enhancement
%   enhanced = histogram_equalization(img)
%   
%   Parameters:
%   img - Input grayscale image
%
%   Returns:
%   enhanced - Contrast enhanced image

    % Apply histogram equalization
    enhanced = histeq(img);
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(2,2,1); imshow(img); title('Original Image');
        subplot(2,2,2); imshow(enhanced); title('Enhanced Image');
        subplot(2,2,3); imhist(img); title('Original Histogram');
        subplot(2,2,4); imhist(enhanced); title('Enhanced Histogram');
    end
end
