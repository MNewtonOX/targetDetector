function [edge_image] = edge_detector(red_channel_f)

[~, threshold] = edge(red_channel_f, 'sobel');
fudgeFactor = 1;
BWs = edge(red_channel_f,'sobel', threshold * fudgeFactor);
figure, imshow(BWs), title('binary gradient mask');

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

BWsdil = imdilate(BWs, [se90 se0]);
figure, imshow(BWsdil), title('dilated gradient mask');

BWdfill = imfill(BWsdil, 'holes');
figure, imshow(BWdfill);
title('binary image with filled holes');

BWnobord = imclearborder(BWdfill, 4);
figure, imshow(BWnobord), title('cleared border image');

seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
figure, imshow(BWfinal), title('segmented image');

BWoutline = bwperim(BWfinal);
Segout = red_channel_f; 
Segout(BWoutline) = 255; 
figure, imshow(Segout), title('outlined original image');

edge_image = BWoutline;

end




% 
% 
% %% Edge detector on image
% I = RC_f;
% [~, threshold] = edge(I, 'sobel');
% fudgeFactor = .5;
% BWs = edge(I,'sobel', threshold * fudgeFactor);
% figure, imshow(BWs), title('binary gradient mask');
% 
% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 0);
% 
% BWsdil = imdilate(BWs, [se90 se0]);
% figure, imshow(BWsdil), title('dilated gradient mask');
% 
% BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill);
% title('binary image with filled holes');
% 
% BWnobord = imclearborder(BWdfill, 4);
% figure, imshow(BWnobord), title('cleared border image');
% 
% seD = strel('diamond',1);
% BWfinal = imerode(BWnobord,seD);
% BWfinal = imerode(BWfinal,seD);
% figure, imshow(BWfinal), title('segmented image');
% 
% BWoutline = bwperim(BWfinal);
% Segout = I; 
% Segout(BWoutline) = 255; 
% figure, imshow(Segout), title('outlined original image');

