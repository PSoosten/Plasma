function [EField, EEnergy] = EFieldLinear(X, L, NGridPoints, NParticles, Weight, EY)
    Q = floor((NGridPoints/L)*X);
    P = (NGridPoints/L)*X - Q;
    
    % This is probably stupid.
    M = sparse(1:NParticles, mod(Q, NGridPoints) + 1, Weight.*(1-P), NParticles, NGridPoints) ...
        + sparse(1:NParticles, mod(Q+1, NGridPoints) + 1, Weight.*P, NParticles, NGridPoints);
    
    Rho = -NGridPoints*full((1/NParticles)*sum(M, 1)) - EY;
    RhoHat = fft(Rho);
    EHat = ((-1i*0.5*L/pi)*([0:((NGridPoints/2)-1) -(NGridPoints/2):-1].^(-1))).*RhoHat;
    EHat(1) = 0;
    Egrid = real(ifft(EHat));
    
    % This is probably stupid.
    M = sparse(1:NParticles, mod(Q, NGridPoints) + 1, (1-P), NParticles, NGridPoints);
    M = M + sparse(1:NParticles, mod(Q+1, NGridPoints) + 1, P, NParticles, NGridPoints);
    EField = (M*(Egrid'));
    EField = EField';
    
    EEnergy = (L/NGridPoints)*sum(Egrid.^2);
end