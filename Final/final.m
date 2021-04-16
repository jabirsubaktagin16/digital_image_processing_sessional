clc;
clear all;
close all;

% a. Input Image
img = im2double(rgb2gray(imread('input.png')));

% Zero Padding
[row, col] = size(img);
I = zeros(row+2, col+2);
I(2:row+1, 2:col+1) = img;

% b. Laplace Filter
laplace_image = zeros(row, col);
Lf=[0 -1 0;
   -1 4 -1;
    0 -1 0];
for s=2:row+1
    for t=2:col+1
        laplace_image(s-1,t-1)= I(s-1,t)*Lf(1,2)+I(s,t-1)*Lf(2,1)+ I(s,t)*Lf(2,2)+ I(s,t+1)*Lf(2,3)+I(s+1,t)*Lf(3,2);
    end
end;

% c. Enhanced Laplace Image
en_laplace_image = (img-laplace_image);

% d. Sobel Filtered Image
sobel1 = zeros(row, col);
sobel2 = zeros(row, col);
threshold = 0.1;
sx = [-1 0 1;
      -2 0 2;
      -1 0 1];
sy = [-1 -2 -1;
       0  0  0;
       1  2  1];
for s=2:row+1
    for t=2:col+1
        sobel1(s-1, t-1) = I(s-1, t-1)*sx(1, 1)+I(s-1, t+1)*sx(1, 3)+I(s, t-1)*sx(2, 1)+I(s, t+1)*sx(2, 3)+I(s+1, t-1)*sx(3, 1)+I(s+1, t+1)*sx(3, 3);
        sobel2(s-1, t-1) = I(s-1, t-1)*sy(1, 1)+I(s-1, t)*sy(1, 2)+I(s-1, t+1)*sy(1, 3)+I(s+1, t-1)*sy(3, 1)+I(s+1, t)*sy(3, 2)+I(s+1, t+1)*sy(3, 3);
    end
end
sobel_image= sqrt(sobel1.*sobel1+sobel2.*sobel2);
for i=1:row
    for j=1:col
        if sobel_image(i, j)>=threshold
            sobel_image(i, j) = sobel_image(i, j);
        else
            sobel_image(i, j) = 0;
        end
    end
end

% e. Average Filtered Image
average_image = zeros(row, col);
T = zeros(row+4, col+4);
T(3:row+2, 3:col+2) = img;
kernel = zeros(5, 5);
for i=3:(row+2)
    for j=3:(col+2)
        kernel = T(i-2:i+2, j-2:j+2);
        average_image(i-2, j-2) = mean(mean(kernel));
    end
end

% f. Product of 'c' and 'e'
product_image = en_laplace_image.*average_image;

% g. Sum of 'a' and 'f'
sum_image = img + product_image;

% h. Power Law Transform
pow_image = im2double(img);
c = 1;
gamma = 0.5;
pow_image = c*pow_image.^gamma;

figure;
subplot(2, 4, 1); imshow(img); title('a. Input');
subplot(2, 4, 2); imshow(laplace_image, []); title('b. Laplace');
subplot(2, 4, 3); imshow(en_laplace_image); title('c. Enhanced Laplace');
subplot(2, 4, 4); imshow(sobel_image); title('d. Sobel');
subplot(2, 4, 5); imshow(average_image); title('e. Average');
subplot(2, 4, 6); imshow(product_image); title('f. Product of c and e');
subplot(2, 4, 7); imshow(sum_image); title('g. Sum of a and f');
subplot(2, 4, 8); imshow(pow_image); title('h. Power Law Transform');