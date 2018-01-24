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
datadir = pwd; % current directory
if nargin < 5
%     fspec = '-dpng'; 
%     res = '-r1000';
    fspec = '-dpdf';
    res = '-r0';
end
 
% set dimensions 
set(fh,'Units','inches',...
       'Position',[0,0,w+0.2,h+0.2])
pos = get(fh,'Position');
set(fh,'PaperPosition',[0,0,pos(3),pos(4)]);
set(fh,'PaperUnits','Inches','PaperSize',[w,h])
 
% Print figure
print(fh,[datadir,'/',filename],fspec,res)
end