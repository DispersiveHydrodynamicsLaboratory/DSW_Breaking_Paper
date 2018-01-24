%% Load specific dataset for data processing figures
clear;close all; clc
addpath([pwd,'/sub_functions'])

process_on = 0; % Processes breaking images
fs = 7;
lw = 1;
w    = 3;
h    = 3;
alpha = 0.75;

datadir = '/Users/appm_admin/Documents/MATLAB/Dalton/2017_04_01_Dalton_WaveBreaking/';
load([datadir,'Trial17/break_cam/edges.mat']);
load([datadir,'quantities.mat'],'bottomPixToCm')
load([datadir,'Processing/fig_quants.mat'])
load([datadir,'Trial17/break_cam/full_preprocessing_data.mat'],'crop_rect',...
      'rotation_angle','crop_rect_rotated','specialpic',...
      'theta','theta_pre');
Abreak = load([pwd,'/sub_functions/trial17break.mat'],'z','Abz');
if ~process_on
    load([pwd,'processed.mat'],'img1','img2','img3');
end
    
%% Breaking Pic
diam   = right_edges - left_edges;
diam   = fliplr(diam');
Apix   = pi/4*diam.^2;
[~,n]  = size(Apix);
A1 = mean(Apix(1,end-1000:end-200)); % get background area
A  = Apix/A1;
Aplt = @(x) A(x,:);

im_h            = 5472;   % height(pix) of the full image
nozzle_h_cm     = 2.55;   % height of the nozzle (cm)
img_bottom_h_cm = 13.425; % height at the bottom of image (cm)
crop_22         = crop_rect(1:2)+crop_rect(3:4); % (x,y)bottom right pix of crop window
im_cut_bottom   = im_h-crop_22(2); % pix cropped off the bottom of the image
z = ((1:n) + im_cut_bottom).*bottomPixToCm + img_bottom_h_cm - nozzle_h_cm;

fh = figure; hold on; % edges
    p1 = plot(z,Abreak.Abz,'b','LineWidth',lw); % plot breaking edge
    p2 = plot(z,Aplt(21),'r:','LineWidth',lw); % plot pre-breaking edge
    p3 = plot(z,Aplt(24),'-.','Color',[0 0.5 0],'LineWidth',1); % plot post-breaking edge
    p4 = plot([10,20,20,25],[4,4,1,1],'k--','linewidth',lw/2);
%     plot([dsw(17).zb,dsw(17).zb],[0,6],'--','color',[1,1,1]*alpha)
    p5 = plot([out(17).zb,out(17).zb],[0,6],'-','color',[1,1,1]*alpha,'Linewidth',1.5);
    xlabel('$z~(cm)$','Interpreter','LaTex');
    ylabel('$A$','Interpreter','LaTex');
    set(gca,'fontsize',fs,...
            'xlim',[min(z),max(z)],...
            'YTick',[1,2,3,4,5],...
            'ticklabelinterpreter','latex',...
            'box','on')
    leg = legend([p2,p1,p3,p4,p5],'Pre-Breaking','Breaking','Post-Breaking','Input','Observed $z_b$');
    set(leg,'Interpreter','latex',...
                          'FontSize',fs,...
                          'Location','SouthWest',...
                          'box','off')
savePlot(fh,'BreakEdges',w,h)                  


%% Edge Detection Pic

warning('off','all')
fh = figure; % edge_detection
    row = 22;
    ha = tight_subplot(3,1);
    p1 = get(ha(1),'position');
    p2 = get(ha(2),'position');
    p3 = get(ha(3),'position');
    axes(ha(1))
        if process_on
            img1=dispDNG(row-2);
        else
            imshow(img1);
        end
        hold on
        plot(length(right_edges(:,row-2)):-1:1,right_edges(:,row-2),'r:','LineWidth',lw/2)
        plot(length(left_edges(:,row-2)):-1:1,left_edges(:,row-2),'r:','LineWidth',lw/2)
        t1 = title('Pre-Breaking','FontSize',fs);
    axes(ha(2))
        if process_on
            img2=dispDNG(row);
        else
            imshow(img2);
        end
        hold on
        plot(length(right_edges(:,row)):-1:1,right_edges(:,row),'b',...
            'LineWidth',lw/2)
        plot(length(left_edges(:,row)):-1:1,left_edges(:,row),'b',...
            'LineWidth',lw/2)
        t2 = title('Breaking','FontSize',fs);
    axes(ha(3))
        if process_on
            img3=dispDNG(row+2);
        else
            imshow(img3);
        end
        hold on
        plot(length(right_edges(:,row+2)):-1:1,right_edges(:,row+2),...
            '-.','Color',[0 0.5 0],...
            'LineWidth',lw/2)
        plot(length(left_edges(:,row+2)):-1:1,left_edges(:,row+2),...
            '-.','Color',[0 0.5 0],...
            'LineWidth',lw/2)
        t3 = title('Post-Breaking','FontSize',fs);
	if process_on
        save([pwd,'processed.mat'],'img1','img2','img3');
    end
savePlot(fh,'BreakEdgeDetection',w,h)  

% 
% figure(9) % break_contour
% zshift = @(z) (z+im_cut_bottom)*bottomPixToCmInside+19.55-nozzle_h_cm;
% ind = 2:length(A(:,1))-1;
% contourf(z,t(ind),A(ind,:),20,'edgecolor','none');
% colorbar;
% %Load the cool-warm colormap
% cmap = load('CoolWarmFloat257.csv');
% colormap(cmap);
% caxis([1,max(max(A))]);
% ch=colorbar();
% hold on;
% plot(zshift(locp),time_break_measure(33),'kx','MarkerSize',msize);
% plot(z0(33),time_break_predict(33),'ko','MarkerSize',msize);
% hold off
