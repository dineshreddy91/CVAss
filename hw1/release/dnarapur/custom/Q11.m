clear all;
close all;
clc;

%pkg load image
image = imread('../data/art_gallery/sun_ajnlfohihtjpaetk.jpg');
filterBank = createFilterBank();

filter_response = extractFilterResponses(image,filterBank);
h=montage(filter_response,'size',[4 5]);
MyMontage = get(h, 'CData');
imwrite(MyMontage, '3_o.jpg');

