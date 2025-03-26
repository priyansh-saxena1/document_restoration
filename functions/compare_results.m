function compare_results(before, after, operation_name)
% COMPARE_RESULTS Displays before and after images with difference
%   compare_results(before, after, operation_name)
%
%   Parameters:
%   before - Input image before operation
%   after - Result image after operation
%   operation_name - Name of the operation (default 'Operation')

    if nargin < 3
        operation_name = 'Operation';
    end
    
    % Create figure
    figure('Name', ['Before/After: ' operation_name], 'Position', [100 100 900 300]);
    
    % Display before image
    subplot(1,3,1);
    imshow(before);
    title('Before');
    
    % Display after image
    subplot(1,3,2);
    imshow(after);
    title('After');
    
    % Display difference
    subplot(1,3,3);
    diff_img = imabsdiff(before, after);
    imshow(diff_img, []);  % [] auto-scales intensity for better visualization
    title('Difference');
    
    % Add overall title
    sgtitle(operation_name);
    
    % Save comparison if output directory exists
    if exist('results', 'dir')
        filename = ['results/comparison_' strrep(lower(operation_name), ' ', '_') '.png'];
        saveas(gcf, filename);
    end
end
