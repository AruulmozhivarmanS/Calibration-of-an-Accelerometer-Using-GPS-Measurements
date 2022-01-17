function [productErrDiffStateEst, residualProduct] = checkOrthogonality(errorDifferences, posterioriStateEstimates, prioriStateEstimates, H, measurements)
    len = size(errorDifferences);
    productErrDiffStateEst = zeros(3, 3, len(2));
    for i = 1:len(2)
        for j = 1:len(3)
            prd = errorDifferences(:, i, j) * posterioriStateEstimates(:, i, j).';
            productErrDiffStateEst(:, :, i) = productErrDiffStateEst(:, :, i) + prd;
        end
    end
    
    productErrDiffStateEst = productErrDiffStateEst / len(3);
    residualProduct = zeros(2, 2);

    for i = 1:len(3)
        residual80 = measurements(:, 80, i) - H * prioriStateEstimates(:, 3161, i);
        residual120 = measurements(:, 120, i) - H * prioriStateEstimates(:, 4761, i);
        residualProduct = residualProduct + (residual120 * residual80.');
    end

    residualProduct = residualProduct / len(3);
end

