I=imread('B1_160204061_Ahmad_Subaktagin_Jabir_img1.jpg');
figure;
imshow(I);
J=imread('B1_160204061_Ahmad_Subaktagin_Jabir_img2.JPG');
figure;
imshow(J);
[img1_row,img1_col]=size(I);
[img2_row,img2_col]=size(J);
img1_row1 = I(1:img1_row/5,:,:);
img2_row2 = J((img1_row/5)+1:(2*img1_row/5),:,:);
img1_row3 = I((2*img1_row/5)+1:(3*img1_row/5),:,:);
img2_row4 = J((3*img2_row/5)+1:(4*img2_row/5),:,:);
img1_row5 = I((4*img1_row/5)+1:img1_row,:,:);
K = [img1_row1;img2_row2;img1_row3;img2_row4;img1_row5]
figure;
imshow(K);
imwrite(K, 'B1_160204061_Ahmad_Subaktagin_Jabir_img3.jpg');
[K_row,K_col,z] = size(K);
angle = 270;
rads = 2*pi*angle/360;
rowsf = ceil(K_row*abs(cos(rads))+K_col*abs(sin(rads)));
colsf = ceil(K_row*abs(sin(rads))+K_col*abs(cos(rads)));
L = uint8(zeros([rowsf colsf 3]));
xo = ceil(K_row/2);
yo = ceil(K_col/2);
midx = ceil((size(L,1))/2);
midy = ceil((size(L,2))/2);
for i = 1:size(L,1)
    for j = 1:size(L,2)
        x = (i-midx)*cos(rads)+(j-midy)*sin(rads);
        y = -(i-midx)*sin(rads)+(j-midy)*cos(rads);
        x = round(x)+xo;
        y = round(y)+yo;
        
        if(x>=1 && y>=1 && x<=size(K,1) && y<=size(K,2))
            L(i,j,:)=K(x,y,:);
        end
    end
end
figure;
imshow(L);
imwrite(L, 'B1_160204061_Ahmad_Subaktagin_Jabir_img4.jpg');