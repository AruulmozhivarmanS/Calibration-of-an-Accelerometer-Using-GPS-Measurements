function plotStateOutput(prioriStateEstimates, posterioriStateEstimates, trueStates, timeAcc, timeGPS, trueXs, accXs, accF, gpsF, runNumber, posterioriErrorCovariance, prioriErrorCovariance, truePavg, stateErrorAverages, productErrDiffStateEst)

    prioriStateEstimate = prioriStateEstimates(:, :, runNumber);
    posterioriStateEstimate = posterioriStateEstimates(:, :, runNumber);
    trueState = trueStates(:, :, runNumber);
    trueX = trueXs(:, :, runNumber);
    accX = accXs(:, :, runNumber);
    
    M = prioriErrorCovariance;
    P = posterioriErrorCovariance;
    figure (1)

    plot(timeAcc, trueX(1, :))
    hold on
    plot(timeAcc, (accX(1, :) + prioriStateEstimate(1, :)))
    plot(timeGPS, (accX(1, 1:(accF / gpsF): end) + posterioriStateEstimate(1, :)))
    plot(timeAcc, accX(1, :))

    legend('True', 'Priori Estimate', 'Posteriori Estimate', 'Accelerometer')
    title('Position')
    xlabel('Time (sec)')
    ylabel('Position (m)')
    hold off

    figure (2)


    plot(timeAcc, trueX(2, :))
    hold on
    plot(timeAcc, (accX(2, :) + prioriStateEstimate(2, :)))
    plot(timeGPS, (accX(2, 1:(accF / gpsF): end) + posterioriStateEstimate(2, :)))
    plot(timeAcc, accX(2, :))

    legend('True', 'Priori Estimate', 'Posteriori Estimate', 'Accelerometer')
    title('Velocity')
    xlabel('Time (sec)')
    ylabel('Velocity (m / sec)')
    hold off

    figure (3)

    plot(timeAcc, trueState(3, :))
    hold on
    plot(timeAcc, prioriStateEstimate(3, :))
    plot(timeGPS, posterioriStateEstimate(3, :))
    
    title('Bias')
    xlabel('Time (sec)')
    ylabel('Bias (m / sec^2)')
    legend('True', 'Priori Estimate', 'Posteriori Estimate')
    hold off

    figure (4)

    plot(timeAcc, trueState(1, :))
    hold on
    plot(timeAcc, prioriStateEstimate(1, :))
    plot(timeGPS, posterioriStateEstimate(1, :))

    title('Delta Position')
    xlabel('Time (sec)')
    ylabel('Delta Position (m)')
    legend('True', 'Priori Estimate', 'Posteriori Estimate')
    hold off
    
    figure (5)

    plot(timeAcc, trueState(2, :))
    hold on
    plot(timeAcc, prioriStateEstimate(2, :))
    plot(timeGPS, posterioriStateEstimate(2, :))

    title('Delta Velocity')
    xlabel('Time (sec)')
    ylabel('Delta Velocity (m / sec)')
    legend('True', 'Priori Estimate', 'Posteriori Estimate')
    hold off
    
    figure (6)

    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :))
    hold on
    M1 = squeeze(sqrt(M(1, 1, :)));
    M1 = M1.';

    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :) + M1)
    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :) - M1)
    
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :))
    P1 = squeeze(sqrt(P(1, 1, :)));
    P1 = P1.';
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :) + P1)
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :) - P1)
    title('Delta Position Error')
    xlabel('Time (sec)')
    ylabel('Delta Position Error (m)')
    legend('Priori Error', 'Priori Error +1 sigma', 'Priori Error -1 sigma', 'Posteriori Error', 'Posteriori Error +1 sigma', 'Posteriori Error -1 sigma')
    hold off
    
    figure (6)

    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :))
    hold on
    M1 = squeeze(sqrt(M(1, 1, :)));
    M1 = M1.';

    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :) + M1)
    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :) - M1)
    
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :))
    P1 = squeeze(sqrt(P(1, 1, :)));
    P1 = P1.';
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :) + P1)
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :) - P1)
    title('Delta Position Error')
    xlabel('Time (sec)')
    ylabel('Delta Position Error (m)')
    legend('Priori Error', 'Priori Error +1 sigma', 'Priori Error -1 sigma', 'Posteriori Error', 'Posteriori Error +1 sigma', 'Posteriori Error -1 sigma')
    hold off
    
    figure (6)

    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :))
    hold on
    M1 = squeeze(sqrt(M(1, 1, :)));
    M1 = M1.';

    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :) + M1)
    plot(timeAcc, trueState(1, :) - prioriStateEstimate(1, :) - M1)
    
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :))
    P1 = squeeze(sqrt(P(1, 1, :)));
    P1 = P1.';
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :) + P1)
    plot(timeGPS, trueState(1, 1:(accF / gpsF): end) - posterioriStateEstimate(1, :) - P1)
    title('Delta Position Error')
    xlabel('Time (sec)')
    ylabel('Delta Position Error (m)')
    legend('Priori Error', 'Priori Error +1 sigma', 'Priori Error -1 sigma', 'Posteriori Error', 'Posteriori Error +1 sigma', 'Posteriori Error -1 sigma')
    hold off
    
    figure (7)

    plot(timeAcc, trueState(2, :) - prioriStateEstimate(2, :))
    hold on
    M2 = squeeze(sqrt(M(2, 2, :)));
    M2 = M2.';

    plot(timeAcc, trueState(2, :) - prioriStateEstimate(2, :) + M2)
    plot(timeAcc, trueState(2, :) - prioriStateEstimate(2, :) - M2)
    
    plot(timeGPS, trueState(2, 1:(accF / gpsF): end) - posterioriStateEstimate(2, :))
    P2 = squeeze(sqrt(P(2, 2, :)));
    P2 = P2.';
    plot(timeGPS, trueState(2, 1:(accF / gpsF): end) - posterioriStateEstimate(2, :) + P2)
    plot(timeGPS, trueState(2, 1:(accF / gpsF): end) - posterioriStateEstimate(2, :) - P2)
    title('Delta Velocity Error')
    xlabel('Time (sec)')
    ylabel('Delta Velocity Error (m / sec)')
    legend('Priori Error', 'Priori Error +1 sigma', 'Priori Error -1 sigma', 'Posteriori Error', 'Posteriori Error +1 sigma', 'Posteriori Error -1 sigma')
    hold off
    
    figure (8)

    plot(timeAcc, trueState(3, :) - prioriStateEstimate(3, :))
    hold on
    M3 = squeeze(sqrt(M(3, 3, :)));
    M3 = M3.';

    plot(timeAcc, trueState(3, :) - prioriStateEstimate(3, :) + M3)
    plot(timeAcc, trueState(3, :) - prioriStateEstimate(3, :) - M3)
    
    plot(timeGPS, trueState(3, 1:(accF / gpsF): end) - posterioriStateEstimate(3, :))
    P3 = squeeze(sqrt(P(3, 3, :)));
    P3 = P3.';
    plot(timeGPS, trueState(3, 1:(accF / gpsF): end) - posterioriStateEstimate(3, :) + P3)
    plot(timeGPS, trueState(3, 1:(accF / gpsF): end) - posterioriStateEstimate(3, :) - P3)
    title('Bias Error')
    xlabel('Time (sec)')
    ylabel('Bias Error (m / sec^2)')
    legend('Priori Error', 'Priori Error +1 sigma', 'Priori Error -1 sigma', 'Posteriori Error', 'Posteriori Error +1 sigma', 'Posteriori Error -1 sigma')
    hold off
    
    figure (9)
    
    subplot(3, 3, 1)
    M1 = transpose(squeeze(M(1, 1, :)));
    P1 = transpose(squeeze(P(1, 1, :)));
    pavg1 = transpose(squeeze(truePavg(1, 1, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('1,1 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 2)
    M1 = transpose(squeeze(M(1, 2, :)));
    P1 = transpose(squeeze(P(1, 2, :)));
    pavg1 = transpose(squeeze(truePavg(1, 2, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('1,2 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 3)
    M1 = transpose(squeeze(M(1, 3, :)));
    P1 = transpose(squeeze(P(1, 3, :)));
    pavg1 = transpose(squeeze(truePavg(1, 3, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('1,3 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 4)
    M1 = transpose(squeeze(M(2, 1, :)));
    P1 = transpose(squeeze(P(2, 1, :)));
    pavg1 = transpose(squeeze(truePavg(2, 1, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('2,1 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 5)
    M1 = transpose(squeeze(M(2, 2, :)));
    P1 = transpose(squeeze(P(2, 2, :)));
    pavg1 = transpose(squeeze(truePavg(2, 2, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('2,2 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 6)
    M1 = transpose(squeeze(M(2, 3, :)));
    P1 = transpose(squeeze(P(2, 3, :)));
    pavg1 = transpose(squeeze(truePavg(2, 3, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('2,3 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 7)
    M1 = transpose(squeeze(M(3, 1, :)));
    P1 = transpose(squeeze(P(3, 1, :)));
    pavg1 = transpose(squeeze(truePavg(3, 1, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('3,1 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 8)
    M1 = transpose(squeeze(M(3, 2, :)));
    P1 = transpose(squeeze(P(3, 2, :)));
    pavg1 = transpose(squeeze(truePavg(3, 2, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('3,2 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    subplot(3, 3, 9)
    M1 = transpose(squeeze(M(3, 3, :)));
    P1 = transpose(squeeze(P(3, 3, :)));
    pavg1 = transpose(squeeze(truePavg(3, 3, :)));
    
    plot(timeAcc, M1)
    hold on
    plot(timeGPS, P1)
    plot(timeGPS, pavg1)
    
    title('3,3 - Covariance')
%     xlabel('Time (sec)')
%     ylabel('1,1 - Covariance (m)')
    legend('M', 'P', 'Pavg')
    hold off
    
    figure (10)
    
    subplot(3,1,1)
    pavg1 = transpose(squeeze(truePavg(1, 1, :)));
    plot(timeGPS, stateErrorAverages(1, :))
    hold on
    plot(timeGPS, stateErrorAverages(1, :) + pavg1)
    plot(timeGPS, stateErrorAverages(1, :) - pavg1)
    title('Position Average Error')
    xlabel('Time (sec)')
    ylabel('Position Average Error (m)')
    legend('Average Error', 'Average Error +1 Sigma', 'Average Error -1 Sigma')
    hold off
    
    subplot(3,1,2)
    pavg1 = transpose(squeeze(truePavg(2, 2, :)));
    plot(timeGPS, stateErrorAverages(2, :))
    hold on
    plot(timeGPS, stateErrorAverages(2, :) + pavg1)
    plot(timeGPS, stateErrorAverages(2, :) - pavg1)
    title('Velocity Average Error')
    xlabel('Time (sec)')
    ylabel('Velocity Average Error (m / sec)')
    legend('Average Error', 'Average Error +1 Sigma', 'Average Error -1 Sigma')
    hold off
    
    subplot(3,1,3)
    pavg1 = transpose(squeeze(truePavg(3, 3, :)));
    plot(timeGPS, stateErrorAverages(3, :))
    hold on
    plot(timeGPS, stateErrorAverages(3, :) + pavg1)
    plot(timeGPS, stateErrorAverages(3, :) - pavg1)
    title('Bias Average Error')
    xlabel('Time (sec)')
    ylabel('Bias Average Error (m / sec^2)')
    legend('Average Error', 'Average Error +1 Sigma', 'Average Error -1 Sigma')
    hold off
    
    figure (11)
    subplot(3, 3, 1)
    OPL = transpose(squeeze(productErrDiffStateEst(1, 1, :)));
    plot(timeGPS, OPL)
    title('1, 1 Orthogonality of Error with Estimates')
    subplot(3, 3, 2)
    OPL = transpose(squeeze(productErrDiffStateEst(1, 2, :)));
    plot(timeGPS, OPL)
    title('1, 2 Orthogonality of Error with Estimates')
    subplot(3, 3, 3)
    OPL = transpose(squeeze(productErrDiffStateEst(1, 3, :)));
    plot(timeGPS, OPL)
    title('1, 3 Orthogonality of Error with Estimates')
    subplot(3, 3, 4)
    OPL = transpose(squeeze(productErrDiffStateEst(2, 1, :)));
    plot(timeGPS, OPL)
    title('2, 1 Orthogonality of Error with Estimates')
    subplot(3, 3, 5)
    OPL = transpose(squeeze(productErrDiffStateEst(2, 2, :)));
    plot(timeGPS, OPL)
    title('2, 2 Orthogonality of Error with Estimates')
    subplot(3, 3, 6)
    OPL = transpose(squeeze(productErrDiffStateEst(2, 3, :)));
    plot(timeGPS, OPL)
    title('2, 3 Orthogonality of Error with Estimates')
    subplot(3, 3, 7)
    OPL = transpose(squeeze(productErrDiffStateEst(3, 1, :)));
    plot(timeGPS, OPL)
    title('3, 1 Orthogonality of Error with Estimates')
    subplot(3, 3, 8)
    OPL = transpose(squeeze(productErrDiffStateEst(3, 2, :)));
    plot(timeGPS, OPL)
    title('3, 2 Orthogonality of Error with Estimates')
    subplot(3, 3, 9)
    OPL = transpose(squeeze(productErrDiffStateEst(3, 3, :)));
    plot(timeGPS, OPL)
    title('3, 3 Orthogonality of Error with Estimates')
end

