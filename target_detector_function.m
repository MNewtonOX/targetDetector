%% Function to detector the red target
function [x,y,z] = target_detector_function(stereo_images)

%% Inputs RBG image
% Get Justky configeration
config = GetHuskyConfig(3);

% Import image stucture
%import_image('1551799781997706.mat');

% Fix image distortion
model_left = config.camera_model.left;
RGB_left = UndistortImage(stereo_images.left,model_left);
RGB_left = RGB_left.rgb;
imshow(RGB_left);

model_right = config.camera_model.right;
RGB_right = UndistortImage(stereo_images.right,model_right);
RGB_right = RGB_right.rgb;
imshow(RGB_right);

%% Just look at the red channel and look for pixels that are most red
[red_channel_left_f, RGB_left_cut] = extract_channel(RGB_left);
[red_channel_right_f, RGB_right_cut] = extract_channel(RGB_right);

%% Edge detector
[edge_image_left] = edge_detector(red_channel_left_f);
[edge_image_right] = edge_detector(red_channel_right_f);

%% Ellipse fit
best_fits_left = ellipseDetection(edge_image_left);
%[best_fits_left, e_left] = findellipse(edge_image_left);
%[ellipses, L, posi] = ellipseDetectionByArcSupportLSs(edge_image_left,1,1,1);
best_fits_right = ellipseDetection(edge_image_right);

% Plot ellipse
figure;
image(RGB_left_cut);
ellipse(best_fits_left(1,3),best_fits_left(1,4),best_fits_left(1,5)*pi/180,...
    best_fits_left(1,1),best_fits_left(1,2),'k');
%ellipse(bestFits(:,3),bestFits(:,4),bestFits(:,5)*pi/180,bestFits(:,1),...
  %  bestFits(:,2),'k');
  
figure;
image(RGB_right_cut);
ellipse(best_fits_right(1,3),best_fits_right(1,4),best_fits_right(1,5)*pi/180,...
    best_fits_right(1,1),best_fits_right(1,2),'k');
%ellipse(bestFits(:,3),bestFits(:,4),bestFits(:,5)*pi/180,bestFits(:,1),...
  %  bestFits(:,2),'k');

%% Convert ellipse to range and bearing
b = 0.1194;
f = 233.3;
xa = best_fits_left(1,1); xb = best_fits_right(1,1); ya = best_fits_left(1,2);
z = b*f/(xa-xb);

x = xa*z/f;
y = ya*z/f;


end
