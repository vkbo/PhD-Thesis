
%
% Plot: Plasma Density Simulations X
%

oData = OsirisData('Silent','Yes');

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 380]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

ax1 = axes('Units','Pixels','Position',[52 45 595 305]);
oData.Path = 'PPE-X07A';
fPlotPlasmaDensity(oData,30,'PE', ...
    'IsSubPlot','Yes','AutoResize','Off','HideDump','Yes','Absolute','Yes', ...
    'Scatter1','PB','Scatter2','EB', ...
    'Sample1',500,'Sample2',500, ...
    'Overlay1','PB','Overlay2','EB', ...
    'Filter1','WRandom','Filter2','WRandom', ...
    'E1',[3 3],'W2',[3 3], ...
    'Limits',[0 3 -0.6 0.6]);
%title('');
