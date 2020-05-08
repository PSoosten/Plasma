function [] = Pic(NParticles, NGridPoints, NFourierModes, SamplingMethod, ...
                  FieldMethod, Type, Alpha, K, Nt, dt, ShowParticles, ...
                  MkMovie, MovieFile)
    tic;
    L = 2*pi/K;
    
    if ShowParticles
        figure('Tag', 'Particles');
    end

    if MkMovie
        MWHandle = VideoWriter(MovieFile, 'MPEG-4');
        MWHandle.FrameRate = 30;
        MWHandle.Quality = 100;
        MWHandle.open;
    end


    % Store the electric energy at each step
    EEnergy = zeros(1, Nt);


    % Create particles
    if strcmp(Type, 'Landau Damping')
        [X, V, FNaught, GZero, EY, EYHat] ...
            = LandauDamping(NParticles, NGridPoints, NFourierModes, Alpha, K, L, SamplingMethod);
    elseif strcmp(Type, 'Two Stream Instability')
        [X, V, FNaught, GZero, EY, EYHat] ...
            = TwoStreamInstability(NParticles, NGridPoints, NFourierModes, Alpha, K, L, SamplingMethod);
    elseif strcmp(Type, 'Bump on Tail')
        [X, V, FNaught, GZero, EY, EYHat] ...
        = BumpOnTail(NParticles, NGridPoints, NFourierModes, Alpha, K, L, SamplingMethod);
    else
        disp('Wrong option');
    end


    % Loop through time-steps
    for m=1:Nt
        % Compute Weight
        Weight = 1 - FNaught(X, V)./GZero;

        % Calculate Electric Field
        if strcmp(FieldMethod, 'Spectral')
            [EField, EEnergy(m)] = EFieldSpectral(X, L, NFourierModes, Weight, EYHat);
        elseif strcmp(FieldMethod, 'Linear')
            [EField, EEnergy(m)] = EFieldLinear(X, L, NGridPoints, NParticles, Weight, EY);
        else
            disp('Wrong option');
        end

        % Move particles
        V = V - EField*0.5*dt;
        X = mod(X + V*dt, L);
        V = V - EField*0.5*dt;

        % Show particles/make movie
        if ShowParticles
            plot(X, V, '.', 'MarkerSize', 0.1);
            pause(1e-6);
        end
        if MkMovie
            frame = getframe(findobj('Tag', 'Particles'));
            writeVideo(MWHandle, frame);
        end

    end


    % Plot log of electric energy
    figure('Tag', 'Energy');
    semilogy((1:Nt)*dt, EEnergy);
    title(sprintf('%0.0e Particles with %s Interpolation & %s Method in %0.1f seconds', ...
                   NParticles, FieldMethod, SamplingMethod, toc));

    if MkMovie
        for k = 1:90
            frame = getframe(findobj('Tag', 'Energy'));
            writeVideo(MWHandle, frame);
        end
        MWHandle.close;
    end
end

