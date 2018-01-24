function [ zerr,terr ] = getError( dsw,in)
load('quantities.mat',...
      'myU','g','Delta','mui','muiErr','gErr')
zb = [in.zb]';
Q0 = [dsw.Q0]';
Q  = [dsw.Q1]';
t  = [dsw.tb]';

% data_dir = '/Users/appm_admin/Documents/MATLAB/Dalton/2017_04_01_Dalton_WaveBreaking/';
% %% Jump Error due to Image Processing
% n = length(dsw);
% for ii = 1:n
%     trialDir = [data_dir,'Trial',sprintf('%02d',ii),'/break_cam/'];
%     load([trialDir,...
%         'edges.mat'],'left_edges','right_edges','crop_rect',...
%         'rotation_angle','crop_rect_rotated','times');
%     %% Change from right and left conduit edges to area
%     diam   = right_edges - left_edges;
%     diam   = fliplr(diam');
%     Apix   = pi/4*diam.^2;
%     
%     %% Normalize to initial background area
%     D0Err(ii) = 2*std(diams(1,:))*bottomPixToCm(ii);
%     
%     %         plot(diams(end,:))
%     %         drawnow
%     %         pause(0.5)
%     
%     D1(ii) = mean(diams(end,:))*bottomPixToCm(ii);
% end


% U = myU*sqrt(Q0);
%% Break Height Error
% ----- ruler -----
zb_err_ruler = 0.05; % cm

dg    = gErr; % gravity
dzdg  = Q.*Q0.*t.*Delta./( sqrt(8.*pi.*mui.*g.*Q.*Q0.*Delta) .* (sqrt(Q)-sqrt(Q0)) );

dD    = 0.0005; % fluid density 
dzdD  = g.*Q.*Q0.*t    ./( sqrt(8.*pi.*mui.*g.*Q.*Q0.*Delta) .* (sqrt(Q)-sqrt(Q0)) );
dQ0   = get_pump_flux(Q0);
dzdQ  = g.*Q0.*t.*Delta./( sqrt(8.*pi.*mui.*g.*Q.*Q0.*Delta) .* (sqrt(Q)-sqrt(Q0)) ) - ...
        t.*sqrt(g.*Q.*Q0.*Delta)./( sqrt(8.*pi.*mui.*Q) .* (sqrt(Q)-sqrt(Q0)).^2  );

dQ    = get_pump_flux(Q); % pump fluxuations [mL/min]??? < this needs work...
dzdQ0 = g.*Q.*t.*Delta./( sqrt(8.*pi.*mui.*g.*Q.*Q0.*Delta) .* (sqrt(Q)-sqrt(Q0)) ) + ...
        t.*sqrt(g.*Q.*Q0.*Delta)./( sqrt(8.*pi.*mui.*Q0)  .* (sqrt(Q)-sqrt(Q0)).^2  );

dmu   = muiErr;
dzdmu = -t.*sqrt(g.*Q.*Q0.*Delta)./( sqrt(8.*pi.*mui) .* (sqrt(Q)-sqrt(Q0)) .* mui );

dzb = sqrt( (dzdg.*dg).^2  + ...
            (dzdD.*dD).^2  + ...
            (dzdQ.*dQ).^2  + ...
            (dzdQ0.*dQ0).^2 + ...
            (dzdmu.*dmu).^2);

% % ----- fluid/physical params -----
% dg = gErr; % gravity 
% dudg = (1/2*(g*Delta*Q0/8/pi/mui).^-0.5) * Delta.*Q0/8/pi/mui;
% 
% dD = 0.0002; % fluid density 
% dudD = 1/2*(g*Delta*Q0/8/pi/mui).^-0.5 * g.*Q0/8/pi/mui;
% 
% dQ = 0.005; % pump fluxuations [mL/min]???
% dudQ0 = 1/2*(g*Delta*Q0/8/pi/mui).^-0.5 .* g*Delta/8/pi/mui;
% 
% dmu = muiErr; % fluid viscosity
% dudmu = -1/2*(g*Delta*Q0/8/pi/mui).^-0.5 * g*Delta.*Q0/8/pi/mui^2;
% 
% du = U .* sqrt((dudg*dg).^2 + (dudD*dD).^2 + (dudQ0*dQ).^2 + (dudmu*dmu).^2);
% 
% dzb = zb .* sqrt((du./U).^2 + 2*(dQ./Q1).^2 + (dQ./Q0).^2);
% 
zb_err_fluid = dzb;
% 
% 
zerr = zb_err_fluid + zb_err_ruler;
terr = ones(size(zerr));
%% Break Time Error

% tb = time_break_measure;
% tb_err_timer = 0.5 / 60; % (min)
% 
% Ufac_err     = Ufac_Dalton(1:40).*sqrt((gErr/g)^2 + (deltaErr/delta)^2 + (Q0err(1:40)./Q0(1:40)).^2 + (muiErr/mui)^2);
% tb_err_fluid = tb' .* sqrt((Ufac_err./Ufac_Dalton(1:40)).^2 + (zb_err'./zb).^2);
% 
% tb_err = tb_err_timer + tb_err_fluid;



end

