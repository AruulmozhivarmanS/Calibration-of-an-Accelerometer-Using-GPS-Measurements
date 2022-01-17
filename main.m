clc;
clear;
close all;

accF = 200;
gpsF = 5;

kf = myKalmanFilter(0.0004, [1, 0; 0, 0.0016], 200, 5);
[prioriErrorCovariance, posterioriErrorCovariance, kalmanGain] = kf.computeErrorCovariance(30);

lenAcc = size(prioriErrorCovariance);
lenGPS = size(posterioriErrorCovariance);

n = 1000;

accXs = zeros(2, lenAcc(3), n);
trueXs = zeros(2, lenAcc(3), n);

prioriStateEstimates = zeros(3,lenAcc(3), n);
posterioriStateEstimates = zeros(3, lenGPS(3), n);

measurements = zeros(2, lenGPS(3), n);

trueStates = zeros(3, lenAcc(3), n);

for i = 1:n
    sensor = CarSensor(200, 5, 0, 0.01, 0, 0.0004, [0; 0], [1, 0; 0, 0.0016]);
    [timeAcc, timeGPS, accA, trueA, accX, trueX, gpsX] = sensor.getData(30);
    
    measurementData = getMeasurements(gpsX, accX, 5, 200);
    
    kf = myKalmanFilter(0.0004,  [1, 0; 0, 0.0016], 200, 5);
    [prioriStateEstimate, posterioriStateEstimate] = kf.processData(measurementData, kalmanGain, timeAcc, timeGPS);
    
    accXs(:, :, i) = accX;
    trueXs(:, :, i) = trueX;
    
    prioriStateEstimates(:, :, i) = prioriStateEstimate;
    posterioriStateEstimates(:, :, i) = posterioriStateEstimate;

    trueStates(:, :, i) = [trueX - accX; sensor.bias * ones(1, lenAcc(3))];   

    measurements(:, :, i) = measurementData;
end

runNumber = 67;

[stateErrorAverages, truePavg, productErrDiffStateEst, residualProduct] = monteCarloAnalysis(trueStates, posterioriStateEstimates, accF, gpsF, prioriStateEstimates, kf.H, measurements);

plotStateOutput(prioriStateEstimates, posterioriStateEstimates, trueStates, timeAcc, timeGPS, trueXs, accXs, 200, 5, runNumber, posterioriErrorCovariance, prioriErrorCovariance, truePavg, stateErrorAverages, productErrDiffStateEst)
