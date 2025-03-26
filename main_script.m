%% Document Image Enhancement Pipeline
% This script demonstrates a complete document image enhancement pipeline
% with noise removal, deblurring, and contrast enhancement.

clear all; close all; clc;

addpath('functions');

%% Load and display degraded document image
fprintf('Loading degraded document image...\n');

% You can use one of these datasets:
% 1. PRImA dataset: http://www.primaresearch.org/datasets/
% 2. DIBCO dataset: https://vc.ee.duth.gr/dibco2019/
% 3. DIQA dataset: https://lampsrv02.umiacs.umd.edu/projdb/project.php?id=73

% For this example, we'll use a sample from DIBCO dataset
% Download and place in the 'data' folder before running
try
    img = imread('data/dibco_sample.png');
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
catch
    % If external dataset not available, create synthetic degraded document
    fprintf('Dataset not found, creating synthetic degraded document...\n');
    img = create_synthetic_document(512, 256);
end

% Create figures for displaying results
figure('Name', 'Document Enhancement Pipeline', 'Position', [100 100 1000 600]);

% Display original image
subplot(2,3,1);
imshow(img);
title('Original Degraded Document');

%% Analyze image degradation
fprintf('Analyzing image degradation...\n');
[noise_level, blur_level, contrast_level] = estimate_image_quality(img);

fprintf('Estimated noise level: %.2f\n', noise_level);
fprintf('Estimated blur level: %.2f\n', blur_level);
fprintf('Estimated contrast level: %.2f\n', contrast_level);

%% Step 1: Noise Removal
fprintf('Performing noise removal...\n');
if noise_level > 0.3
    % Use Non-Local Means for high noise
    denoised = nonlocal_means_denoising(img, 10, 7, 21);
    noise_method = 'Non-Local Means';
else
    % Use Median Filter for lighter noise
    denoised = median_filter(img, 3);
    noise_method = 'Median Filter';
end

% Display denoised image
subplot(2,3,2);
imshow(denoised);
title(['Denoised (' noise_method ')']);

% Save intermediary result for noise removal
if ~exist('results', 'dir')
    mkdir('results');
end
imwrite(denoised, 'results/step1_denoised.png');

%% Step 2: Deblurring
fprintf('Performing deblurring...\n');
if blur_level > 0.5
    % Use Wiener filter for higher blur levels
    deblurred = wiener_deconvolution(denoised, 0.01);
    blur_method = 'Wiener Filter';
else
    % Use unsharp masking for mild blur
    deblurred = unsharp_masking(denoised, 1.5, 0.5);
    blur_method = 'Unsharp Masking';
end

% Display deblurred image
subplot(2,3,3);
imshow(deblurred);
title(['Deblurred (' blur_method ')']);

% Save intermediary result for deblurring
imwrite(deblurred, 'results/step2_deblurred.png');

%% Step 3: Contrast Enhancement
fprintf('Enhancing contrast...\n');
if contrast_level < 0.4
    % Use CLAHE for poor local contrast
    enhanced = apply_clahe(deblurred, 2.0, [8 8]);
    contrast_method = 'CLAHE';
else
    % Use histogram equalization for global contrast issues
    enhanced = histogram_equalization(deblurred);
    contrast_method = 'Hist Equalization';
end

% Display contrast enhanced image
subplot(2,3,4);
imshow(enhanced);
title(['Enhanced Contrast (' contrast_method ')']);

% Save intermediary result for contrast enhancement
imwrite(enhanced, 'results/step3_enhanced.png');

%% Optional: Binarization for OCR improvement
binarized = imbinarize(enhanced, graythresh(enhanced));

% Display binarized image
subplot(2,3,5);
imshow(binarized);
title('Binarized for OCR');

% Save intermediary result for binarization
imwrite(binarized, 'results/step4_binarized.png');

%% Calculate improvement metrics
[psnr_val, ssim_val] = calculate_metrics(img, enhanced);
fprintf('Enhancement complete with PSNR: %.2f dB, SSIM: %.2f\n', psnr_val, ssim_val);

%% Optional: Apply OCR and evaluate improvement
if exist('ocr', 'file') % Check if OCR Toolbox is available
    fprintf('Performing OCR on original and enhanced documents...\n');
    original_ocr = ocr(img);
    enhanced_ocr = ocr(enhanced);
    binarized_ocr = ocr(binarized);
    
    % Display OCR results
    subplot(2,3,6);
    text_img = insertText(ones(size(img)), [10 10], ...
        sprintf('OCR Confidence:\nOriginal: %.1f%%\nEnhanced: %.1f%%\nBinarized: %.1f%%', ...
        mean(original_ocr.WordConfidences)*100, mean(enhanced_ocr.WordConfidences)*100, ...
        mean(binarized_ocr.WordConfidences)*100), ...
        'FontSize', 12, 'BoxOpacity', 0);
    imshow(text_img);
    title('OCR Improvement');
    
    % Save OCR results to text file
    fid = fopen('results/ocr_results.txt', 'w');
    fprintf(fid, 'Original Document OCR:\n%s\n\n', original_ocr.Text);
    fprintf(fid, 'Enhanced Document OCR:\n%s\n\n', enhanced_ocr.Text);
    fprintf(fid, 'Binarized Document OCR:\n%s\n', binarized_ocr.Text);
    fclose(fid);
end

%% Create detailed visualization of all steps
figure('Name', 'Detailed Enhancement Steps', 'Position', [200 200 1200 800]);

% Original image and histogram
subplot(4,3,1);
imshow(img);
title('Original Document');

subplot(4,3,2);
imhist(img);
title('Original Histogram');

subplot(4,3,3);
text(0.1, 0.5, sprintf('Noise Level: %.2f\nBlur Level: %.2f\nContrast Level: %.2f', ...
    noise_level, blur_level, contrast_level), 'FontSize', 10);
axis off;
title('Degradation Analysis');

% Denoised image and histogram
subplot(4,3,4);
imshow(denoised);
title(['Step 1: ' noise_method]);

subplot(4,3,5);
imhist(denoised);
title('After Denoising Histogram');

subplot(4,3,6);
imshow(imabsdiff(img, denoised), []);
title('Removed Noise (Difference)');

% Deblurred image and histogram
subplot(4,3,7);
imshow(deblurred);
title(['Step 2: ' blur_method]);

subplot(4,3,8);
imhist(deblurred);
title('After Deblurring Histogram');

subplot(4,3,9);
imshow(imabsdiff(denoised, deblurred), []);
title('Sharpening Effect (Difference)');

% Enhanced image and histogram
subplot(4,3,10);
imshow(enhanced);
title(['Step 3: ' contrast_method]);

subplot(4,3,11);
imhist(enhanced);
title('Final Enhanced Histogram');

subplot(4,3,12);
imshow(imabsdiff(deblurred, enhanced), []);
title('Contrast Enhancement (Difference)');

%% Save results and display completion message
fprintf('Saving results...\n');
imwrite(enhanced, 'results/final_enhanced.png');
imwrite(binarized, 'results/final_binarized.png');

% Save the detailed visualization
saveas(gcf, 'results/enhancement_steps_visualization.png');

fprintf('Document enhancement complete! All results saved to the "results" folder.\n');
