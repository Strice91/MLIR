function Exercise2(Image)
close all;
name = Image(1:end-4);

%% a)
n = 20;
p = 0.2;
% Skin Model 
[mu_s, Sigma_s] = LearnModelParameters('bush', n, p);

disp('Skin Model');
disp('mu');
disp(mu_s);
disp('Sigma');
disp(Sigma_s);

%% b)
n = 22;
p = 1;
% Background Model 
[mu_b, Sigma_b] = LearnModelParameters('BackgroundImages', n, p);

disp('Background Model');
disp('mu');
disp(mu_b);
disp('Sigma');
disp(Sigma_b);

%% c)
% Skin Likelihood of Image
L1 = EvaluateLikelihood(Image,mu_s,Sigma_s);
f = figure;
imshow(L1/max(L1(:)));
title('p(x|skinmodel)');
print(f,'-dpng',strcat('../tex/img/',name,'-skin','.png')); 

%% d)
% Background Likelihood of Image
L2 = EvaluateLikelihood(Image,mu_b,Sigma_b);
f = figure;
imshow(L2/max(L2(:)));
title('p(x|backgroundmodel)');
print(f,'-dpng',strcat('../tex/img/',name,'-back','.png')); 

%% e)
% Binary Image
ratio = (L1./L2);
B = ratio>=1;
f = figure;
imshow(B);
title('binary classified image');
print(f,'-dpng',strcat('../tex/img/',name,'-bin','.png'));

%% f)
% Face detection
[x,y] = FindBiggestComp(B);

img = imread(Image);
f = figure;
imshow(img);
hold all;
plot([x,x(1)],[y,y(1)],'r');
title('face detection');
print(f,'-dpng',strcat('../tex/img/',name,'-face','.png'));
end

