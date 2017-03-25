clear all;
close all;
clc;

img = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');

[locs1, desc1] = briefLite(img);
[locs2, desc2] = briefLite(img2);

matches = briefMatch(desc1, desc2, 0.5);
plotMatches(img,img2,matches,locs1,locs2);

H2to1 = ransacH(matches, locs1, locs2, 1000,0.2);
save('../results/q6_1.mat', 'H2to1');

close all;
panoImg = imageStitching(img, img2,eye(3), H2to1);
imshow(panoImg);
imwrite(panoImg,'../results/q6_1.jpg','jpg');

panoImg_noclip = imageStitching_noClip(img, img2, H2to1);
imshow(panoImg_noclip);
imwrite(panoImg_noclip,'../results/q6_2.jpg','jpg');