classdef ZieglerNichols
    
    % Private Properties
    properties (Access = private)
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    
    methods
        % Constructor
        function obj = ZieglerNichols(dynamicsParameters)
            obj.theta = dynamicsParameters.theta;
            obj.tau = dynamicsParameters.tau;
            obj.k = dynamicsParameters.k;
        end
        
        % Here we'll output PID parameters
        function outputArg = getPIDParameters(obj)
            Kp = obj.calculateKp();
            Ti = obj.calculateTi();
            Td = obj.calculateTd();
            outputArg = PIDParameters(Kp, Ti, Td);
        end
     
        function Kp = calculateKp(obj)
            Kp = (1.2 * obj.tau) / (obj.k * obj.theta);
        end
        
        function Ti = calculateTi(obj)
            Ti = 2 * obj.theta;
        end
        
        function Td = calculateTd(obj)
            Td = 0.5 * obj.theta;
        end
 
    end

end