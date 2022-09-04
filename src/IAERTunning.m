classdef IAERTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = IAERTunning(dynamicsParameters)
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
            Kp = (1/obj.k)*(1.435*(obj.theta/obj.tau)^-0.921);
        end
        
        function Ti = calculateTi(obj)
            Ti = obj.tau/(0.878*(obj.theta/obj.tau)^-0.749);
        end
        
        function Td = calculateTd(obj)
            Td = obj.tau*(0.482*(obj.theta/obj.tau)^1.137);
        end
 
    end
end
