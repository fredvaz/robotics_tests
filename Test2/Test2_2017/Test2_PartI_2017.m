clear all
clc
close all

format short 

%% Test 2 - 2017
disp('------------------------ Test 2 Part I - 2017 ---------------------')
disp(' ')

% 1) Modelo cinemático directo do Robot RPR
syms theta1 theta2 theta3 theta4

% Offset/comprimentos dos elos (fixos)
syms L1 L2 L3 L4

% Junta Rotacional ou Prismática:
R = 1; P = 0;

% Robot [RPR] - Matriz dos parametros de Denavith-Hartenberg: PJ_DH
%_________________________________________________________________________________
%          thetai  |  di  |  ai |  alfai | offseti | jointtypei
%_________________________________________________________________________________
PJ_DH = [       0     L1      0    -pi/2        0           R;   % Elo de ancoragem
%_________________________________________________________________________________
           theta1     L2      0     pi/2        0           R;   % Junta Rotacional
%_________________________________________________________________________________
           theta2      0     L3     pi/2        0           R;   % Junta Rotacional
%_________________________________________________________________________________
           theta3      0      0     pi/2     pi/2           R;   % Junta Rotacional           
%_________________________________________________________________________________
           theta4     L4      0        0        0           R; ]; % Junta Rotacional
%_________________________________________________________________________________

% A cinematica directa da base até ao Gripper: 
[ T0_G, Ti ] = MGD_DH(PJ_DH);       

% Offset/comprimentos dos elos (fixos)
PJ_DH = eval(subs(PJ_DH, [L1 L2 L3 L4], [10 10 10 10]));

% INICIALIZAÇÃO DO ROBOT: CRIAR LINKS
[ robot ] = robot_links(PJ_DH);


%% VARIÁVEIS GLOBAIS

%Valores Juntas "HOME"
q_home = [0 0 0 0];

% Referencial Inicial 0
T0 = [ 1  0  0  0;
       0  1  0  0;
       0  0  1  0
       0  0  0  1 ];
      
%% 1) Esquemático do manipulador na configuração "home":

% Prespectiva de lado do Robot
N = 40;
figure;
robot.teach([q_home 0], 'workspace', [-N N -N N -5 N], 'jaxes');

% Plot do esquemático dos elos:
figure;
Plot_Robot(T0, Ti, q_home, [10 10 10 10], [-2 25 -2 15 -2 15]);


%% 2) Cinemática Inversa/Solução para às variáveis das juntas:
%NOTAS: Auxiliar ao cálculo da inversa. Olhar 1º para a 0 T G e perceber 
% o que se anula entre a Matriz de Rotação e o vector t, e a que atraso na
% cadeia da cinemática corresponde, isto é, 0 T X (0 T 2)

syms nx ny nz sx sy sz ax ay az tx ty tz

T0_G_nsat = [ nx sx ax tx;
              ny sy ay ty;
              nz sz az tz;
               0  0  0  1 ];

% Vector Simbólico
t0_G = T0_G_nsat(1:3,4);
Rz0_G = T0_G_nsat(1:3,3);
t0_2_syms = simplify( t0_G - L4 * Rz0_G )


% Aux. Cinemática Inversa das juntas: theta1 e theta2
t0_G = T0_G(1:3,4);
Rz0_G = T0_G(1:3,3);

% tx' e ty' => 0 t 2 = 0 t G - L4 * 0 Rz G
t0_2 = simplify( t0_G - L4 * Rz0_G )


% Aux. Cinemática Inversa das juntas: theta3 e theta4

% Auxiliar Base ao Braço -> 2 T 0:
T0_1 = Ti(:,:,1);
T1_2 = Ti(:,:,2);

T0_2 = simplify( T0_1 * T1_2 );

T2_0 = simplify( inv(T0_2) );

% Resultado - Gripper no Elo 2 -> 2 T G:
T2_G = simplify(  T2_0 * T0_G )  

% Matriz Simbólica 2 T G: De forma a conhecer que valores usar dados em O T G
T2_G_nsat = simplify( T2_0 * T0_G_nsat )

            

%% Teste às soluções da Cinemática Inversa:

q = [ pi/4 pi/3 pi/2 pi/3 ];

T0_G_ =  eval(subs(T0_G, [L1 L2 L3], [1 0.5 0.25]));

% Matriz de transformação de O T G dados os valores das juntas do robô
T0_G_values = eval(subs(T0_G_, [theta1 d2 theta3 theta4 theta5], q));

% Juntas do Robô dadas pela Cinemática Inversa do robot
q_byinv = inverse_kinematics(T0_G_values)

% Confirmação usando a robotics toolbox
q_bytoolbox = robot.ikine(T0_G_values, 'mask', [0 1 1 1 1 1]); % [x y z roll pitch yaw]


























