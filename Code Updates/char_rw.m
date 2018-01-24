clear;close all;clc

addpath([pwd,'/sub_functions'])

% ----- plot window z-vs-t -----
zrng = [0,1];
trng = [0,1];

% ----- plot parameters -----
fs   = 12;
w    = 3;
h    = 4;
n    = 10;
p    = struct;
p.m  = [1,2]; % line slope
p.lw = 1; % linewidth
p.c  = [0,0,0]; % line color
p.x0 = 0; % intersection point 
p.y0 = 0;

fh = figure;
subplot(4,1,1:3)
x1 = [0,0.5,1,0];
y1 = [0,1  ,1,0];
myPoly(x1,y1,n,p,fh.Number)

p.m = 1;
n = 6;
x3 = [0,1,1,0];
y3 = [0,1,0,0];
myPoly(x3,y3,n,p,fh.Number)


p.m = 2;
n = 4;
x4 = [0,0,0.5,0];
y4 = [0,1,1,0];
myPoly(x4,y4,n,p,fh.Number);


set(gca,'xlim',zrng,...
        'ylim',trng,...
        'TickLabelInterpreter','latex',...
        'xtick',[],...'xticklabel',{'0'},'xgrid','on',...
        'ytick',[],...'yticklabel',{'0''},'ygrid','on',...
        'box','on');
    
xlabel('z','fontsize',fs,'interpreter','latex')
ylabel('t','fontsize',fs,'interpreter','latex')

ah2 = subplot(4,1,4);
plot([0,0.02,0.02,1],...
     [0.25,0.25,0.75,0.75],'k')        
xlabel('z','fontsize',fs,'interpreter','latex')
ylabel('A','fontsize',fs,'interpreter','latex')  
set(ah2,'xlim',[0,1],'ylim',[0,1],...
        'xtick',[],'ytick',[])

savePlot(fh,'char_rw',w,h)