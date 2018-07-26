
iTimeA = 1;
iTimeB = 1601;
iTimeC = 16001;
iTimeD = 40041;

oData = QPICData;

oData.Path = 'PPE-Q13C';

dLFac  = oData.Config.Convert.SI.LengthFac;
dTStep = oData.Config.Simulation.TimeStep;
dZMax  = oData.Config.Simulation.XMax(1);
aGrid  = oData.Config.Simulation.Grid;
dE0    = oData.Config.Convert.SI.E0;
dN0    = oData.Config.Simulation.N0;
dPos   = oData.Config.Beam.Beam01.Position(1)/dLFac;
dSz    = oData.Config.Beam.Beam01.Profile(1)/dLFac;
dDz    = dZMax/double(aGrid(1))/dLFac;

iMinZ  = round((dPos - dSz*5)/dDz);
iMaxZ  = round((dPos + dSz*5)/dDz);

aDenEBC  = oData.Data(iTimeC,'Q','','EB','XZ');
aDenPEC  = oData.Data(iTimeC,'Q','','EP01','XZ');

aLineEBC = abs(mean(aDenEBC(512:513,:),1));
aLinePEC = abs(mean(aDenPEC(512:513,:),1))*100;

oBeam  = QPICBeam(oData,1,'Units','SI','Scale','mm');

oBeam.Time = iTimeC;
stData  = oBeam.SlicedPhaseSpace('Lim',[iMinZ iMaxZ]);
aEmittC = stData.ENorm;

aLineEBC = aLineEBC(iMinZ:iMaxZ);
aLinePEC = aLinePEC(iMinZ:iMaxZ);

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 350]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

cMap = lines;

hold on;

yyaxis left;
hPE3 = plot(aZAxis,aLinePEC,'Color',cMap(5,:),'LineStyle','-','LineWidth',1.5);
hEB3 = plot(aZAxis,aLineEBC,'Color',cMap(1,:),'LineStyle','-','LineWidth',1.5);

ylabel('Beam [n_{b}/n_{0}] \color[rgb]{0,0,0} & \color[rgb]{0.466,0.674,0.188} Plasma [100\timesn_{pe}/n_{0}]','FontSize',10.5);
ylim([0 300]);

text(1.26,375,'On-Axis Beam','FontSize',12);

yyaxis right;
hEM3 = stairs(aZAxis,aEmittC,'Color',cMap(2,:),'LineStyle','-','LineWidth',1.5);

ylabel('\epsilon_x [µm]','FontSize',10.5);
ylim([0 5.0]);

hold off;

xlabel('\xi [mm]');
xlim([1.25 1.73]);
title('Electron Bunch Slice Emittance after 40m of Plasma');
