classdef CarSensor < handle
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        w
        a

        biasMu
        biasSigma
        bias
        accMu
        accSigma
        accF

        gpsMu
        gpsSigma
        gpsF

        A
        B

        initialPositionMu
        initialPositionSigma

        initialVelocityMu
        initialVelocitySigma
    end
    
    methods
        function obj = CarSensor(accF, gpsF, biasMu, biasVariance, accMu, accVariance, gpsMu, gpsVariance)
            obj.w = 2 * pi * 0.1;
            obj.a = 10;

            obj.accF = accF;

            obj.biasMu = biasMu;
            obj.biasSigma = biasVariance^0.5;

            obj.accMu = accMu;
            obj.accSigma = accVariance^0.5;

            obj.A = [1, 1/obj.accF; 0, 1];
            obj.B = [0.5 * ((1/obj.accF)^2); 1/obj.accF];

            obj.gpsF = gpsF;

            obj.gpsSigma = gpsVariance^0.5;
            obj.gpsMu = gpsMu.';

            obj.initialPositionMu = 0;
            obj.initialPositionSigma = 10;

            obj.initialVelocityMu = 100;
            obj.initialVelocitySigma = 1;

        end

        function [timeAcc, timeGPS, accAs, trueAs, accXs, trueXs, gpsXs] = getData(obj, t)
            timeSamples = linspace(0, t, 1 + t * obj.accF);
            initialPosition = mvnrnd(obj.initialPositionMu, obj.initialPositionSigma);
            initialVelocity = mvnrnd(obj.initialVelocityMu, obj.initialVelocitySigma);

            [trueAs, trueXs, timeAcc] = obj.getTrue(timeSamples, initialPosition, initialVelocity);
            [accAs, accXs] = obj.getAcc(trueAs);
            gpsXs = obj.getGPS(trueXs(:, 1:(obj.accF/obj.gpsF):end));
            timeGPS = timeSamples(1:(obj.accF/obj.gpsF):end);
        end

        function [trueAs, trueXs, timeSamples] = getTrue(obj, timeSamples, initialPosition, initialVelocity)
            trueAs = obj.a * sin(obj.w * timeSamples);
            trueXs = [initialPosition + (initialVelocity + (obj.a/obj.w)) * timeSamples - (obj.a/(obj.w^2)) * sin(obj.w * timeSamples); 
                      initialVelocity + (obj.a / obj.w) - (obj.a/obj.w) * cos(obj.w * timeSamples)];
        end

        function [accAs, accXs] = getAcc(obj, trueAs)
            len = size(trueAs);

            noise = mvnrnd(obj.accMu, obj.accSigma, len(2));
            obj.bias = mvnrnd(obj.biasMu, obj.biasSigma, 1);
            accAs = trueAs + obj.bias + noise.';
            
            accX = [obj.initialPositionMu; obj.initialVelocityMu];
            accXs = zeros(2, len(2));
            
            for i = 1:len(2)
                accX = obj.A * accX + obj.B * accAs(i);
                accXs(:, i) = accX;
            end

        end

        function [gpsXs] = getGPS(obj, trueXs)
            len = size(trueXs);

            noise = mvnrnd(obj.gpsMu, obj.gpsSigma, len(2));

            gpsXs = trueXs + noise.';
        end

    end
end

