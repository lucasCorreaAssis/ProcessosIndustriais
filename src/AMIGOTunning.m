classdef AMIGOTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = AMIGOTunning(dynamicsParameters)
            obj.theta = dynamicsParameters.theta;
            obj.tau = dynamicsParameters.tau;
            obj.k = dynamicsParameters.k;
        end
        
        % Here we'll calculate PI parameters
        function outputArg = getPIParameters(obj)
            Kp = obj.calculatePIKp();
            Ti = obj.calculatePITi();
            Td = 0.0;
            outputArg = PIDParameters(Kp, Ti, Td);
        end
     
        function Kp = calculatePIKp(obj)
            Kp = (1/obj.k)*(0.15 + 0.35*(obj.tau/obj.theta) - (obj.tau^2/(obj.theta+obj.tau)^2));
        end
        
        function Ti = calculatePITi(obj)
            Ti = obj.theta * (0.35 + (13*obj.tau^2)/(obj.tau^2 + 12*obj.theta*obj.tau)+7*obj.theta^2);
        end
 
    end
end

