function sharpened = unsharp_masking(img, amount, sigma)
% UNSHARP_MASKING Applies unsharp masking for image sharpening
%   sharpened = unsharp_masking(img, amount, sigma)
%   
%   Parameters:
%   img - Input grayscale image
%   amount - Sharpening strength (default 1.5)
%   sigma - Gaussian blur sigma (default 0.5)
%
%   Returns:
%   sharpened - Sharpened image

    if nargin < 2, amount = 1.5; end
    if nargin < 3, sigma = 0.5; end
    
    % Create blurred version
    blurred = imgaussfilt(img, sigma);
    
    % Create mask: original - blurred
    mask = double(img) - double(blurred);
    
    % Add weighted mask to original
    sharpened = double(img) + amount * mask;
    
    % Clip values to valid range
    sharpened = uint8(max(0, min(255, sharpened)));
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(2,2,1); imshow(img); title('Original Image');
        subplot(2,2,2); imshow(blurred); title('Blurred Image');
        subplot(2,2,3); imshow(mask, []); title('Unsharp Mask');
        subplot(2,2,4); imshow(sharpened); title('Sharpened Image');
    end
end
