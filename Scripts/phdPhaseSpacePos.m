
oData = QPICData;

aTime = 1:1:1001;

oData.Path = 'PPE-Q24A';
dLFac  = oData.Config.Convert.SI.LengthFac;
dTStep = oData.Config.Simulation.TimeStep;
dEMass = oData.Config.Constants.EV.ElectronMass;

aAxis = linspace(aTime(1), aTime(end), numel(aTime))*dTStep*dLFac;

%clear aStd;

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[700 250]);
cLegend = {'','','','',''};

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

for i=1:numel(aTime)

    aRaw  = oData.Data(aTime(i),'RAW','','EB01','');
    aRawA = aRaw;
    aRawB = aRaw;
    aRawA(aRawA(:,1) < 1.40e-3/dLFac | aRawA(:,1) > 1.42e-3/dLFac,:) = [];
    aRawB(aRawB(:,1) < 1.55e-3/dLFac | aRawB(:,1) > 1.57e-3/dLFac,:) = [];

    aStd(1,i) = std(aRawA(:,2))*dLFac*1e6;
    aStd(2,i) = std(aRawB(:,2))*dLFac*1e6;
    aStd(3,i) = fMatchedBeam(2e-6,'',7e20,mean(aRawB(:,4)),'')*1e6;

    %clf;
    
    %hold on;
    %plot(aAxis(1:i),aStd(1,1:i),'LineWidth',1.5);
    %plot(aAxis(1:i),aStd(2,1:i),'LineWidth',1.5);
    %plot(aAxis(1:i),aStd(3,1:i),'LineWidth',1.5,'Color',[0,0,0]);
    %hold off;
    
    %xlabel('z [m]');
    %ylabel('RMS(x) [µm]');

    %xlim([aAxis(1) aAxis(end)]);
    %ylim([2 13]);
    
    %legend({'Unmatched','Matched','Theoretical'},'Location','NE');

    %drawnow;

end % for

clf;

hold on;
plot(aAxis,aStd(1,:),'LineWidth',1.5);
plot(aAxis,aStd(2,:),'LineWidth',1.5);
plot(aAxis,aStd(3,:),'LineWidth',1.5,'Color',[0,0,0]);
hold off;

xlabel('z [m]');
ylabel('RMS(r) [µm]');

xlim([0 2.5]);
ylim([3 13]);

legend({'Unmatched','Matched','Theoretical'},'Location','NE');
