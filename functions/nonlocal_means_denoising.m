function denoised = nonlocal_means_denoising(img, h, patchSize, searchSize)
% NONLOCAL_MEANS_DENOISING Applies Non-Local Means algorithm for denoising
%   denoised = nonlocal_means_denoising(img, h, patchSize, searchSize)
%   
%   Parameters:
%   img - Input grayscale image
%   h - Filtering parameter (default 10)
%   patchSize - Size of comparison patches (default 7)
%   searchSize - Size of search neighborhood (default 21)
%
%   Returns:
%   denoised - Denoised image

    if nargin < 2, h = 10; end
    if nargin < 3, patchSize = 7; end
    if nargin < 4, searchSize = 21; end
    
    % Using MATLAB's built-in Non-Local Means
    % Image Processing Toolbox required
    denoised = imnlmfilt(img, 'DegreeOfSmoothing', h, ...
                        'ComparisonWindowSize', patchSize, ...
                        'SearchWindowSize', searchSize);
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(1,2,1); imshow(img); title('Original Image');
        subplot(1,2,2); imshow(denoised); title('NLM Denoised');
    end
end
