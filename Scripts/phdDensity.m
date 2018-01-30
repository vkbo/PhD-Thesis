
%
% Plasma Regimes
%

oData = QPICData;

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 480]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

aAxes(1) = axes('Units','Pixels','Position',[65  55 580 200]);
aAxes(2) = axes('Units','Pixels','Position',[65 270 580 200]);

cRed  = [linspace(0.850,0.850,256); linspace(0.325,1,256); linspace(0.098,1.000,256)]';
cBlue = [linspace(0.000,1.000,256); linspace(0.447,1,256); linspace(0.741,0.741,256)]';
cMap  = [cRed; flipud(cBlue)];
cLine = lines(7);

cRegime = {'Linear','QuasiLinear', 'NonLinear', 'HighlyNonLinear'};
cTitle  = {'Linear','Quasi-Linear','Non-Linear','Highly Non-Linear'};
cLegend = {'Beam [a.u.]','n_{b}/n_{pe} = 0.05','n_{b}/n_{pe} = 0.8','n_{b}/n_{pe} = 3.0','n_{b}/n_{pe} = 8.0'};

for i=1:numel(cRegime)
    
    oData.Path = sprintf('/home/vkbo/Work/PhD Thesis/Simulations/Regimes/%s', cRegime{i});
    
    dLFac  = oData.Config.Convert.SI.LengthFac;
    dTStep = oData.Config.Simulation.TimeStep;
    dEMass = oData.Config.Constants.EV.ElectronMass;
    dE0    = oData.Config.Convert.SI.E0;
    dB0    = oData.Config.Convert.SI.B0;
    dN0    = oData.Config.Simulation.N0;
    aGrid  = oData.Config.Simulation.Grid;
    aSize  = oData.Config.Simulation.XMax;
    dQBeam = oData.Config.Beam.Beam01.BeamCharge;
    aRes   = aSize./aGrid;
    iZero  = aGrid(2)/2;
    
    aZAxis = linspace(0,aSize(1),aGrid(1))-200e-6;
    aXAxis = linspace(-aSize(2)/2,aSize(2)/2,aGrid(2))*1e3;
    
    aDenPE = oData.Data(1,'Q','','EP01','XZ');
    aDenPB = oData.Data(1,'Q','','EB','XZ');
    aFEZ   = oData.Data(1,'F','EZ','','XZ');
    aFEX   = oData.Data(1,'F','EX','','XZ');
    aFBY   = oData.Data(1,'F','BY','','XZ');
    
    % Calculate beam profiles
    if i == 1
        aProPB = oData.Config.Beam.Beam01.Profile;
        aPAxis = aZAxis(12:75);
        aProPB = 0.6*exp(-aPAxis.^2/(2*(aProPB(1))^2));
    end % if
    
    %dMaxPB
    %min(abs(aDenPE(iZero,:)))
    
    %figure(2)
    %plot(sum(aDenPB,1))
    %plot(aDenPB(iZero,:));
    %plot(aProPB);
    %max(aDenPB(iZero,:))
    %max(aProPB)
    %figure(1)
    
    aLnPE  = -aDenPE(iZero,:);
    
    aLnEZ  = aFEZ(iZero,:)*dE0;
    aLnEX  = (aFEX(iZero+2,:)-aFEX(iZero+1,:))/aRes(2)*dB0;
    aLnBY  = (aFBY(iZero+2,:)-aFBY(iZero+1,:))/aRes(2)*dB0;
    aLnWZ  = aLnEZ/dQBeam;
    aLnWX  = (aLnEX - aLnBY)/dQBeam;
    
    aZAxis = aZAxis/dLFac;
    aPAxis = aPAxis/dLFac;
    
    %aDenPB(aDenPB <  0.0) =  0.0;
    %aDenPE(aDenPE < -4.0) = -4.0;
    %aDenPB(aDenPB >  0.1) =  0.1;
    
    %aDenPE = aDenPE/4.0;
    %aDenPB = aDenPB/0.1;
    
    %aLnEZ = aLnEZ/max(abs(aLnEZ))/2;
    %aLnWX = aLnWX/max(aLnWX)/2;
    
    axes(aAxes(1));
    
    hold on;
    if i == 1
        area(aPAxis,aProPB,'ShowBaseLine','Off','EdgeColor',cLine(i,:),'FaceColor',cLine(i,:));
    end % if
    plot(aZAxis,aLnWZ*1e-18,'Color',cLine(i,:),'LineWidth',1.5);
    hold off;
    
    ylim([-0.9 0.7]);
    yticks([-0.8 -0.6 -0.4 -0.2 0.0 0.2 0.4 0.6]);
    ylabel('W_{z}/Q_{b} [GV/nCm]');
    xlim([aZAxis(1) aZAxis(end)]);
    xlabel('\xi - \xi_{b} [c/\omega_p]');
    
    grid on;
    
    axes(aAxes(2));

    hold on;
    if i == 1
        area([0],[0]);
    end % if
    plot(aZAxis,aLnPE,'Color',cLine(i,:),'LineWidth',1.5);
    hold off;
    
    set(gca,'YScale','Log');
    yticks([1e-2 1e-1 1e0 1e1 1e2]);
    yticklabels([0.01 0.1 1 10 100]);
    ylabel('log(n_{pe}(\xi)/n_{pe,0}) [a.u.]');
    
    xlim([aZAxis(1) aZAxis(end)]);
    %xticks([]);
    %xlabel('\xi [c/\omega_p]');
    
    grid on;
    
    %yticks([]);
    
    %xlabel(sprintf('n_{b}/n_{pe} = %.2f',dMaxPB));
    %title(cTitle{i},'FontWeight','Normal');
    %hL = legend({'E_z','W_\perp'},'Location','NW');
    %set(hL,'Box','Off');
    %set(hL,'TextColor', 'Black');
    
    drawnow;
    
end % for

axes(aAxes(1));
hL = legend(cLegend,'Location','SE');
set(hL,'Box','Off');

axes(aAxes(2));
hL = legend(cLegend,'Location','NE');
set(hL,'Box','Off');
