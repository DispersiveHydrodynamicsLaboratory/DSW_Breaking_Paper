clear;close all;clc

addpath([pwd,'/sub_functions'])

% ----- plot window z-vs-t -----
zrng = [0,1];
trng = [-1,1];

% ----- plot parameters -----
fs   = 8;
w    = 2.5;
h    = 3;
n    = 10;
p    = struct;
p.m  = [1,2]; % line slope
p.lw = 1; % linewidth
p.c  = [0,0,0]; % line color
p.x0 = 0.5; % intersection point 
p.y0 = 0;

fh = figure;
subplot(4,1,1:3)
x1 = [0,0.5,0,0];
y1 = [-0.5,0,-1,-0.5];
myPoly(x1,y1,n,p,fh.Number)

n = 2;
p.x0 = 0.5; % intersection point 
p.y0 = 0;
p.m  = [1,2]; % line slope
xcurv = linspace(0,0.5,10);
ycurv = exp(2*xcurv) + p.y0-1;
ind = find(ycurv > 1,1);
xcurv = xcurv(1:ind)+0.5;
ycurv = ycurv(1:ind);
plot(xcurv+0.5,ycurv,'r.')
x2 = [xcurv, 1,  1,0.5];
y2 = [ycurv, 1,0.25,  0];
myPoly(x2,y2,n,p,fh.Number)

n = 12;
p.x0 = 0; % intersection point 
p.y0 = -0.5;
p.m  = [1,2]; % line slope
x3 = [0   ,0.75,fliplr(xcurv), 0];
y3 = [-0.5,1   ,fliplr(ycurv),-0.5];
myPoly(x3,y3,n,p,fh.Number)                

n    = 6;
p.m  = 2; % line slope
x4 = [0,0,0.75,0];
y4 = [-0.5,  1,1,-0.5];
myPoly(x4,y4,n,p,fh.Number)  

n = 7;
p.m = 2;
x5 = [0,0.5,1,1,0];
y5 = [-1, 0,0.25,-1,-1];
myPoly(x5,y5,n,p,fh.Number)  

set(gca,'xlim',zrng,...
        'ylim',trng,...
        'TickLabelInterpreter','latex',...
        'xtick',[],...'xticklabel',{'0'},'xgrid','on',...
        'ytick',[-1 0],'yticklabel',[{'0'},{''}],'ygrid','on',...
        'box','on',...
        'GridAlpha',0.3,'LineWidth',p.lw);
    
xlabel('$z$','fontsize',fs,'interpreter','latex')
ylabel('$t$','fontsize',fs,'interpreter','latex') 
text(0.8,0.6,'DSW','interpreter','latex',...
                     'fontsize',fs)

ah2 = subplot(4,1,4);
plot([ 0.00, 0.25, 0.5, 0.5, 1.00],...
     [ 0.25, 0.25, 0.75, 0.25, 0.25],'k')
xlabel('$z$','fontsize',fs,'interpreter','latex')
ylabel('$A$','fontsize',fs,'interpreter','latex')  
set(ah2,'xlim',[0,1],'ylim',[0,1],...
        'xtick',[],'ytick',[])

savePlot(fh,'char_triangle',w,h)
