classdef ITAESTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = ITAESTunning(dynamicsParameters)
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
            Kp = (0.965/obj.k)*(obj.tau/obj.theta)^0.85;
        end
        
        function Ti = calculateTi(obj)
            Ti = obj.tau * (1 / (0.796 - 0.1465*(obj.theta/obj.tau)));
        end
        
        function Td = calculateTd(obj)
            Td = 0.308*obj.tau*(obj.theta/obj.tau)^0.929;
        end
 
    end
end

