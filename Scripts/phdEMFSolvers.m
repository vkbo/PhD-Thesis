
%
% Plasma Regimes
%

oData = OsirisData;

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 320]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

aAxes(1) = axes('Units','Pixels','Position',[ 55 50 335 240]);
aAxes(2) = axes('Units','Pixels','Position',[455 50 335 240]);

cRed  = [linspace(0.850,0.850,256); linspace(0.325,1,256); linspace(0.098,1.000,256)]';
cBlue = [linspace(0.000,1.000,256); linspace(0.447,1,256); linspace(0.741,0.741,256)]';
cMap  = [cRed; flipud(cBlue)];

aPos = cubehelix([],1.7,-0.33,1.4,1.2,[0.0,1.0],[0.6,1.0]);
aNeg = cubehelix([],3.4,-0.33,1.4,1.2,[0.0,1.0],[0.6,1.0]);
aMap = [aNeg; flipud(aPos)];
%aMap = [flipud(aNeg); aPos];

axes(aAxes(1));
oData.Path = 'PPE-X15B';
fPlotField2D(oData, 100, 'w2', 'IsSubPlot','Yes', 'Limits',[0.18 1.22 -0.3 0.3], 'CAxis',[-200 200], 'CScale',0.5);
%colorbar('Off');
title('W_r with Yee Solver');

axes(aAxes(2));
oData.Path = 'PPE-X15A';
fPlotField2D(oData, 100, 'w2', 'IsSubPlot','Yes', 'Limits',[0.18 1.22 -0.3 0.3], 'CAxis',[-200 200]);
%colorbar('Off');
title('W_r with 4^{th} Order Solver');

colormap(aMap);
