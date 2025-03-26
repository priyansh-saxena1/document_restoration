function noise_level = estimate_noise_level(img)
% ESTIMATE_NOISE_LEVEL Estimates noise level in document image
%   noise_level = estimate_noise_level(img)

    % Calculate noise using median absolute deviation
    img_double = double(img);
    
    % Apply Laplacian filter to detect noise
    laplacian_kernel = [0 1 0; 1 -4 1; 0 1 0];
    filtered = imfilter(img_double, laplacian_kernel, 'replicate');
    
    % Compute median absolute deviation (MAD)
    mad_value = median(abs(filtered(:) - median(filtered(:))));
    
    % Scale to get noise estimate
    noise_sigma = mad_value / 0.6745;
    
    % Normalize to [0,1] range
    noise_level = min(1, noise_sigma / 50);
end
