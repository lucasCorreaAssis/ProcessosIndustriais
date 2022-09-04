classdef IAESRTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = IAESRTunning(dynamicsParameters)
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
            Kp = (1/obj.k)*(1.086*(obj.theta/obj.tau)^-0.869);
        end
        
        function Ti = calculateTi(obj)
            Ti = obj.tau/(0.740+(-0.130)*(obj.theta/obj.tau));
        end
        
        function Td = calculateTd(obj)
            Td = obj.tau*(0.348*(obj.theta/obj.tau)^0.914);
        end
 
    end
end
