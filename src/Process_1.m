%% Define o processo

Model = 1;
LoadModel;
P1 = tf(num, den, 'InputDelay', delay);

%                       1
%  P1 = exp(-1*s) * ---------
%                   1.3 s + 1

% Como podemos observar pela função de transferên-
% cia em malha aberta, o processo não possui inte-
% grador. Por isso utiliza-se um controlador PI,
% para que o erro estacionário seja nulo.

%% Open Loop Output

figure(1)
step(P1);

% Observa-se que se trata de um sistema de primei-
% ra ordem com tempo morto.

%% Tempo de simulação

% Pela resposta em malha aberta observa-se que o
% tempo de análise necessário é de 10 segundos.
tempo = 0:0.01:10;

%% Dinâmica do processo

% Nesta seção obtemos os parâmetros que definem
% a dinâmica do processo:

% theta: atraso de transporte
% tau: constante de tempo
% k: ganho estático

dinamica = ProcessDynamics(P1, tempo);
parametros_dinamica = dinamica.getDynamicsParameters();

%% Ziegler Nichols

zn = ZieglerNichols(parametros_dinamica);
parametros_ZN = zn.getPIDParameters();

%% Controlador ZN

% Aqui utilizaremos o modelo do simulink disponi-
% bilizado para simulações: BaseControl.slx

% Dentro do simulink adicionei um bloco de con-
% trolador PID. Sendo que cada ganho recebe o 
% valor de uma variável do workspace:

% P : PROPORTIONAL_GAIN
% I : INTEGRAL_GAIN
% D : DERIVATIVE_GAIN

% Lembrando que I = Kp / Ti e D = Kp * Td
% Onde: 
% Kp: Ganho proporcional
% Ti: Tempo integrador
% Td: Tempo derivador

% Como estamos projetando um controlador PI, logo:
PROPORTIONAL_GAIN = parametros_ZN.Kp;
INTEGRAL_GAIN = parametros_ZN.Kp / parametros_ZN.Ti;
DERIVATIVE_GAIN = 0;

%% Rodando a Simulação

% É importante ressaltar que os dados obtidos com
% a simulação serão salvos no workspace

sim('BaseControl');

%% Plotando as respostas no tempo

figure(2);
% A classe SimulationVisualizer possui métodos para plotar 
% os dados da simulação.
sgtitle('ZN Tunning')
%% Saída: y(t)

subplot(311);
SimulationVisualizer.plotOutput(Reference, OutputRead);

%% Sinal de Controle: u(t)

subplot(312);
SimulationVisualizer.plotControlSignal(Input);

%% Error: e(t)

subplot(313);
SimulationVisualizer.plotError(Error);

%% Controle de Performance

Rt=Reference(:,2);
Yt=OutputRead(:,2);
Ut=Input(:,2);

IAE = sum(abs(Rt-Yt));

TV = sum(abs(diff(Ut)));

disp('Para o método de ZN, obteve-se:')
fprintf('IAE: %f     TV: %f\n', IAE, TV);

%% Método ITAE-S

itae_s = ITAESTunning(parametros_dinamica);
parametros_itae_s = itae_s.getPIDParameters();

%% Controlador ITAE-R

PROPORTIONAL_GAIN = parametros_itae_s.Kp;
INTEGRAL_GAIN = parametros_itae_s.Kp / parametros_itae_s.Ti;
DERIVATIVE_GAIN = 0;

%% Rodando a Simulação

sim('BaseControl');

%% Plotando as respostas no tempo

figure(3);
sgtitle('ITAE-s Tunning')
%% Saída: y(t)

subplot(311);
SimulationVisualizer.plotOutput(Reference, OutputRead);

%% Sinal de Controle: u(t)

subplot(312);
SimulationVisualizer.plotControlSignal(Input);

%% Error: e(t)

subplot(313);
SimulationVisualizer.plotError(Error);

%% Controle de Performance

Tt=Reference(:,1);
Rt=Reference(:,2);
Yt=OutputRead(:,2);
Ut=Input(:,2);

IAE = sum(abs(Rt-Yt));

TV = sum(abs(diff(Ut)));

disp('Para o método ITAE-s, obteve-se:')
fprintf('IAE: %f     TV: %f\n', IAE, TV);



