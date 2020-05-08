clear all; clc;
NParticles = 1000000;
NGridPoints = 512;
NFourierModes = 10;
SamplingMethod = 'Delta F';
Alpha = 0.5;
K = 0.5;
L = 2*pi/K;

[X, V, FNaught, GZero, EY, EYHat] ...
    = LandauDamping(NParticles, NGridPoints, NFourierModes, Alpha, K, L, SamplingMethod);
figure;
hist(X, 100);
title('X Density');
figure;
hist(V, 100);
title('V Density (Landau Damping)');
[X, V, FNaught, GZero, EY, EYHat] ...
    = TwoStreamInstability(NParticles, NGridPoints, NFourierModes, Alpha, K, L, SamplingMethod);
figure;
hist(V, 100);
title('V Density (Two-Stream Instability)');
[X, V, FNaught, GZero, EY, EYHat] ...
    = BumpOnTail(NParticles, NGridPoints, NFourierModes, Alpha, K, L, SamplingMethod);
figure;
hist(V, 100);
title('V Density (Bump on Tail)');

