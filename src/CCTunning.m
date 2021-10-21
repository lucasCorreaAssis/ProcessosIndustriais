classdef CCTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = CCTunning(dynamicsParameters)
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
            Kp = (1/obj.k)*(0.25 + 1.35*(obj.tau/obj.theta));
        end
        
        function Ti = calculateTi(obj)
            Ti = obj.theta * ((1.35 + 0.25*(obj.theta/obj.tau)) / (0.54 + 0.33*(obj.theta/obj.tau)));
        end
        
        function Td = calculateTd(obj)
            Td = 0.5 * obj.theta * (1 / (1.35 + 0.25*(obj.theta/obj.tau)));
        end
 
    end
end

