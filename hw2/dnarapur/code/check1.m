clear;

img = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');

[locs1, desc1] = briefLite(img);
[locs2, desc2] = briefLite(img2);
matches = briefMatch(desc1, desc2, 0.5);
plotMatches(img,img2,matches,locs1,locs2);

%ginput
p1 = locs1(matches(:,1),1:2)';
p2 = locs2(matches(:,2),1:2)';
H2to1 = computeH(p1, p2);
%save('../results/q5_1.mat', 'H2to1');

panoImg = imageStitching(img, img2,eye(3), H2to1);
imshow(panoImg);
%imwrite(panoImg,'../results/q5_1.jpg','jpg');

panoImgNoClip = imageStitching_noClip(img, img2, H2to1);
%imshow(panoImgNoClip);
%imwrite(panoImgNoClip,'../results/q5_2_pan.jpg','jpg');