function [] = savePlot(fh,filename,w,h,fspec,res)
%--------------------------------------------------------------------------
% Purpose: REU 2016 figure printer,
%          This function saves a figure given a figure handle 'fh' 
%
% Inputs:  fh  =  figure handle
%          w   =  figure width (in)
%          h   =  figuer height (in)
%
% Author:  Dalton Anderson
% Date:    July 7, 2016
%--------------------------------------------------------------------------
w = w - 0.1;
h = h - 0.1;
% if file name and destination folder not specified
datadir1 = pwd; % current directory
cd('..');
cd('Figures');
datadir2 = pwd;
cd(datadir1);
if nargin < 5
%     fspec = '-dpng'; 
%     res = '-r1000';
    fspec = '-dpdf';
    res = '-r0';
end
 
% set dimensions 
% set(fh,'Units','inches',...
%        'Position',[0,0,w+0.2,h+0.2])
% pos = get(fh,'Position');
% set(fh,'PaperPosition',[0,0,pos(3),pos(4)]);
% set(fh,'PaperUnits','Inches','PaperSize',[w,h])
set(fh,'Units','inches')
pos = get(fh,'position');
set(fh,'Units','inches',...
       'Position',[pos(1),pos(2),w,h],...
       'outerposition',[pos(1)-0.5,pos(2)-0.5,w+1,h+1])
pos = get(fh,'Position');
set(fh,'PaperUnits','Inches',...
       'PaperPosition',[0,0,w,h],...
       'PaperSize',[w,h])
 
% Print figure
print(fh,[datadir1,'/',filename],fspec,res)
print(fh,[datadir2,'/',filename],fspec,res)
end