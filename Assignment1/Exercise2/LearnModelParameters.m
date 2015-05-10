function [mu, Sigma] = LearnModelParameters(DirectoryName,n)

d = dir(fullfile(DirectoryName,'*.jpg'));
N = length(d);

if N<n
   error('Not enough images in folder!'); 
end

p = 0.2;

% List of RGB Values
rgb = [];
for i = 1:n
   % Build Filename
   filename = fullfile(DirectoryName,d(i).name);
   % Get CenterPixels for each image
   CenterPixels = ExtractCenterPixels(filename,p);
   % Reshape image
   % r1, g1, b1
   % r2, g2, b2
   % ...
   rgbValues = double(reshape(CenterPixels, [size(CenterPixels,1)*size(CenterPixels,2),3]));
   % Add below other Values
   rgb = [rgb; rgbValues];
end

mu = mean(rgb)';
Sigma = cov(rgb);

end

