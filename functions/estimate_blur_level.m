function blur_level = estimate_blur_level(img)
% ESTIMATE_BLUR_LEVEL Estimates blur level in document image
%   blur_level = estimate_blur_level(img)

    % Convert to double for processing
    img_double = double(img);
    
    % Apply Laplacian for edge detection
    laplacian_kernel = [0 1 0; 1 -4 1; 0 1 0];
    lap = abs(imfilter(img_double, laplacian_kernel, 'replicate'));
    
    % Calculate variance of Laplacian (lower variance = more blur)
    lap_var = var(lap(:));
    
    % Normalize to [0,1] range (higher value = more blur)
    blur_level = min(1, max(0, 1 - (lap_var / 1000)));
end
