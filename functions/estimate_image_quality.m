function [noise_level, blur_level, contrast_level] = estimate_image_quality(img)
% ESTIMATE_IMAGE_QUALITY Estimates noise, blur and contrast levels in an image
%   [noise_level, blur_level, contrast_level] = estimate_image_quality(img)
%
%   Parameters:
%   img - Input grayscale image
%
%   Returns:
%   noise_level - Estimated noise level (0-1)
%   blur_level - Estimated blur level (0-1)
%   contrast_level - Estimated contrast level (0-1)

    % Convert to double for processing
    img_double = double(img);
    
    % Apply Laplacian filter
    laplacian_kernel = [0 1 0; 1 -4 1; 0 1 0];
    filtered = imfilter(img_double, laplacian_kernel, 'replicate');
    
    % 1. NOISE ESTIMATION
    % Compute median absolute deviation (MAD)
    mad_value = median(abs(filtered(:) - median(filtered(:))));
    noise_sigma = mad_value / 0.6745;
    noise_level = min(1, noise_sigma / 50);
    
    % 2. BLUR ESTIMATION
    lap = abs(filtered);
    lap_var = var(lap(:));
    blur_level = min(1, max(0, 1 - (lap_var / 1000)));
    
    % 3. CONTRAST ESTIMATION
    [counts, ~] = histcounts(img, 256);
    cdf = cumsum(counts) / sum(counts);
    idx10 = find(cdf >= 0.1, 1, 'first');
    idx90 = find(cdf >= 0.9, 1, 'first');
    
    if isempty(idx10) || isempty(idx90)
        contrast_level = 0.5;
    else
        intensity_range = idx90 - idx10;
        contrast_level = min(1, max(0, intensity_range / 200));
    end
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(2,2,1); imshow(img); title('Image');
        subplot(2,2,2); imhist(img); title('Histogram');
        subplot(2,2,3);
        bar([noise_level, blur_level, contrast_level]);
        set(gca, 'xticklabel', {'Noise', 'Blur', 'Contrast'});
        title('Quality Metrics');
        axis([0.5 3.5 0 1]);
        
        subplot(2,2,4);
        text(0.1, 0.6, sprintf('Noise: %.2f\nBlur: %.2f\nContrast: %.2f', ...
             noise_level, blur_level, contrast_level), 'FontSize', 12);
        axis off;
        title('Quality Values');
    end
end
