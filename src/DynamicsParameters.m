classdef DynamicsParameters
    properties
        theta   {mustBeNumeric}
        tau     {mustBeNumeric}
        k       {mustBeNumeric}
    end
    methods
        function obj = DynamicsParameters(theta, tau, k)
            obj.theta = theta;
            obj.tau = tau;
            obj.k = k;
        end
    end
end