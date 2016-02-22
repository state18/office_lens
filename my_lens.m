function [g] = my_lens ( f, x )

%getting size of the input image
Ro = size(f,1);
Co = size(f,2);

gray_im = rgb2gray(f);

MCo = mean(gray_im);
MRo = mean(gray_im,2);

 figure
 bar(MCo, 'm')
%  
%  figure
%  bar(MRo, 'r')

possibleLeftBounds = 1;
possibleRightBounds = Co;

lowerBounds = 1;
upperBounds = Ro;


stepSize = 30

% Tolerance might be more useful if calculated on per image basis.
tolerance = 25
previousCell = 1

for c = 1:stepSize:Co
    differenceBetweenCells = MCo(c) - MCo(previousCell);
    if (differenceBetweenCells > tolerance)
       possibleLeftBounds(end + 1,1:2) = [previousCell, MCo(previousCell)]
    end
    
    if (differenceBetweenCells <= -tolerance)
       possibleRightBounds(end + 1,1:2) = [c, MCo(c)]
    end
    
    previousCell = c;
end

% % Original code that equalizes the image
% % convert to grayscale
% im_g = rgb2gray ( f );
% 
% % histogram equalization 
% hist   = imhist(im_g(:,:)); 
% maxIntensity = 255;  
% cdf_v(1)= hist(1);
% for i=2:maxIntensity+1
%     cdf_v(i) = hist(i) + cdf_v(i-1);
% end
% 
% cdf_v = cdf_v/double(numel(im_g))*255.0;
% 
% im_e = uint8( cdf_v ( im_g+1));
% 
% 
% % do not crop.  convert to color
% g = cat ( 3, im_e, im_e, im_e );
% 
% 
% % resize
% g = imresize ( g, x );
% image(g)
