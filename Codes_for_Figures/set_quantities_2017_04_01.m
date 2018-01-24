% This script includes all relevant dimensional and dimensionless
% quantities related to the experiments done on this data

% Saves results of this script as a .mat file (for ease of access through
% ssh)
clear;clc
save_quant_on = 1;
if save_quant_on
    clear all;
    save_quant_on = 1;
end

DataDir = '/Volumes/Data Storage/2017_04_01_Dalton_WaveBreaking/'; 

%% ----- Characterization Struct -----
% ----- load dsw/rw (dr) parameters
trials = 1:length(dir([DataDir,'Trial*'])); % Trials
dsw    = struct; %
dsw.A0 = 0; % jump ratio 
dsw.Q0 = 0; % background/initial flow rate [mL/min]
dsw.Q1 = 0; % final flow rate [mL/min]
dsw.zb = 0; % desired break height [cm]
dsw.tb = 0; % predicted break time [min]

for tr = trials
    Folder = sprintf('Trial%02d/',tr);
    try
        load([DataDir,Folder,'dsw_params.mat'])
        dsw(tr).A0 = A0;
        dsw(tr).Q0 = Q0;
        dsw(tr).Q1 = Q1;
        dsw(tr).zb = zb;
        dsw(tr).tb = tb; 
    catch
        fprintf('dsw_params.mat not found for Trial %0.0f\n',tr);
    end
end


%% ----- Fluid Properties -----
% DSW BREAKING TRIALS--2017_03_04
% Fluid Properties in cP and g/cm^3
mu_i_cP   = vis_calib(mean([ 68.2 68.2 68.2 ])); %interior viscosity (cP)
mu_e_cP   = vis_calib(mean([ 1170 1170 1180 1172 1172 ])); %exterior viscosity (cP)
rho_i  = mean([ 1.2245 1.2250 1.2205 1.2208 1.2207 ]); %interior density (g/cm^3)
rho_e  = mean([ 1.2618 1.2619 1.2620 1.2619 1.2620 ]); %exterior density (g/cm^3)
hl     = 'l'; % high/low flow pump

mui = mu_i_cP*0.01*60; % in [g/(cm*min)]
mue = mu_e_cP*0.01*60; % in [g/(cm*min)]


%% ----- Pix to Length Conversions -----
%based on measurement of large spindle
bottomPixToCm = 2.5625*2.54/mean([2506.15 2506.23]); 
% fullPixToCm   = 2.5625*2.54/mean([243.21 242.76 242.89 ]); 
% topPixToCm    = 0.2696*2.54/mean([241.168,242.297, 242.101]);%2.5625*2.54/mean([ 2427.07 2427.19 ]); 
breakPixToCm  = 0.7350*2.54/mean([664.25 660.97 663.28]); % used length of med-sized spindle

%% Scaling factors

% ----- Gravity in Denver -----
g = 9.796*100*60^2; % In cm/min^2

% ----- Useful Quantities -----
Delta = rho_e-rho_i;
alpha = (2^7*mui/(pi*g*Delta))^0.25;

% ----- Viscosity Ratio -----
epsilon = mui/mue;


% To convert lengths to cm, multiply background
% diameter in cm times L0fac
%    R = L0fac*Diam * R_nd
%    Z = L0fac*Diam/eps^0.5 * Z_nd
L0fac = sqrt(1/32);
% To convert velocities to dimensional quantities, multiply square of 
% background diameter in cm times U0fac

% ----- velocity scale -----
% Q0 not known, therefore U = myU*sqrt(Q0) in boundaryData_DSW.m
myU =sqrt(g*Delta/(8*pi*mui)); 

%---------------------
%    vel = U0fac*Diam^2 * vel_nd
U0fac = g*Delta/(32*mui); % in 1/(cm*min)
U0fac = U0fac/60; % in 1/(cm*s)
% To convert times to dimensional quantities, divide T0fac by 
% background diameter in cm
%     t = T0fac/Diam/eps^0.5 * t_nd
T0fac = L0fac/U0fac; % in cm*s



% for tr = trials
% %     plot(tr,dsw(tr).tb,'bp'); hold on
%       dr(tr).tb = dr(tr).zb/(2*myU*sqrt(dr(tr).Q0));
% %     plot(tr,dsw(tr).tb,'rx')
% end

%% Error Calculations

% Error in density measurement is fixed at 0.001 g/cm^3
rho_err = 0.001; % in g/cm^3
gErr = (0.001)*100*60^2; % In cm/min^2

% % Estimated uncertainties in pump rates from calibration studies in mL/min
% % (plus or minus these values)
Q0err = Q0*0.02*2; % 2 x the standard dev of relative error of 2%
% Q1err = Q1*0.02*2;

% Uncertainty in viscosity reading, calculated as 1% of Full Scale 
% Viscosity Range (FSR) = TK*SMC*10,000/RPM where 
% TK = torque constant = 0.09373 for LVDV-I Prime
% SMC = spindle multiplier constant = 6.4 (#61), 32 (#62), 128 (#63), 640 (#64)
% RPM = rotation rate used in measurement
muiErrcP = mu_i_cP + 0.01*0.09373*6.4*1e4/60 - mu_i_cP; %vis_calib(muicP_measured + ...
                     %0.01*0.09373*6.4*1e4/50) - muicP; % in cP, calibrated
muiErr = muiErrcP*0.01*60; % in g/(cm*min)
% Lower and upper bounds on error in mui from temperature dependence
muiErrTemplcP = mu_i_cP + muiErrcP - 67.67-1.2;%vis_calib(67.67-1.2); % in cP at max temp 22.7 C
muiErrTempl = muiErrTemplcP*0.01*60; % in g/(cm*min)
muiErrTempucP = (76.85+2.0) - (mu_i_cP - muiErrcP);%vis_calib(76.85+2.0) - (muicP - muiErrcP); % in cP at min temp 20.4 C
muiErrTempu = muiErrTempucP*0.01*60; % in g/(cm*min)

mueErrcP = 0.01*0.09373*128*1e4/60; % in cP
mueErr = mueErrcP*0.01*60; % in g/(cm*min)

alphaErrl = alpha - (2^7*(mui-muiErr)/...
                     (pi*(g+gErr)*(rho_e-rho_i+2*rho_err)))^0.25;
alphaErru = (2^7*(mui+muiErr)/...
                     (pi*(g-gErr)*(rho_e-rho_i-2*rho_err)))^0.25 - alpha;
alphaErrTempl = alpha - (2^7*(mui-muiErrTempl)/...
                     (pi*(g+gErr)*(rho_e-rho_i+2*rho_err)))^0.25;
alphaErrTempu = (2^7*(mui+muiErrTempu)/...
                     (pi*(g-gErr)*(rho_e-rho_i-2*rho_err)))^0.25 - alpha;


                 
%% save values
if save_quant_on
    save('quantities.mat');
%     save('Processing/quantities.mat');
end

