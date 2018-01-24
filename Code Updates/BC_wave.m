
% Purpose: This script generates a plot of the rarefaction wave solution 
%          and of the inverse rarefaction wave solution to the Inviscid 
%          Burgers Equation
%
% Author:    Dalton Anderson
% Date:      April 2016
%__________________________________________________________________________

clear; close all;clc
% Figure parameters
fs   = 8;
w    = 2;
h    = 2;
lw = 0.1;
lc = {'r','b',[0,0.5,0],'k'};
ls = {'--',':','-.','-'};


% ----- set dsw parameters -----
Ab = 2; %Jump Height (nd)
zb = 15; %break height (cm)
Q0 = 0.25; %background flow rate (mL/min)


% ----- load neccessary quantities -----
load(['/Users/appm_admin/Documents/MATLAB/Dalton/2017_04_01_Dalton_WaveBreaking/',...
      'quantities.mat'],'myU',...
                        'hl');                   
U    = 1;%myU*sqrt(Q0); % velocity scale (cm/min) (see set_quantities.m)
Q1   = Ab^2*Q0; % final flow rate (mL/min)
tb   = zb/(2*U); % predicted breaking time (min)
time = round(-tb/2*60):1:ceil(tb*60);
time = time./60;


% ----- generate ramp profile -----                    
gamma = U/zb; 
ratefun = @(t)  (1                     .*(t<=0) +...
                   1./(1-2.*t/zb)      .*(t>0 & t/zb <(Ab-1)/(2*Ab))+...
                   Ab                  .*(t/zb>=(Ab-1)/(2*Ab)));
rate = ratefun(time);

fh = figure;hold on;
    plot(time,rate,ls{4},'color',lc{2},'linewidth',lw);
    
%     text(1,1,'$t_1<t_2<t_3<t_b$','interpreter','latex','fontsize',fs)
    
    
    axis([time(1) tb 0.9 Ab+0.1])
%     set(gca, 'units', 'inches', 'pos', [2 2 3 3])
    set(gcf,'Color','white'); % Set background color to white
    set(0,'defaulttextinterpreter','latex') % set interpreter to latex
    set(gca,'fontsize',fs) % set default font size
    box on
    set(gca, 'XTick', [ 0 , tb],'xticklabel',{'0','$t_b$'},...
             'YTick', [ 1 , Ab],'yticklabel',{'$1$','$A_b$'},...
             'ticklabelinterpreter','latex',...
             'xgrid','on')
%     leg = legend('$t_1$','$t_2$','$t_3$','\textbf{$t_b$}');
%     set(leg,'Interpreter','latex','FontSize',fs,'box','off',...
%             'position',[0.62 0.5301 0.2301 0.3228])
    
savePlot(fh,'BC_wave',w,h)