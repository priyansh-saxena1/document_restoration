function enhanced = apply_clahe(img, clip_limit, tile_size)
% APPLY_CLAHE Applies Contrast Limited Adaptive Histogram Equalization
%   enhanced = apply_clahe(img, clip_limit, tile_size)
%   
%   Parameters:
%   img - Input grayscale image
%   clip_limit - Contrast limit (default 2.0)
%   tile_size - Size of local region [rows cols] (default [8 8])
%
%   Returns:
%   enhanced - Contrast enhanced image

    if nargin < 2, clip_limit = 2.0; end
    if nargin < 3, tile_size = [8 8]; end
    
    % Using MATLAB's built-in CLAHE implementation
    % Image Processing Toolbox required
    enhanced = adapthisteq(img, 'ClipLimit', clip_limit, 'NumTiles', tile_size);
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(2,2,1); imshow(img); title('Original Image');
        subplot(2,2,2); imshow(enhanced); title('CLAHE Enhanced');
        subplot(2,2,3); imhist(img); title('Original Histogram');
        subplot(2,2,4); imhist(enhanced); title('Enhanced Histogram');
    end
end
