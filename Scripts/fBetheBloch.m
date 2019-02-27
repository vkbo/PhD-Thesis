function fBetheBloch(e0)

    Na = 6.02214076e23;
    re = 2.8179403227e-15;
    me = 0.5109989461e6;
    c  = 299792458;
    
    % Material
    mRho = 1.18;
    nAb  = 3;
    aRat = [0.78, 0.21, 0.01];
    abZ  = [7.00, 8.00, 18.0];
    abA  = [14.0, 16.0, 39.95];
    abI  = [13*7, 12*8, 10*18];
    %mRho = 997;
    %nAb  = 2;
    %aRat = [0.09, 0.91];
    %abZ  = [1.00, 8.00];
    %abA  = [1.00, 16.0];
    %abI  = [19, 12*8];
    
    % Beam
    zBm  = 2;
    mBm  = 3.727379378e9;
    %zBm  = 1;
    %mBm  = 938e6;
    %zBm  = 6;
    %mBm  = 11188.18e6;
    %e0   = 5.48e6;

    % Range
    dMax = 180e-3;
    dX   = 10e-6;
    
    nX = ceil(dMax/dX+1);
    x  = linspace(0,dMax,nX);
    dE = zeros(1,nX);
    mV = zeros(1,nX);
    
    for i=1:nX
        mV(i) = sqrt(2*(e0-sum(dE(1:i)))/mBm);
        if(mV(i) <= 0)
            continue
        end % if
        for j=1:nAb
            tE = 4*pi*re^2*me * mRho*Na*abZ(j)/abA(j)*1e3 * zBm^2/mV(i)^2;
            tE = tE * (log(2*me*mV(i)^2/abI(j)) - mV(i)^2/c^2);
            dE(i) = dE(i) + aRat(j)*tE*dX;
        end % for
    end % for
    plot(x*100, dE/mRho/dX*1e-8,'LineWidth',1.5);
    xlim([0,4.5]);
    ylim([0,2.75]);
    xlabel('Distance in Air [cm]');
    ylabel('Stopping Power [MeV/cm]');
    %title('Bragg Peak: 5.48 MeV Alpha Particle');
    %plot(x, dE/max(dE));
    %plot(x, mV);

end % function
