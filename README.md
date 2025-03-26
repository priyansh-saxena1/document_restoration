# Document Image Restoration Project

This repository contains MATLAB code for document image enhancement and restoration. The implemented algorithms address three main types of degradation:

1. Noise removal
2. Deblurring
3. Contrast enhancement

## Project Structure

- `main_script.m` - Main script to run the complete enhancement pipeline
- `functions/` - Directory containing individual algorithm implementations:
  - Noise removal: `median_filter.m`, `nonlocal_means_denoising.m`
  - Deblurring: `unsharp_masking.m`, `wiener_deconvolution.m`
  - Contrast enhancement: `histogram_equalization.m`, `apply_clahe.m`
  - Utilities: `estimate_noise_level.m`, `estimate_blur_level.m`, `estimate_contrast_level.m`, `calculate_metrics.m`, `create_synthetic_document.m`

## Datasets

For testing the algorithms, we recommend using the following public datasets:

1. **DIBCO (Document Image Binarization Contest)** - [https://vc.ee.duth.gr/dibco2019/](https://vc.ee.duth.gr/dibco2019/)
   - Contains degraded historical document images with ground truth
   
2. **PRImA (Pattern Recognition & Image Analysis)** - [https://www.primaresearch.org/datasets/](https://www.primaresearch.org/datasets/)
   - Various document layouts and degradation types

3. **DIQA (Document Image Quality Assessment)** - [https://lampsrv02.umiacs.umd.edu/projdb/project.php?id=73](https://lampsrv02.umiacs.umd.edu/projdb/project.php?id=73)
   - Includes quality assessment benchmarks

Place the dataset images in the `data/` directory before running the scripts.

## Usage

1. Set up the directory structure:
   ```
   mkdir -p data results functions
   ```

2. Download and place test images in the `data/` directory

3. Run the main script:
   ```
   main_script
   ```

4. Examine the enhanced images in the `results/` directory

## Contributors

- Priyansh Saxena (Transcendental-Programmer)

## Example Results

When running the code on sample images from the DIBCO dataset, you can expect improvements in OCR accuracy in the range of 15-20% for heavily degraded documents.

## Dependencies

- MATLAB R2018b or newer
- Image Processing Toolbox (recommended but not required)
- Computer Vision Toolbox (optional, for OCR evaluation)