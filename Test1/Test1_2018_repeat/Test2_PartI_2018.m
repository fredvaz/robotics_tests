clear all
clc
close all

format short 

%% Test 2 - 2017
disp('------------------------ Test 2 Part I - 2017 ---------------------')
disp(' ')

% 1) Modelo cinemático directo do Robot RPR
syms theta1 theta2 d3 theta4 theta5 theta6

% Offset/comprimentos dos elos (fixos)
syms a lg

% Junta Rotacional ou Prismática:
R = 1; P = 0;

% Robot [RPR] - Matriz dos parametros de Denavith-Hartenberg: PJ_DH
%_________________________________________________________________________________
%          thetai  |  di  |  ai |  alfai | offseti | jointtypei
%_________________________________________________________________________________
PJ_DH = [  theta1      0      0    -pi/2        0           R;   % Junta Rotacional
%_________________________________________________________________________________
           theta2      a      0    -pi/2    -pi/2           R;   % Junta Rotacional
%_________________________________________________________________________________
                0     d3      0        0        0           P;   % Junta Prismática
%_________________________________________________________________________________
           theta4      0      0     pi/2     pi/2           R;   % Junta Rotacional           
%_________________________________________________________________________________
           theta5      0      0    -pi/2        0           R;   % Junta Rotacional   
%_________________________________________________________________________________
           theta6     lg      0        0    -pi/2           R; ]; % Junta Rotacional
%_________________________________________________________________________________

% A cinematica directa da base até ao Gripper: 
[ T0_G, Ti ] = MGD_DH(PJ_DH);       

% Offset/comprimentos dos elos (fixos)
PJ_DH = eval(subs(PJ_DH, [a lg], [50 50]));

% INICIALIZAÇÃO DO ROBOT: CRIAR LINKS
[ robot ] = robot_links(PJ_DH);


%% VARIÁVEIS GLOBAIS

%Valores Juntas "HOME"
q_home = [0 0 0 0 0 0];

% Referencial Inicial 0
T0 = [ 1  0  0  0;
       0  1  0  0;
       0  0  1  0
       0  0  0  1 ];
      
%% 1) Esquemático do manipulador na configuração "home":

% Prespectiva de lado do Robot
N = 100;
figure;
robot.teach(q_home, 'workspace', [-N N -N N -50 N], 'jaxes');

% Plot do esquemático dos elos:
figure;
Plot_Robot(T0, Ti, q_home, [10 10], [-5 15 -5 15 -5 5]);


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
t0_3_syms = simplify( t0_G - lg * Rz0_G )


% Aux. Cinemática Inversa das juntas: theta1, theta2 e d3
t0_G = T0_G(1:3,4);
Rz0_G = T0_G(1:3,3);

% tx' e ty' => 0 t 2 = 0 t G - L4 * 0 Rz G
t0_3 = simplify( t0_G - lg * Rz0_G )


%% Aux. Cinemática Inversa das juntas: theta4, theta4 e theta5

% Auxiliar Base ao Braço -> 2 T 0:
T0_1 = Ti(:,:,1);
T1_2 = Ti(:,:,2);
T2_3 = Ti(:,:,3);

T0_3 = simplify( T0_1 * T1_2 * T2_3 );

T3_0 = simplify( inv(T0_3) );

% Resultado - Gripper no Elo 2 -> 2 T G:
T3_G = simplify(  T3_0 * T0_G )  

% Matriz Simbólica 2 T G: De forma a conhecer que valores usar dados em O T G
T2_G_nsat = simplify( T3_0 * T0_G_nsat )

            

%% Teste às soluções da Cinemática Inversa:

q = [ pi/4 pi/3 pi/2 pi/3 ];

T0_G_ =  eval(subs(T0_G, [L1 L2 L3], [1 0.5 0.25]));

% Matriz de transformação de O T G dados os valores das juntas do robô
T0_G_values = eval(subs(T0_G_, [theta1 d2 theta3 theta4 theta5], q));

% Juntas do Robô dadas pela Cinemática Inversa do robot
q_byinv = inverse_kinematics(T0_G_values)

% Confirmação usando a robotics toolbox
q_bytoolbox = robot.ikine(T0_G_values, 'mask', [0 1 1 1 1 1]); % [x y z roll pitch yaw]


























