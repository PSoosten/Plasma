function [X, V, FNaught, GZero, EY, EYHat] ...
            = BumpOnTail(NParticles, NGridPoints, NFourierModes, Alpha, K, L, Method)
    %V ~ (9/10)N(0,1) + (1/10)N(4.5, 0.5)
    U = rand(1, NParticles);
    V = [sqrt(-2*log(U(1:(NParticles/2)))).*cos(2*pi*U((NParticles/2 + 1):NParticles)), ...
         sqrt(-2*log(U(1:(NParticles/2)))).*sin(2*pi*U((NParticles/2 + 1):NParticles))];
    
    T = rand(1, NParticles) < 0.1;
    Mu = 4.5*T;
    Sig = 1 - 0.5*T;
    V = Sig.*V + Mu;
    
    % X ~ 1 + eps*cos(k*x)
    X = [];
    f = @(x) (1 + eps*cos(K*x))/(1+eps);
    while NParticles ~= 0
        U = rand(1, NParticles);
        XDraw = L*rand(1, NParticles);
        XDraw = XDraw(U <= f(XDraw));
        X = [X XDraw];
        NParticles = NParticles - numel(XDraw);
    end
    
    FZero = @(X, V) (1 + Alpha*cos(K*X)).* ...
        (0.9*exp(-0.5*V.^2) + 0.2*exp(-2*(V - 4.5).^2)) / sqrt(2*pi);
    if strcmp(Method, 'Full F')
        FNaught = FZero;
        GZero = FZero(X, V);
        EY = (1 + Alpha*cos(K*(0:(L/NGridPoints):(L-L/NGridPoints))));
        EYHat = [-K*Alpha; zeros(NFourierModes - 1, 1)];
    elseif strcmp(Method, 'Delta F')
        FNaught = @(X, V) ...
            (0.9*exp(-0.5*V.^2) + 0.2*exp(-2*(V - 4.5).^2)) / sqrt(2*pi);
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

