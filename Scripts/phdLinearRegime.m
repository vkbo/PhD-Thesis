
%
% Reproduces Plot 7 in Karsouleas 1987
%

dKp = 0.2;
aA  = [0.001 0.01 0.1 0.5 1 2]/dKp;
%aA  = [0.4 0.7 1.0 1.4 2.0]/dKp;
aR  = linspace(0,15,301);
aY  = zeros(301,numel(aA));
aZ  = zeros(301,1);

fMain = figure(1); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 350]);
cLegend = {'','','','',''};

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

for j=1:numel(aA)
    for i=1:numel(aR)

        dR = aR(i);
        dA = aA(j);

        if dR < dA
            aY(i,j) = 1 - dKp*dA * besselk(1,dKp*dA) * besseli(0,dKp*dR);
        else
            aY(i,j) =     dKp*dA * besseli(1,dKp*dA) * besselk(0,dKp*dR);
        end % if
        
        if j == 1
            aZ(i) = dKp^2 * dR^2 * (0.0597 - log2(dKp*dR));
        end % if

    end % for
    
    aY(:,j) = aY(:,j)/aY(1,j);
    cLegend{j} = sprintf('%.3f k_{pe}a', aA(j)*dKp);

end % for

plot(aR*dKp,aY,'LineWidth',1.5);
legend(cLegend);
xlabel('k_{pe}r');
ylabel('R(r)/R(0)');

fMain = figure(2); clf;
fMain.Units = 'Pixels';
fFigureSize(fMain,[650 350]);
cLegend = {'','','','',''};

set(fMain,'defaultUicontrolFontName','DejaVu Sans');
set(fMain,'defaultUitableFontName','DejaVu Sans');
set(fMain,'defaultAxesFontName','DejaVu Sans');
set(fMain,'defaultTextFontName','DejaVu Sans');
set(fMain,'defaultUipanelFontName','DejaVu Sans');

aR  = linspace(0.0,0.5,201)/dKp;
aZ  = zeros(201,1);

for i=1:numel(aR)

    dR = aR(i);

    aZ(i) = dKp^2 * dR^2 * (0.0597 - log2(dKp*dR));

end % for

plot(aR*dKp,aZ,'LineWidth',1.5);

