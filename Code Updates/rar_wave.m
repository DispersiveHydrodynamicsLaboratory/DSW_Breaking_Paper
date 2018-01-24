
% Purpose: This script generates a plot of the rarefaction wave solution 
%          and of the inverse rarefaction wave solution to the Inviscid 
%          Burgers Equation
%
% Author:    Dalton Anderson
% Date:      April 2016
%__________________________________________________________________________

clear; close all;clc
fs   = 8;
w    = 2;
h    = 2;
lw = 0.1;
lc = {'r','b',[0,0.5,0],'k'};
ls = {'--',':','-.','-'};

fh = figure;hold on;
    plot([0 , 0.5 ,3.5 ,10],[8,8,2,2]-0.3,ls{1},'color',lc{1},'linewidth',lw)
    plot([0 , 2.0 ,4.0 ,10],[8,8,2,2]-0.2,ls{2},'color',lc{2},'linewidth',lw)
    plot([0 , 3.5 ,4.5 ,10],[8,8,2,2]-0.1,ls{3},'color',lc{3},'linewidth',lw)
    plot([0 , 5.0 ,5.0 ,10],[8,8,2,2],ls{4},'color',lc{4},'linewidth',lw)
    
%     text(1,1,'$t_1<t_2<t_3<t_b$','interpreter','latex','fontsize',fs)
    
    
    axis([0 10 0 10])
%     set(gca, 'units', 'inches', 'pos', [2 2 3 3])
    set(gcf,'Color','white'); % Set background color to white
    set(0,'defaulttextinterpreter','latex') % set interpreter to latex
    set(gca,'fontsize',fs) % set default font size
    box on
    set(gca, 'XTick', [3.5 , 5.0],'xticklabel',{'0','$z_b$'},...
             'YTick', [2.0 , 8.0],'yticklabel',{'1','$A_b$'},...
             'ticklabelinterpreter','latex',...
             'xgrid','on')
    leg = legend('$t_1$','$t_2$','$t_3$','\textbf{$t_b$}');
    set(leg,'Interpreter','latex','FontSize',fs,'box','off',...
            'position',[0.62 0.5301 0.2301 0.3228])
    
savePlot(fh,'inv_rw',w,h)