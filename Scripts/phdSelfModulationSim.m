
%
% Plasma Regimes
%

oData = OsirisData;

fMain = figure(40); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 640]);

aAxes(1) = axes('Units','Pixels','Position',[55 368 736 244]);
aAxes(2) = axes('Units','Pixels','Position',[55  48 736 244]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

oData.Path = '/data/SimData/S-Series/PPE-S01';

axes(aAxes(1));
fPlotParticleDensity(oData,0,'PB','Limits',[40 315 -1 1],'IsSubplot','Yes','HideDump','Yes');
hT = get(gca,'Title');
set(hT,'FontWeight','Normal');

axes(aAxes(2));
fPlotParticleDensity(oData,42,'PB','Limits',[40 315 -1 1],'IsSubplot','Yes','HideDump','Yes');
caxis([0 15])
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

% Wavelet

fMain = figure(42); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 580]);

aAxes(1) = axes('Units','Pixels','Position',[95 172 620 380]);
aAxes(2) = axes('Units','Pixels','Position',[95  48 620 120]);

oDN      = Density(oData,'PB','Units','SI','Scale','mm');
oDN.Time = 42;
stWL     = oDN.Wavelet([3 425], 'Octaves', 7);
aData    = stWL.Real;
cLine    = lines;

% Input data plot

axes(aAxes(2));
plot(stWL.HAxis, stWL.Input, 'Color', cLine(3,:));
xlim([20 315]);
ylim([0 1.02*max(stWL.Input)]);

xlabel('\xi [mm]');
ylabel('Amplitude');

% Wavelet plot

axes(aAxes(1));
imagesc(stWL.HAxis, log2(stWL.Period), aData);
caxis([-0.2, 0.2]);

xlim([20 315]);

aYTicks = 2.^(fix(log2(min(stWL.Period))):fix(log2(max(stWL.Period))));
set(gca, 'YDir',  'Reverse');
set(gca, 'YLim',  log2([min(stWL.Period),max(stWL.Period)]));
%set(gca, 'YTick', log2(aYTicks(:)), 'YTickLabel', aYTicks);
set(gca, 'YTick', log2(aYTicks(:)), 'YTickLabel', {'1/32','1/16','1/8','1/4','1/2','1','2'});

cRed  = [linspace(0.850,1.000,256); linspace(0.325,1.000,256); linspace(0.098,1.000,256)]';
cBlue = [linspace(0.000,1.000,256); linspace(0.447,1.000,256); linspace(0.741,1.000,256)]';
cMap  = [cRed; flipud(cBlue)];
colormap(cMap);
colorbar;

hold on;
plot(stWL.HAxis, log2(stWL.COI), 'Black', 'LineWidth', 2);
hold off;

set(gca, 'XTickLabel', []);
%xlabel('\xi [mm]', 'FontSize', 12);
ylabel('Period [\lambda_p]', 'FontSize', 12);
title('Wavelet Analysis of Proton Beam at 2.96 m Into Plasma');

aPos2 = get(aAxes(2),'Position');
aPos1 = get(aAxes(1),'Position');
aPos1(3) = aPos2(3);
set(aAxes(1),'Position',aPos1);
