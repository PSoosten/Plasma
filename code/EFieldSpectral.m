function [EField, EEnergy] = EFieldSpectral(X, L, NFourierModes, Weight, EYHat)
    Index = (1:NFourierModes).';
    Phase = -(2*pi*1i)/L;
    CModes = bsxfun(@power, exp(Phase*X), Index);
    RhoHat = conj(mean(CModes*diag(sparse(Weight)), 2)) - EYHat;
    EHat = -((Index.^(-1)).*RhoHat)/Phase;
    EField = 2*real(sum(diag(sparse(EHat))*CModes, 1));
    EEnergy = 2*L*sum(abs(EHat).^2);
end