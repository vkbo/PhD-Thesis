
%
% Plasma Regimes
%

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 380]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

%aAxes(1) = axes('Units','Pixels','Position',[65  55 580 200]);
%aAxes(2) = axes('Units','Pixels','Position',[65 270 580 200]);

cRed  = [linspace(0.850,0.850,256); linspace(0.325,1,256); linspace(0.098,1.000,256)]';
cBlue = [linspace(0.000,1.000,256); linspace(0.447,1.000,256); linspace(0.741,1.000,256)]';
cMap  = [cRed; flipud(cBlue)];
cLine = lines(7);

load('/home/vkbo/Work/PhD Thesis/Scripts/SMI-Rieger.mat');

xMin = -197.3333;
xMax =    0.0000;
yMin =   -1.6146;
yMax =    2.0625;
cMin =    4.8083;
cMax =    7.5977;

aData = fliplr(transpose(aRaw))/max(aRaw(:)) * (cMax-cMin) + cMin;
xAxis = linspace(xMin,xMax,size(aRaw,1));
yAxis = linspace(yMin,yMax,size(aRaw,2));

imagesc(xAxis, yAxis, aData);
%colormap(flipud(cBlue));
colormap('hot');
colorbar;
ylim([-1.5 1.5]);
xlabel('t [ps]');
ylabel('x [mm]');
