clear;close all;clc

addpath([pwd,'/sub_functions'])

% ----- plot window z-vs-t -----
zrng = [0,1];
trng = [-2,1];

% ----- plot parameters -----
fs   = 10;
w    = 3;
h    = 4;
n    = 16;
p    = struct;
p.m  = [1,4]; % line slope
p.lw = 1; % linewidth
p.c  = [0,0,0]; % line color
p.x0 = 0; % intersection point 
p.y0 = 0;

fh = figure;
ah1 = subplot(4,1,1:3);
x1 = [0,0.25,0.75,0.6666,0];
y1 = [0,1   ,1   ,0.6666,0];
myPoly(x1,y1,n,p,fh.Number)

n = 2;
p.x0 = 0.5; % intersection point 
p.y0 = 0;
p.m  = [4,2]; % line slope
x2 = [0.5,0.75,1,0.5];
y2 = [0,1,1,0];
myPoly(x2,y2,n,p,fh.Number)

p.m = 4;
n = 4;
x3 = [0,0,0.25,0];
y3 = [0,1,1,0];
myPoly(x3,y3,n,p,fh.Number)
% % 
% % 
p.m = 2;
n = 4;
x4 = [ 0,0,0.6666,0.5, 0];
y4 = [-1,0,0.6666,0  ,-1];
myPoly(x4,y4,n,p,fh.Number);

p.m = 4;
n = 8;
x5 = [ 0,0.5, 1, 1, 0];
y5 = [-2,  0, 1,-2,-2];
myPoly(x5,y5,n,p,fh.Number);

p.m = [2,4];
x6 = [0,0.5,0,0];
y6 = [-1,0,-2,-1];
myPoly(x6,y6,n,p,fh.Number)

set(ah1,'xlim',zrng,...
        'ylim',trng,...
        'TickLabelInterpreter','latex',...
        'xtick',[],...'xticklabel',{'0'},'xgrid','on',...
        'ytick',[-2 0],'yticklabel',[{'0'},{''}],'ygrid','on',...
        'box','on',...
        'GridAlpha',0.3,'LineWidth',1.5);
xlabel('z','fontsize',fs,'interpreter','latex')
ylabel('t','fontsize',fs,'interpreter','latex')

text(0.73,0.8,'DSW','interpreter','latex',...
                     'fontsize',fs)

ah2 = subplot(4,1,4);
plot([0,0.02,0.02,0.5,0.5,1],...
     [0.25,0.25,0.75,0.75,0.25,0.25],'k')        
xlabel('z','fontsize',fs,'interpreter','latex')
ylabel('A','fontsize',fs,'interpreter','latex')  
set(ah2,'xlim',[0,1],'ylim',[0,1],...
        'xtick',[],'ytick',[])
    
    
savePlot(fh,'char_box',w,h)