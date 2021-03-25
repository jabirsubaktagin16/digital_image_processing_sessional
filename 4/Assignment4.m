function GaussianFilter()
    S = rgb2gray(imread('thanos.png'));
    figure; imshow(S); imwrite(S, 'input.png');
    R = double(S);
    
    value = 'Write the Sigma Value: ';
    sigma = input(value);
    sz = 2;
    [x, y] = meshgrid(-sz:sz, -sz:sz);
    M = size(x,1)-1;
    N = size(y, 1)-1;
    exp_comp = -(x.^2+y.^2)/(2*sigma^2);
    kernel = exp(exp_comp)/(2*pi*sigma^2);
    output = zeros(size(R));
    R = padarray(R,[sz sz]);
    
    for i = 1:size(R,1)-M
       for j = 1:size(R,2)-N 
           temp = R(i:i+M, j:j+M).*kernel;
           output(i,j) = sum(temp(:));
       end
    end
    
    output = uint8(output);
    figure; imshow(output); imwrite(output, 'output.png');
end