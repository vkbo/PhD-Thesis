
%
% Plasma Regimes
%

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[1600 500]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

oData = OsirisData;
oData.Path = 'PPE-S01';

fPlotParticleDensity(oData,42,'PB','IsSubplot','Yes','ShowOverlay','No','Limits',[150 315 -1 1]);
title('')
caxis([0 15])
