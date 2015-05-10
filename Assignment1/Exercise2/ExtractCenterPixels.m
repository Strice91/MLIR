function [ CenterPixels ] = ExtractCenterPixels(ImageName,p)

% Read Full Image
img = imread(ImageName);

% Determine Image Size
H = size(img,1);
W = size(img,2);

% new Image Size
h = floor(p*H);
w = floor(p*W);

% Border from Top
m = floor((H-h)/2);

% Border from Left
n = floor((W-w)/2);

% Crop out center pixels
CenterPixels = imcrop(img,[n,m,h-1,w-1]);

end

