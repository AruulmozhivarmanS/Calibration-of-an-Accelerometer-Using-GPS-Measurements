classdef myKalmanFilter < handle    
    properties
        accF
        gpsF

        phi
        gamma

        X
        W

        H
        V

        I
    end
    
    methods
        function obj = myKalmanFilter(processNoiseCovariance, measurementNoiseCovariance, accF, gpsF)
            obj.accF = accF;
            obj.gpsF = gpsF;

            obj.phi = [1, 1 / obj.accF, -0.5 * ((1 / obj.accF)^2); 0, 1, -1 / obj.accF; 0, 0, 1];
            obj.gamma = [-0.5 * ((1 / obj.accF)^2); -1 / obj.accF; 0];

            obj.W = processNoiseCovariance;

            obj.X = zeros(3, 1);
            obj.H = [1, 0, 0; 0, 1, 0];
            obj.V = measurementNoiseCovariance;

            obj.I = eye(3);
        end
        
        function [prioriErrorCovariance, posterioriErrorCovariance, kalmanGain] = computeErrorCovariance(obj, t)
            prioriErrorCovariance = zeros(3, 3, 1 + t * obj.accF);
            posterioriErrorCovariance = zeros(3, 3, 1 + t * obj.gpsF);
            kalmanGain = zeros(3, 2, 1 + t * obj.gpsF);
        
            len = size(prioriErrorCovariance);
            j = 0;
        
            P = [100, 0, 0; 0, 1, 0; 0, 0, 0.01];
        
            for i = 0:(len(3)-1)
                P = obj.phi * P * (obj.phi.') + obj.gamma * obj.W * (obj.gamma.');
                prioriErrorCovariance(:, :, i+1) = P;
                if((i / (obj.accF/obj.gpsF)) == j)
                    K = P * (obj.H.') * (obj.H * P * (obj.H.') + obj.V)^(-1);
                    P = (obj.I - K * obj.H) * P;
%                     P = (P^(-1) + obj.H.' * obj.V^(-1) * obj.H)^(-1);
                    posterioriErrorCovariance(:, :, j+1) = P;
                    kalmanGain(:, :, j+1) = K;
                    j = j+1;
                end
            end
        end

        function X = predict(obj)
            obj.X = obj.phi * obj.X;
            X = obj.X;
        end
        
        function X = update(obj, z, K)
            residual = z - obj.H * obj.X;
            obj.X = obj.X + K * residual;

            X = obj.X;
        end

        function [prioriStateEstimates, posterioriStateEstimates] = processData(obj, z, K, timeAcc, timeGPS)
            lenGPS = size(timeGPS);
            lenAcc = size(timeAcc);

            prioriStateEstimates = zeros(3, lenAcc(2));
            posterioriStateEstimates = zeros(3, lenGPS(2));

            j = 0;

            for i = 0:(lenAcc(2) - 1)

                obj.predict();
                prioriStateEstimates(:, i + 1) = obj.X;

                if((i / (obj.accF/obj.gpsF)) == j)
                    obj.update(z(:, j + 1), K(:, :, j + 1));
                    posterioriStateEstimates(:, j + 1) = obj.X;

                    j = j + 1;
                end
            end
        end
    end
end
