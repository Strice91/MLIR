function f = walkshow(states)
  [dummy, n] = size(states);

  im = {imadjust(imread('img/step1.png')),
	imadjust(imread('img/step2.png')),
	imadjust(imread('img/step3.png')),
	imadjust(imread('img/step4.png')),
	imadjust(imread('img/step5.png')),
	imadjust(imread('img/step6.png')),
	imadjust(imread('img/step7.png')),
	imadjust(imread('img/step8.png')),
	imadjust(imread('img/step9.png')),
	imadjust(imread('img/step10.png')),
	imadjust(imread('img/step11.png')),
	imadjust(imread('img/step12.png')),
	imadjust(imread('img/step13.png')),
	imadjust(imread('img/step14.png')),
	imadjust(imread('img/step15.png')),
	imadjust(imread('img/step16.png'))};

  
  p = im{states(1)};
  for i = 2:n
    p = [p, im{states(i)}];
  end

  f = figure;
  imwrite(p, 'cartoon.png');
  imshow(p);
  start_x = 17;
  step = 49;
  y = 80;
  
  for i = 0:(n-1)
      text(start_x+step*i,y,sprintf('%i',states(i+1)));
  end
  
end
