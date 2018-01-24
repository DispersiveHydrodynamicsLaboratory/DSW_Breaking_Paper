function [ img ] = dispDNG( pn )
datadir = '/Users/appm_admin/Documents/MATLAB/Dalton/2017_04_01_Dalton_WaveBreaking/';
load([datadir,'Trial17/break_cam/edges.mat']);
load([datadir,'quantities.mat'],'bottomPixToCm')
load([datadir,'Processing/fig_quants.mat'])
load([datadir,'Trial17/break_cam/full_preprocessing_data.mat'],'crop_rect',...
      'rotation_angle','crop_rect_rotated','specialpic',...
      'theta','theta_pre');
rect = crop_rect;
gridsp = 1;
img_files = glob([datadir,'Trial17/break_cam/','*.dng']);
img = openDNG(img_files{pn});
        % Rotate theta_pre degrees ccw
        img = imrotate(img,theta_pre,'bicubic');
        % Crop with previous crop rectangle
        img = imcrop(img,rect);
        % Interpolate the image along horizontal lines
        [mz, nz] = size(img); 
        img   = imresize(img,[mz,nz*gridsp]);
        % Rotate
        disp(['Rotating image ',num2str(theta),' degrees and reprocessing']);
        img = imrotate(img,theta,'bicubic');
        % Crop again
        img = imcrop(img,crop_rect_rotated);
        img = imrotate(img,-90,'bicubic');
        imshow(img);
end

