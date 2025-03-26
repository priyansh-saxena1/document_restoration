function deblurred = wiener_deconvolution(img, K, PSF)
% WIENER_DECONVOLUTION Applies Wiener deconvolution for deblurring
%   deblurred = wiener_deconvolution(img, K, PSF)
%   
%   Parameters:
%   img - Input grayscale image
%   K - Noise to signal power ratio (default 0.01)
%   PSF - Point Spread Function (optional, estimated if not provided)
%
%   Returns:
%   deblurred - Deblurred image

    if nargin < 2, K = 0.01; end
    
    % If PSF not provided, estimate a simple blur kernel
    if nargin < 3
        PSF_size = 5;
        PSF = fspecial('gaussian', [PSF_size PSF_size], 1.5);
    end
    
    % Apply Wiener deconvolution
    deblurred = deconvwnr(img, PSF, K);
    
    % Display visualization if no output argument
    if nargout == 0
        figure;
        subplot(1,3,1); imshow(img); title('Blurred Image');
        subplot(1,3,2); imshow(PSF, []); title('PSF (Blur Kernel)');
        subplot(1,3,3); imshow(deblurred); title('Deblurred Image');
    end
end
