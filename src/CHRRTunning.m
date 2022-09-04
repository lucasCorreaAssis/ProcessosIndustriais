classdef CHRRTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = CHRRTunning(dynamicsParameters)
            obj.theta = dynamicsParameters.theta;
            obj.tau = dynamicsParameters.tau;
            obj.k = dynamicsParameters.k;
        end
        
        % Here we'll calculate PID parameters
        function outputArg = getPIDParameters(obj)
            Kp = obj.calculateKp();
            Ti = obj.calculateTi();
            Td = obj.calculateTd();
            outputArg = PIDParameters(Kp, Ti, Td);
        end
     
        function Kp = calculateKp(obj)
            Kp = ((0.95*obj.tau)/(obj.k*obj.theta));
        end
        
        function Ti = calculateTi(obj)
            Ti = 2.375*obj.theta;
        end
        
        function Td = calculateTd(obj)
            Td = 0.421*obj.theta;
        end
 
    end
end
