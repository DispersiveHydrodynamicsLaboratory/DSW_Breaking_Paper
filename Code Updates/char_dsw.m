clear;close all;clc

addpath([pwd,'/sub_functions'])

% ----- plot window z-vs-t -----
zrng = [0,1];
trng = [0,1];

% ----- plot parameters -----
fs   = 8;
w    = 2.5;
h    = 3;
n    = 6;
p    = struct;
p.m  = [1,0.5]; % line slope
p.lw = 1; % linewidth
p.c  = [0,0,0]; % line color
p.x0 = 0.5; % intersection point 
p.y0 = 0.5;

fh = figure;
ah1 = subplot(4,1,1:3);
x1 = [0,0,0.5,0.5,0];
y1 = [0,0.25,0.5,0.5,0];
myPoly(x1,y1,n,p,fh.Number)


n = 2;
x2 = [0.5,0.85,1,1   ,0.5];
y2 = [0.5,1  ,1,0.6,0.5];
p.m = [(y2(2)-y2(1))/(x2(2)-x2(1)) , (y2(4)-y2(5))/(x2(4)-x2(5))];
myPoly(x2,y2,n,p,fh.Number)

p.m = 0.5;
n = 10;
x3 = [0   ,0,0.85,0.5,0   ];
y3 = [0.25,1,1   ,0.5,0.25];
myPoly(x3,y3,n,p,fh.Number)


p.m = 1;
n = 10;
x4 = [0,0.5,1,1,0];
y4 = [0,0.5,0.6,0,0];
myPoly(x4,y4,n,p,fh.Number);

plot([0,0],[0.01,0.99],'k-','linewidth',2*p.lw)

text(0.75,.7,'DSW','interpreter','latex','fontsize',fs)

set(gca,'xlim',zrng,...
        'ylim',trng,...
        'TickLabelInterpreter','latex',...
        'fontsize',fs,...
        'xtick',[0 0.5],'xticklabel',{'0','$z_b$'},'xgrid','on',...
        'ytick',[0 0.5],'yticklabel',{'0','$t_b$'},'ygrid','on',...
        'box','on',...
        'GridAlpha',0.3,'LineWidth',1.5);
xlabel('$z$','fontsize',fs,'interpreter','latex')
xlabh = get(gca,'XLabel');
set(xlabh,'Position',[ 1 -0.025 -1]);
ylabel('$t$','fontsize',fs,'interpreter','latex')  
ylabh = get(gca,'YLabel');
set(ylabh,'Position',[ -0.025 1 -1]);

% xlabel('$z_b$','fontsize',fs,'interpreter','latex')
% ylabel('t','fontsize',fs,'interpreter','latex')


ah2 = subplot(4,1,4);
plot([0,0.5,0.5,1],...
     [0.75,0.75,0.25,0.25],'k')        
xlabel('$z_b$','fontsize',fs,'interpreter','latex')
ylabel('$A$','fontsize',fs,'interpreter','latex')  
set(ah2,'xlim',[0,1],'ylim',[0,1],...
        'xtick',[0],'xticklabel',{'0'},...
        'ytick',[]);

        
savePlot(fh,'char_dsw',w,h)
