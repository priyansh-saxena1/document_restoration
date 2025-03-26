function [psnr_val, ssim_val] = calculate_metrics(original, enhanced, reference)
% CALCULATE_METRICS Calculates image quality metrics
%   [psnr_val, ssim_val] = calculate_metrics(original, enhanced, reference)
%
%   Parameters:
%   original - Original degraded image
%   enhanced - Enhanced image
%   reference - Clean reference image (optional)
%
%   Returns:
%   psnr_val - Peak Signal-to-Noise Ratio
%   ssim_val - Structural Similarity Index

    % If reference is not provided, compare enhanced to original
    if nargin < 3
        reference = original;
    end
    
    % Calculate PSNR and SSIM using built-in functions
    % Image Processing Toolbox required
    psnr_val = psnr(enhanced, reference);
    ssim_val = ssim(enhanced, reference);
    
    % Display visualization if no output arguments
    if nargout == 0
        figure;
        subplot(1,3,1); imshow(original); title('Original');
        subplot(1,3,2); imshow(enhanced); title('Enhanced');
        subplot(1,3,3); imshow(reference); title('Reference');
        
        sgtitle(sprintf('PSNR: %.2f dB, SSIM: %.2f', psnr_val, ssim_val));
    end
end
