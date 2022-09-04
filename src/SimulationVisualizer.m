classdef SimulationVisualizer    
    methods(Static)
        
        function plotOutput(Reference, OutputRead, color)
            arguments
                Reference
                OutputRead
                color = 'b';
            end
            plot(OutputRead(:,1),OutputRead(:,2),color,'linewidth',1); hold on;
            plot(Reference(:,1),Reference(:,2),'k','linewidth',1); hold on;
            ylabel('Output [-]');
            grid on;
        end

        function plotDiscreteOutput(Reference, OutputRead)
            stairs(OutputRead(:,1),OutputRead(:,2),'b','linewidth',1); hold on;
            stairs(Reference(:,1),Reference(:,2),'k','linewidth',1); hold on;
            ylabel('Output [-]');
            grid on;
        end
        
        function plotControlSignal(Input)
            plot(Input(:,1),Input(:,2),'color',[0, 0.5, 0],'linewidth',1);
            xlabel('Time [s]');
            ylabel('Input [-]');
            grid on;
        end

        function plotDiscreteControlSignal(Input)
            stairs(Input(:,1),Input(:,2),'color',[0, 0.5, 0],'linewidth',1);
            xlabel('Time [s]');
            ylabel('Input [-]');
            grid on;
        end
        
        function plotError(Error)
            plot(Error(:,1),Error(:,2),'r','linewidth',1);
            xlabel('Time [s]');
            ylabel('Error [-]');
            grid on;
        end

        function plotDiscreteError(Error)
            stairs(Error(:,1),Error(:,2),'r','linewidth',1);
            xlabel('Time [s]');
            ylabel('Error [-]');
            grid on;
        end
    end
end

