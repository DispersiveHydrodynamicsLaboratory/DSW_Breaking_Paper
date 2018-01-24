% =========================================================================
% This script generates a dsw ramp profile with the characteristics
% defined below.
%
% Author: Dalton Anderson
% Date:   April 1, 2017
%==========================================================================

% ----- set dsw parameters -----
A0 = 2; %Jump Height (nd)
zb = 15; %break height (cm)
Q0 = 0.25; %background flow rate (mL/min)


% ----- load neccessary quantities -----
load(['/Users/appm_admin/Documents/MATLAB/Dalton/2017_04_01_Dalton_WaveBreaking/',...
      'quantities.mat'],'myU',...
                        'hl');                   
U    = myU*sqrt(Q0); % velocity scale (cm/min) (see set_quantities.m)
Q1   = A0^2*Q0; % final flow rate (mL/min)
tb   = zb/(2*U); % predicted breaking time (min)
time = round(-1*60):1:ceil(tb*60);
time = time./60;


% ----- generate ramp profile -----                    
gamma = U/zb; 
ratefun = @(t) Q0*(1                     .*(t<=0) +...
                   1./(1-2*gamma.*t).^2  .*(t>0 & gamma.*t<(A0-1)/(2*A0))+...
                   A0^2                  .*(gamma.*t>=(A0-1)/(2*A0)));
rate = ratefun(time);
figure(1); clf; plot(time,rate);