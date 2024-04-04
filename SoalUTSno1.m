% Load image 01
input_image_01 = imread('image 01.png');

% Convert to grayscale if input image is RGB
if size(input_image_01, 3) == 3
    input_image_01 = rgb2gray(input_image_01);
end

% Normalize the image
input_image_01 = double(input_image_01) / 255;

% Define the masks
mask_a = 1/16 * [1,2,1; 2,4,2; 1,2,1];
mask_b = [0,-1,0; -1,4,-1; 0,-1,0];

% Perform convolution for image 01
output_image_01_a = my_convolution(input_image_01, mask_a);
output_image_01_b = my_convolution(input_image_01, mask_b);

% Load image 02
input_image_02 = imread('image 02.jpg');

% Convert to grayscale if input image is RGB
if size(input_image_02, 3) == 3
    input_image_02 = rgb2gray(input_image_02);
end

% Normalize the image
input_image_02 = double(input_image_02) / 255;

% Perform convolution for image 02
output_image_02_a = my_convolution(input_image_02, mask_a);
output_image_02_b = my_convolution(input_image_02, mask_b);

% Load image 03
input_image_03 = imread('image 03.jpg');

% Convert to grayscale if input image is RGB
if size(input_image_03, 3) == 3
    input_image_03 = rgb2gray(input_image_03);
end

% Normalize the image
input_image_03 = double(input_image_03) / 255;

% Perform convolution for image 03
output_image_03_a = my_convolution(input_image_03, mask_a);
output_image_03_b = my_convolution(input_image_03, mask_b);

% Show the results for image 01
figure;
subplot(2, 3, 1);
imshow(input_image_01);
title('Input Image 01');

subplot(2, 3, 2);
imshow(output_image_01_a);
title('Convolution with Mask A');

subplot(2, 3, 3);
imshow(output_image_01_b);
title('Convolution with Mask B');

% Show the results for image 02
subplot(2, 3, 4);
imshow(input_image_02);
title('Input Image 02');

subplot(2, 3, 5);
imshow(output_image_02_a);
title('Convolution with Mask A');

subplot(2, 3, 6);
imshow(output_image_02_b);
title('Convolution with Mask B');

% Show the results for image 03
figure;
subplot(2, 3, 1);
imshow(input_image_03);
title('Input Image 03');

subplot(2, 3, 2);
imshow(output_image_03_a);
title('Convolution with Mask A');

subplot(2, 3, 3);
imshow(output_image_03_b);
title('Convolution with Mask B');

function output_image = my_convolution(input_image, mask)
    [image_height, image_width, num_channels] = size(input_image);
    [mask_height, mask_width] = size(mask);
    
    % Initialize output image
    output_image = zeros(image_height, image_width, num_channels);
    
    % Pad input image
    pad_height = floor(mask_height / 2);
    pad_width = floor(mask_width / 2);
    padded_image = padarray(input_image, [pad_height, pad_width], 'replicate');
    
    % Perform convolution
    for y = 1:image_height
        for x = 1:image_width
            for channel = 1:num_channels
                % Extract the region of interest (ROI) for convolution
                roi = padded_image(y:y+mask_height-1, x:x+mask_width-1, channel);
                
                % Perform element-wise multiplication and sum
                output_image(y, x, channel) = sum(sum(roi .* mask));
            end
        end
    end
end

