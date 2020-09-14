# Plasma
A Monte-Carlo (particle-in-cell) method for a Vlasov-Poisson equation arising in plasma physics

This repository consists of code that I wrote for [this class](https://www-m16.ma.tum.de/Allgemeines/MonteCarloMeth). Further details on the relevant algorithms and mathematical background can be found by following the link.

The files `Test.m`, `TestDensities.m`, `TestLandau1e3.m`, and `TestLandau1e5.m` show how to use the main function `Pic()` with various settings to produce videos of the evolution of the Monte-Carlo particles and plots of the corresponding energies.

The implementation is contained in the `/src` directory. The file `Pic.m` implements the particle-in-cell method. `EFieldLinear.m` and `EFieldSpectral.m` provide two Poisson-solvers to update the electric fields. The files `LandauDamping.m`, `BumpOnTail.m`, and `TwoStreamInstability.m` prepare different initial densities which illustrate the stability or instability of the solution.

The video `Two Stream Instability.mp4` is a sample output video of the particle dynamics.
