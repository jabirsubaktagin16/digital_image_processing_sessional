img1 = imread('B1_160204061_Ahmad_Subaktagin_Jabir_img.jpeg');

% Grayscale Image
I = rgb2gray(img1);
[row, col] = size(I);
X = zeros(256, 1);
for i=1:row
    for j=1:col
        temp = I(i,j)+1;
        X(temp) = X(temp)+1;
    end
end

%Negative Image
I_neg = 255-I;
[row_neg, column_neg] = size(I_neg);
X_neg = zeros(1,256);
for i=1:row_neg
    for j=1:column_neg
        temp = I_neg(i, j)+1;
        X_neg(temp) = X_neg(temp)+1;
    end
end

%Thresholded Image
threshold = 'Write the Threshold Value: ';
A = input(threshold);
I_threshold = I;
[row_threshold, column_threshold] = size(I_threshold);
for i=1:row_threshold
    for j=1:column_threshold
        if(I(i,j)>A)
            I_threshold(i, j) = I(i, j)+I(i, j)*0.5;
        else
            I_threshold(i, j) = I(i, j)-I(i, j)*0.25;
        end
    end
end
X_thres = zeros(1, 256);
for i=1:row_threshold
    for j=1:column_threshold
        temp = I_threshold(i, j)+1;
        X_thres(temp) = X_thres(temp)+1;
    end
end

% Log Transformed Image
I_log = im2double(I);
c = 1.5;
I_log = c*log(1+I_log);
I_log = im2uint8(I_log);
[row_log, col_log] = size(I_log);
X_log = zeros(1,256);
for i=1:row_log
    for j=1:col_log
        temp = I_log(i, j)+1;
        X_log(temp) = X_log(temp)+1;
    end
end

% Power Transformed Image
I_pow = im2double(I);
c = 1.5;
prompt ='Write the Gama Value: ';
Y = input(prompt);
I_pow = c*I_pow.^Y;
I_pow = im2uint8(I_pow);
[row_pow, col_pow] = size(I_pow);
X_pow = zeros(1,256);
for i=1:row_pow
    for j=1:col_pow
        temp = I_pow(i, j)+1;
        X_pow(temp) = X_pow(temp)+1;
    end
end

figure;
subplot(2,5,1);
imshow(I);
title('Grayscale');
subplot(2,5,2);
imshow(I_neg);
title('Negative');
subplot(2,5,3);
imshow(I_threshold);
title('Threshold');
subplot(2,5,4);
imshow(I_log);
title('Log Transformed');
subplot(2,5,5);
imshow(I_pow);
title('Power Law Transformed');
subplot(2,5,6);
bar(X);
xlabel('Gray Level');
ylabel('Pixel Count');
subplot(2,5,7);
bar(X_neg);
xlabel('Gray Level');
ylabel('Pixel Count');
subplot(2,5,8);
bar(X_thres);
xlabel('Gray Level');
ylabel('Pixel Count');
subplot(2,5,9);
bar(X_log);
xlabel('Gray Level');
ylabel('Pixel Count');
subplot(2,5,10);
bar(X_pow);
xlabel('Gray Level');
ylabel('Pixel Count');