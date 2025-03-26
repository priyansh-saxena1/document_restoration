function img = create_synthetic_document(height, width)
% CREATE_SYNTHETIC_DOCUMENT Create a synthetic document with text
%   img = create_synthetic_document(height, width)
%   
%   Parameters:
%   height - Image height (default 512)
%   width - Image width (default 512)
%
%   Returns:
%   img - Synthetic document image with degradation

    if nargin < 1, height = 512; end
    if nargin < 2, width = 512; end
    
    % Create blank image
    img = uint8(240 * ones(height, width));
    
    % Add some text
    text_lines = {
        'DOCUMENT IMAGE RESTORATION', 
        '', 
        'This is a synthetic document created', 
        'for testing document enhancement algorithms.', 
        '', 
        'It contains various types of text patterns',
        'that are common in document images:',
        '',
        '* Headers and titles',
        '* Body text in different sizes',
        '* Lists and bullet points',
        '',
        'The goal is to provide a test image',
        'that resembles a real document but',
        'doesn''t require any external datasets.',
        '',
        'MATLAB Code for Document Enhancement'
    };
    
    % Add text to image
    font_size = 14;
    img = insertText(img, [20, 20], text_lines, ...
                    'FontSize', font_size, ...
                    'TextColor', 'black', ...
                    'BoxOpacity', 0);
    
    % Add title with larger font
    img = insertText(img, [20, 20], 'DOCUMENT IMAGE RESTORATION', ...
                    'FontSize', font_size*1.5, ...
                    'TextColor', 'black', ...
                    'BoxOpacity', 0);
    
    % Convert back to grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Add degradation
    % 1. Add noise
    noise_sigma = 10;
    img = imnoise(img, 'gaussian', 0, (noise_sigma/255)^2);
    
    % 2. Add blur
    blur_kernel = fspecial('gaussian', [5 5], 1.5);
    img = imfilter(img, blur_kernel, 'replicate');
    
    % 3. Reduce contrast
    img = imadjust(img, [0.2, 0.8], [0.3, 0.7]);
    
    % 4. Add slight rotation
    img = imrotate(img, 1, 'bilinear', 'crop');
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        imshow(img);
        title('Synthetic Degraded Document');
    end
end
