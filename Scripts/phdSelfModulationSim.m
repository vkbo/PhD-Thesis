
%
% Plasma Regimes
%

oData = OsirisData;

fMain = figure(40); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 480]);

aAxes(1) = axes('Units','Pixels','Position',[55 288 736 164]);
aAxes(2) = axes('Units','Pixels','Position',[55  48 736 164]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

oData.Path = '/data/SimData/S-Series/PPE-S01';

axes(aAxes(1));
fPlotParticleDensity(oData,0,'PB','Limits',[40 316 -1 1],'IsSubplot','Yes','HideDump','Yes');
hT = get(gca,'Title');
set(hT,'FontWeight','Normal');

axes(aAxes(2));
fPlotParticleDensity(oData,30,'PB','Limits',[40 316 -1 1],'IsSubplot','Yes','HideDump','Yes');
hT = get(gca,'Title');
set(hT,'FontWeight','Normal');


fMain = figure(41); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 370]);

aAxes(1) = axes('Units','Pixels','Position',[55 48 740 300]);

axes(aAxes(1));
fPlotParticleDensity(oData,42,'PB','Limits',[150 315 -1 1],'IsSubplot','Yes','ShowOverlay','No','HideDump','Yes');
caxis([0 15])
hT = get(gca,'Title');
set(hT,'FontWeight','Normal');
