classdef ITAERTunning
   
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        function obj = ITAERTunning(dynamicsParameters)
            obj.theta = dynamicsParameters.theta;
            obj.tau = dynamicsParameters.tau;
            obj.k = dynamicsParameters.k;
        end
        
        % Here we'll calculate PI parameters
        function outputArg = getPIDParameters(obj)
            Kp = obj.calculateKp();
            Ti = obj.calculateTi();
            Td = obj.calculateTd();
            outputArg = PIDParameters(Kp, Ti, Td);
        end
     
        function Kp = calculateKp(obj)
            Kp = (1.357/obj.k)*(obj.tau/obj.theta)^0.947;
        end
        
        function Ti = calculateTi(obj)
            Ti = (obj.tau/0.842) * (obj.theta/obj.tau)^0.738;
        end
        
        function Td = calculateTd(obj)
            Td = 0.381*obj.tau*(obj.theta/obj.tau)^0.995;
        end
 
    end
end

