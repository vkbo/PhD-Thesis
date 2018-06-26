
%
%  Proton Beam Figure
% ********************
%  For IPAC'15 Paper
%

figMain = figure(1); clf;

fFigureSize(figMain,[750 200]);
aM = get(figMain,'Position');

set(figMain,'defaultUicontrolFontName','DejaVu Sans');
set(figMain,'defaultUitableFontName','DejaVu Sans');
set(figMain,'defaultAxesFontName','DejaVu Sans');
set(figMain,'defaultTextFontName','DejaVu Sans');
set(figMain,'defaultUipanelFontName','DejaVu Sans');


% Bottom Figure
oData = OsirisData('Silent','Yes');
oData.Path = 'PPE-U05B';

stReturn.Bottom = fPlotParticleDensity(oData,0,'PB','IsSubPlot','Yes','HideDump','Yes', ...
                                   'ShowOverlay','No','Limits',[4.4 38.2 -0.7 0.7]);
freezeColors;
title('');

ch = findall(gcf,'tag','Colorbar');
delete(ch(1));
aPos1 = get(axTop,'Position');
aPos2 = get(axBtm,'Position');
aPos2(3) = aPos1(3);
set(axBtm,'Position',aPos2);

colormap('gray');
