function [stateErrorAverages, truePavg, productErrDiffStateEst, residualProduct] = monteCarloAnalysis(trueStates, posterioriStateEstimates, accF, gpsF, prioriStateEstimates, H, measurements)    
    stateErrors = trueStates(:, 1: accF/gpsF: end, :) - posterioriStateEstimates;
    stateErrorAverages = mean(stateErrors, 3);
    
    [truePavg, errorDifferences] = computeTrueErrorCovarianceAverages(stateErrors, stateErrorAverages);
    [productErrDiffStateEst, residualProduct] = checkOrthogonality(errorDifferences, posterioriStateEstimates, prioriStateEstimates, H, measurements);
end

