clear;close all;clc

addpath([pwd,'/sub_functions'])
w = 2;
h = 3;
fs = 8;

fh = figure;clf
hold on
%____________CONDUIT EDGES____________

y = linspace(2,7,200);
a = 4;
y1 = linspace(-1,0,100);
x1 = sech(a*y1)+1.95;
y2 = linspace(0,1,100);
x2 = 2*sech(a*y2)+0.93;

X = [-2,-2,-x1,-x2,-1,-1,...
      1, 1, x1, x2, 2, 2];
Y = [ 0.02, 2, y ,     7, 9.98,...
      9.98, 7, y ,2, 0.02]; 
fill(X,Y,[175,238,238]./255,'edgecolor',[175,238,238]./255)
plot([x1,x2],y,'k','linewidth',2)
plot(-[x1,x2],y,'k','linewidth',2)
plot([-2,-2],[0.02,2],'k','linewidth',2)
plot([ 2, 2],[0.02,2],'k','linewidth',2)
plot([-1,-1],[7,9.98],'k','linewidth',2)
plot([ 1, 1],[7,9.98],'k','linewidth',2)

%____________________________________


%____________ELYPSES_________________
x = linspace(-2,2,100);
a = 4; b = 0.1;
y = sqrt(b*(1-x.^2./a));

X = [x,-x];
Y = [y,-y]+2.5;
fill(X,Y,[106,233,233]./255)
plot(x,y+2.5,'k',x,-y+2.5,'k');

a = 1; b = 0.03;
x = linspace(-1,1,100);
y = sqrt(b*(1-x.^2./a));
X = [x,-x];
Y = [y,-y]+6.7;
fill(X,Y,[106,233,233]./255)
plot(x,y+6.7,'k',x,-y+6.7,'k')
%_____________________________________

%____________PARABOLA_ARROWS__________
x = linspace(-2,2,100);
y = @(X) -X.^2./2.6666+1.5;
plot(x,y(x)+0.5,'k--')
plot([-2,2],[.5,.5],'k--')

arL = 10; arW = 30;
for x = -1.5:0.5:1.5
    arrow([x,0.5],[x,y(x)+0.45],...
      'length',arL,...
      'tipangle',arW)
end

%_____________Lables__________________

text(2.5,3,'$A_b$',...
           'interpreter','latex',...
           'fontsize',fs);
arrow([0,2.5],[2.5,3],'tipangle',0)
       
       
text(1.5,7.2,'$A = 1$',...
           'interpreter','latex',...
           'fontsize',fs);
arrow([0,6.7],[1.5,7.2],'tipangle',0)
       
text(0,7.5,'Int. Fluid',...
           'interpreter','latex',...
           'fontsize',fs,...
           'rotation',90);

text(-3,7.5,'Ext. Fluid',...
           'interpreter','latex',...
           'fontsize',fs,...
           'rotation',90);
       
text(-4,5.5,'$\mu^{(e)}$',...
           'interpreter','latex',...
           'fontsize',fs);  
       
text(-1,5.5,'$\mu^{(i)}$',...
           'interpreter','latex',...
           'fontsize',fs); 
      
text(-4,5,'$\rho^{(e)}$',...
           'interpreter','latex',...
           'fontsize',fs);  
       
text(-1,5,'$\rho^{(i)}$',...
           'interpreter','latex',...
           'fontsize',fs);
       
text(-0.6,0.2,'Flow',...
           'interpreter','latex',...
           'fontsize',fs);
       
       
       
axis([-4.5 4.5 0 10])
set(gca,    'XTick',[],...
            'YTick',[],...
            'fontsize',fs,...
            'box','on');
        
fspec = '-dpng'; res = '-r1000';
savePlot(fh,'conduit',w,h,fspec,res);

        
        

