clc; clear; close all;
pkg load image;

R = cell2mat(struct2cell(load('red.img')));
R = reshape(R, [200 200]);
R = transpose(R);
R = uint8(R);

G = cell2mat(struct2cell(load('green.img')));
G = reshape(G, [200 200]);
G = transpose(G);
G = uint8(G);

B = cell2mat(struct2cell(load('blue.img')));
B = reshape(B, [200 200]);
B = transpose(B);
B = uint8(B);

I = uint8(zeros(200,200,3));
I(:,:,1) = R;
I(:,:,2) = G;
I(:,:,3) = B;
imshow(I);