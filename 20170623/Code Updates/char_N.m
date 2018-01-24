clear;close all;clc

addpath([pwd,'/sub_functions'])

% ----- plot window z-vs-t -----
zrng = [0,1];
trng = [-1,1];
xl = 0.5;
yl = [2.6,0.5];
% ----- plot parameters -----
fs   = 8;
w    = 2.5;
h    = 3;
n    = 8;
p    = struct;
p.m  = [1,2]; % line slope
p.lw = 1; % linewidth
p.c  = [0,0,0]; % line color
p.x0 = 0.6; % intersection point 
p.y0 = 0;

fh = figure;
ah1 = subplot(4,1,1:3);


% shock 1
x1 = [ 0.00, 0.00, p.x0, 0.00];
y1 = [-1.00,-0.75, 0.00,-1.00];
p.m = [ (y1(3)-y1(2))/(x1(3)-x1(2)) , (y1(4)-y1(3))/(x1(4)-x1(3))];
myPoly(x1,y1,n,p,fh.Number)

n = 2;
p.m = [ 0.5*(y1(3)-y1(2))/(x1(3)-x1(2)) , 2*(y1(4)-y1(3))/(x1(4)-x1(3))];
xcurv1 = linspace(0,1-p.x0,20);
ycurv1 = exp(2.5*xcurv1) + p.y0-1;
ind1 = find(ycurv1 > 1,1);
xcurv1 = xcurv1(1:ind1)+p.x0;
ycurv1 = ycurv1(1:ind1);
x2 = [xcurv1, 1,  1   ,p.x0];
y2 = [ycurv1, 1,  p.m(1)*(1-p.x0)-p.y0 , p.y0];
myPoly(x2,y2,n,p,fh.Number)




% shock 2;
p.m = [ (y1(3)-y1(2))/(x1(3)-x1(2)) , (y1(4)-y1(3))/(x1(4)-x1(3))];
n = 8;
p.x0 = 0.25; % intersection point 
p.y0 = 0;
x3 = [ 0.00, 0.00, p.x0, 0.00];
y3 = [-0.75,-max([p.m])*p.x0, 0.00,-0.75];
p.m = [ (y3(3)-y3(2))/(x3(3)-x3(2)) , (y3(4)-y3(3))/(x3(4)-x3(3))];
myPoly(x3,y3,n,p,fh.Number)

% 
n = 2;
xcurv2 = linspace(0,1-p.x0,200);
ycurv2 = log(2*xcurv2+1) + p.y0;
xcurv2 = xcurv2+p.x0;
P = InterX([xcurv1;ycurv1],[xcurv2;ycurv2]);
ind2 = find(xcurv2 > P(1),1);
xcurv2 = xcurv2(1:ind2);
ycurv2 = ycurv2(1:ind2);
ind1 = find(ycurv1>P(2),1);
x4 = [p.x0, (1-p.y0)/p.m(2)/1.5+p.x0, fliplr(xcurv1(ind1:end)), fliplr(xcurv2)];
y4 = [p.y0, 1,                        fliplr(ycurv1(ind1:end)), fliplr(ycurv2)];
myPoly(x4,y4,n,p,fh.Number)



%
n = 12; % rw
p.x0 =  0.00; % intersection point 
p.y0 = -0.75;
p.m = [ (y1(3)-y1(2))/(x1(3)-x1(2)), (y3(4)-y3(3))/(x3(4)-x3(3))];
x5 = [p.x0 , 0.25, xcurv2 , fliplr(xcurv1(1:ind1)), p.x0];
y5 = [p.y0 , 0, ycurv2 , fliplr(ycurv1(1:ind1)), p.y0];

myPoly(x5,y5,n,p,fh.Number) 
plot([0,0.6],[-0.75,0],'k','linewidth',p.lw) % me being lazy


p.m = [ (y3(3)-y3(2))/(x3(3)-x3(2)) , (y3(4)-y3(3))/(x3(4)-x3(3))];
n = 6;
x6 = [ 0 , 0 , 0.4722, 0.25, 0 ];
y6 = [ -0.4167 , 1 , 1 , 0 , -0.4167];
% plot(x6,y6,'r*')
p.m = p.m(1);
myPoly(x6,y6,n,p,fh.Number)

n = 7;
x7 = [ 0 , 0.6 , 1 , 1 , 0];
y7 = [ -1 , 0 , 0.25 , -1 , -1];
myPoly(x7,y7,n,p,fh.Number)




xlabel('$z$','fontsize',fs,'interpreter','latex')
ylabel('$t$','fontsize',fs,'interpreter','latex')    
set(ah1,'xlim',zrng,...
        'ylim',trng,...
        'TickLabelInterpreter','latex',...
        'xtick',[],'xticklabel',{'0'},'xgrid','on',...
        'ytick',[-1 0],'yticklabel',[{'0'},{''}],'ygrid','on',...
        'box','on',...
        'GridAlpha',0.3,'LineWidth',p.lw)
text(0.83,0.6,'DSW','interpreter','latex',...
                     'fontsize',fs)
text(0.5,0.7,'DSW','interpreter','latex',...
                     'fontsize',fs)
    


ah2 = subplot(4,1,4);
plot([ 0.00, 0.25, 0.25, 0.60, 0.60, 1.00],...
     [ 0.50, 0.50, 0.25, 0.75, 0.50, 0.50],'k')
xlabel('$z$','fontsize',fs,'interpreter','latex')
ylabel('$A$','fontsize',fs,'interpreter','latex')  
set(ah2,'xlim',[0,1],'ylim',[0,1],...
        'xtick',[],'ytick',[])


 


    
     
savePlot(fh,'char_N',w,h)
