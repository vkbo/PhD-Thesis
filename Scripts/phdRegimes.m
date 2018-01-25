
%
% Plasma Regimes
%

oData = QPICData;

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[800 210]);

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

aAxes(1) = axes('Units','Pixels','Position',[ 10 35 180 150]);
aAxes(2) = axes('Units','Pixels','Position',[210 35 180 150]);
aAxes(3) = axes('Units','Pixels','Position',[410 35 180 150]);
aAxes(4) = axes('Units','Pixels','Position',[610 35 180 150]);
%aAxes(5) = axes('Units','Pixels','Position',[ 10  40 780  40]);

cRed  = [linspace(0.850,0.850,256); linspace(0.325,1,256); linspace(0.098,1.000,256)]';
cBlue = [linspace(0.000,1.000,256); linspace(0.447,1,256); linspace(0.741,0.741,256)]';
cMap  = [cRed; flipud(cBlue)];
cLine = lines(7);

cRegime = {'Linear','QuasiLinear', 'NonLinear', 'HighlyNonLinear'};
cTitle  = {'Linear','Quasi-Linear','Non-Linear','Highly Non-Linear'};

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
    aRes   = aSize./aGrid;
    iZero  = aGrid(2)/2;
    
    aZAxis = linspace(0,aSize(1),aGrid(1))-200e-6;
    aXAxis = linspace(-aSize(2)/2,aSize(2)/2,aGrid(2))*1e3;
    aZAxis = aZAxis/dLFac;
    
    aDenPE = oData.Data(1,'Q','','EP01','XZ');
    aDenPB = oData.Data(1,'Q','','EB','XZ');
    aFEZ   = oData.Data(1,'F','EZ','','XZ');
    aFEX   = oData.Data(1,'F','EX','','XZ');
    aFBY   = oData.Data(1,'F','BY','','XZ');
    
    % Calculate beam profiles
    aProPB = oData.Config.Beam.Beam01.Profile;
    aPosPB = oData.Config.Beam.Beam01.Position;
    dNPB   = oData.Config.Beam.Beam01.NumParticles;
    dMaxPB = double(dNPB)/(2*pi)^(3/2)/prod(aProPB)/dN0;
    aProPB = dMaxPB*exp(-(aZAxis-aPosPB(1)*1e3).^2/(2*(aProPB(1)*1e3)^2));
    
    %dMaxPB
    %min(abs(aDenPE(iZero,:)))
    
    %figure(2)
    %plot(sum(aDenPB,1))
    %plot(aDenPB(iZero,:));
    %plot(aProPB);
    %max(aDenPB(iZero,:))
    %max(aProPB)
    %figure(1)
    
    aLnEZ  = aFEZ(iZero,:)*dE0*1e-6;
    aLnEX  = (aFEX(iZero+2,:)-aFEX(iZero+1,:))/aRes(2)*dB0*1e-3;
    aLnBY  = (aFBY(iZero+2,:)-aFBY(iZero+1,:))/aRes(2)*dB0*1e-3;
    aLnWX  = aLnEX - aLnBY;
    
    aDenPB(aDenPB <  0.0) =  0.0;
    aDenPE(aDenPE < -4.0) = -4.0;
    %aDenPB(aDenPB >  0.1) =  0.1;
    
    aDenPE = aDenPE/4.0;
    aDenPB = aDenPB/0.1;
    
    aLnEZ = aLnEZ/max(abs(aLnEZ))/2;
    aLnWX = aLnWX/max(aLnWX)/2;
    
    axes(aAxes(i));
    
    hold on;
    
    caxis([-1 0]);
    hPE = imagesc(aZAxis,aXAxis,aDenPE);
    colormap(gray);
    freezeColors;
    
    hPB = imagesc(aZAxis,aXAxis,aDenPB);
    colormap(cMap);
    set(hPB,'AlphaData', aDenPB);
    freezeColors;
    
    plot(aZAxis,aLnEZ,'Color',cLine(7,:),'LineStyle','-');
    plot(aZAxis,aLnWX,'Color',cLine(4,:),'LineStyle','-');
    
    hold off;
    
    xticks([]);
    yticks([]);
    xlim([aZAxis(1) aZAxis(end)]);
    ylim([-0.6 0.6]);
    
    %xlabel('c/\omega_p');
    xlabel(sprintf('n_{b}/n_{pe} = %.2f',dMaxPB));
    title(cTitle{i},'FontWeight','Normal');
    hL = legend({'E_z','W_\perp'},'Location','NW');
    set(hL,'Box','Off');
    set(hL,'TextColor', 'Black');
    
    drawnow;
    
end % for

%axes(aAxes(5));

%aRange = linspace(-2,2,800);
%aScale = [aRange;aRange];

%imagesc(aRange,[0,1],aScale);
%colormap(jet);
%set(gca,'XScale','log')
%set(gca,'YTick',[]);
%xticks([-2 -1 0 1 2]);
%xticklabels([0.01 0.1 1 10 100]);



