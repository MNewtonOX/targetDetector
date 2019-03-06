function [red_channel_f, RGB_cut] = extract_channel(RGB)

% Extract red channel
red_channel = RGB(:,:,1);

% Cut off top half of image as no one cares about the sky
red_channel_cut = red_channel(200:end,:);
RGB_cut = RGB(200:end,:,:);

% Ignore all values below a threshold value
red_threshold = 170; green_threshold = 220; blue_threshold = 220;

red_channel_f = zeros(size(red_channel_cut));
for i = 1:size(red_channel_cut,1)
    for j = 1:size(red_channel_cut,2)
        
        if red_channel_cut(i,j) > red_threshold && ...
           RGB_cut(i,j,2) < green_threshold && ...
           RGB_cut(i,j,3) < blue_threshold
            
            red_channel_f(i,j) = red_channel_cut(i,j);
            
        end
        
    end
end




% % Extract red channel
% red_channel_left = RGB_left(:,:,1);
% red_channel_right = RGB_right(:,:,1);
% 
% % Cut off top half of image as no one cares about the sky
% red_channel_left_cut = red_channel_left(200:end,:);
% RGB_left_cut = RGB_left(200:end,:,:);
% 
% red_channel_right_cut = red_channel_right(200:end,:);
% RGB_right_cut = RGB_right(200:end,:,:);
% 
% % Ignore all values below a threshold value
% red_threshold = 170; green_threshold = 220; blue_threshold = 220;
% red_channel_left_f = zeros(size(red_channel_left_cut));
% for i = 1:size(red_channel_left_cut,1)
%     for j = 1:size(red_channel_left_cut,2)
%         
%         if red_channel_left_cut(i,j) > red_threshold && ...
%            RGB_left_cut(i,j,2) < green_threshold && ...
%            RGB_left_cut(i,j,3) < blue_threshold
%             
%             red_channel_left_f(i,j) = red_channel_left_cut(i,j);
%             
%         end
%         
%     end
% end
% 
% red_channel_right_f = zeros(size(red_channel_right_cut));
% for i = 1:size(red_channel_right_cut,1)
%     for j = 1:size(red_channel_right_cut,2)
%         
%         if red_channel_right_cut(i,j) > red_threshold && ...
%            RGB_right_cut(i,j,2) < green_threshold && ...
%            RGB_right_cut(i,j,3) < blue_threshold
%             
%             red_channel_right_f(i,j) = red_channel_right_cut(i,j);
%             
%         end
%         
%     end
% end
