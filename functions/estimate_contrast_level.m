function contrast_level = estimate_contrast_level(img)
% ESTIMATE_CONTRAST_LEVEL Estimates contrast level in document image
%   contrast_level = estimate_contrast_level(img)

    % Calculate histogram
    [counts, bins] = histcounts(img, 256);
    
    % Calculate cumulative distribution
    cdf = cumsum(counts) / sum(counts);
    
    % Find intensity values at 10% and 90% of CDF
    idx10 = find(cdf >= 0.1, 1, 'first');
    idx90 = find(cdf >= 0.9, 1, 'first');
    
    % Calculate relative contrast
    if isempty(idx10) || isempty(idx90)
        contrast_level = 0.5;
    else
        intensity_range = idx90 - idx10;
        contrast_level = min(1, max(0, intensity_range / 200));
    end
end
