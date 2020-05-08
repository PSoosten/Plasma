clear all; clc;

% Precision
NParticles = 1000;
NGridPoints = 512;
NFourierModes = 10;

% Densities
Type = 'Landau Damping';
Alpha = 0.01;
K = 0.5;

% Time steps
Nt = 500;
dt = 0.1;

% Graphics
ShowParticles = false;
MkMovie = false;
MovieFile = 'Landau Damping';

SamplingMethod = 'Full F';
FieldMethod = 'Linear';
Pic(NParticles, NGridPoints, NFourierModes, SamplingMethod, ...
    FieldMethod, Type, Alpha, K, Nt, dt, ShowParticles, ...
    MkMovie, MovieFile);
FieldMethod = 'Spectral';
Pic(NParticles, NGridPoints, NFourierModes, SamplingMethod, ...
    FieldMethod, Type, Alpha, K, Nt, dt, ShowParticles, ...
    MkMovie, MovieFile);

SamplingMethod = 'Delta F';
FieldMethod = 'Linear';
Pic(NParticles, NGridPoints, NFourierModes, SamplingMethod, ...
    FieldMethod, Type, Alpha, K, Nt, dt, ShowParticles, ...
    MkMovie, MovieFile);
FieldMethod = 'Spectral';
Pic(NParticles, NGridPoints, NFourierModes, SamplingMethod, ...
    FieldMethod, Type, Alpha, K, Nt, dt, ShowParticles, ...
    MkMovie, MovieFile);