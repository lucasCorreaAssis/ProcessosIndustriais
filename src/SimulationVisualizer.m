classdef SimulationVisualizer    
    methods(Static)
        
        function plotOutput(Reference, OutputRead)
            plot(OutputRead(:,1),OutputRead(:,2),'b','linewidth',4); hold on;
            plot(Reference(:,1),Reference(:,2),'k','linewidth',4); hold on;
            ylabel('Output [-]');
            grid on;
        end
        
        function plotControlSignal(Input)
            plot(Input(:,1),Input(:,2),'color',[0, 0.5, 0],'linewidth',4);
            xlabel('Time [s]');
            ylabel('Input [-]');
            grid on;
        end
        
        function plotError(Error)
            plot(Error(:,1),Error(:,2),'r','linewidth',4);
            xlabel('Time [s]');
            ylabel('Error [-]');
            grid on;
        end
    end
end

