function measurementData = getMeasurements(gpsXs, accXs, gpsF, accF)
    measurementData = gpsXs - accXs(:, 1 : (accF/gpsF) : end);
end