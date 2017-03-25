clear all;
close all;
clc;

img1 = imread('../data/incline_L.png');
img2 = imread('../data/incline_R.png');

[locs1 desc1] = briefLite(img1);
[locs2 desc2]= briefLite(img2);

[matches] = briefMatch(desc1, desc2,0.55);
close all;


plotMatches(img1,img2,matches,locs1,locs2);
