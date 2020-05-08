function [X, V, FNaught, GZero, EY, EYHat] ...
            = LandauDamping(NParticles, NGridPoints, NFourierModes, Alpha, K, L, Method)
    % V ~ N(0,1)
    U = rand(1, NParticles);
    V = [sqrt(-2*log(U(1:(NParticles/2)))).*cos(2*pi*U((NParticles/2 + 1):NParticles)), ...
         sqrt(-2*log(U(1:(NParticles/2)))).*sin(2*pi*U((NParticles/2 + 1):NParticles))];
    
    % X ~ 1 + eps*cos(k*x)
    X = [];
    f = @(x) (1 + Alpha*cos(K*x))/(1+Alpha);
    while NParticles ~= 0
        U = rand(1, NParticles);
        XDraw = L*rand(1, NParticles);
        XDraw = XDraw(U <= f(XDraw));
        X = [X XDraw];
        NParticles = NParticles - numel(XDraw);
    end
    
    FZero = @(X, V) (1 + Alpha*cos(K*X)).* exp(-0.5*V.^2) / sqrt(2*pi);
    if strcmp(Method, 'Full F')
        FNaught = FZero;
        GZero = FZero(X, V);
        EY = (1 + Alpha*cos(K*(0:(L/NGridPoints):(L-L/NGridPoints))));
        EYHat = [-K*Alpha; zeros(NFourierModes - 1, 1)];
    elseif strcmp(Method, 'Delta F')
        FNaught = @(X, V) (exp(-0.5*V.^2)/sqrt(2*pi));
        GZero = FZero(X, V);
        EY = 1;
        EYHat = 0;
    elseif strcmp(Method, 'Simple')
        FNaught = @(X,V) 0;
        GZero = 1;
        EY = 0;
        EYHat = 0;
    else
        disp('Wrong option');
    end
end

