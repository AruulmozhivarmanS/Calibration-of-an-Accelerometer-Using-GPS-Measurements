function [truePavg, errorDifferences] = computeTrueErrorCovarianceAverages(stateErrors, stateErrorAverages)
    len = size(stateErrors);
    truePavg = zeros(3, 3, len(2));

    errorDifferences = zeros(size(stateErrors));

    for i = 1: len(2)
        for j = 1: len(3)
            err = (stateErrors(:, i, j) - stateErrorAverages(:, i));
            errorDifferences(:, i, j) = err;
            truePavg(:, :, i) = truePavg(:, :, i) + (err * err.');
        end
    end

    truePavg = truePavg / ( len(3) - 1);

%     for i = 1:len(2)
%         truePavg(:, :, i) = cov(stateErrors(:, :, i).');
%     end
    
end

