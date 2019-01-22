clear all
clc
close all

format short 

%% Test 2 - 2017
disp('------------------------ Test 2 Part I - 2017 ---------------------')
disp(' ')

% 1) Modelo cinem�tico directo do Robot RPR
syms theta1 theta2 d3 theta4 theta5 theta6

% Offset/comprimentos dos elos (fixos)
syms a lg

% Junta Rotacional ou Prism�tica:
R = 1; P = 0;

% Robot [RPR] - Matriz dos parametros de Denavith-Hartenberg: PJ_DH
%_________________________________________________________________________________
%          thetai  |  di  |  ai |  alfai | offseti | jointtypei
%_________________________________________________________________________________
PJ_DH = [  theta1      0      0    -pi/2        0           R;   % Junta Rotacional
%_________________________________________________________________________________
           theta2      a      0    -pi/2    -pi/2           R;   % Junta Rotacional
%_________________________________________________________________________________
                0     d3      0        0        0           P;   % Junta Prism�tica
%_________________________________________________________________________________
           theta4      0      0     pi/2     pi/2           R;   % Junta Rotacional           
%_________________________________________________________________________________
           theta5      0      0    -pi/2        0           R;   % Junta Rotacional   
%_________________________________________________________________________________
           theta6     lg      0        0    -pi/2           R; ]; % Junta Rotacional
%_________________________________________________________________________________

% A cinematica directa da base at� ao Gripper: 
[ T0_G, Ti ] = MGD_DH(PJ_DH);       

% Offset/comprimentos dos elos (fixos)
PJ_DH = eval(subs(PJ_DH, [a lg], [50 50]));

% INICIALIZA��O DO ROBOT: CRIAR LINKS
[ robot ] = robot_links(PJ_DH);


%% VARI�VEIS GLOBAIS

%Valores Juntas "HOME"
q_home = [0 0 0 0 0 0];

% Referencial Inicial 0
T0 = [ 1  0  0  0;
       0  1  0  0;
       0  0  1  0
       0  0  0  1 ];
      
%% 1) Esquem�tico do manipulador na configura��o "home":

% Prespectiva de lado do Robot
N = 100;
figure;
robot.teach(q_home, 'workspace', [-N N -N N -50 N], 'jaxes');

% Plot do esquem�tico dos elos:
figure;
Plot_Robot(T0, Ti, q_home, [10 10], [-5 15 -5 15 -5 5]);


%% 2) Cinem�tica Inversa/Solu��o para �s vari�veis das juntas:
%NOTAS: Auxiliar ao c�lculo da inversa. Olhar 1� para a 0 T G e perceber 
% o que se anula entre a Matriz de Rota��o e o vector t, e a que atraso na
% cadeia da cinem�tica corresponde, isto �, 0 T X (0 T 2)

syms nx ny nz sx sy sz ax ay az tx ty tz

T0_G_nsat = [ nx sx ax tx;
              ny sy ay ty;
              nz sz az tz;
               0  0  0  1 ];

% Vector Simb�lico
t0_G = T0_G_nsat(1:3,4);
Rz0_G = T0_G_nsat(1:3,3);
t0_3_syms = simplify( t0_G - lg * Rz0_G )


% Aux. Cinem�tica Inversa das juntas: theta1, theta2 e d3
t0_G = T0_G(1:3,4);
Rz0_G = T0_G(1:3,3);

% tx' e ty' => 0 t 2 = 0 t G - L4 * 0 Rz G
t0_3 = simplify( t0_G - lg * Rz0_G )


%% Aux. Cinem�tica Inversa das juntas: theta4, theta4 e theta5

% Auxiliar Base ao Bra�o -> 2 T 0:
T0_1 = Ti(:,:,1);
T1_2 = Ti(:,:,2);
T2_3 = Ti(:,:,3);

T0_3 = simplify( T0_1 * T1_2 * T2_3 );

T3_0 = simplify( inv(T0_3) );

% Resultado - Gripper no Elo 2 -> 2 T G:
T3_G = simplify(  T3_0 * T0_G )  

% Matriz Simb�lica 2 T G: De forma a conhecer que valores usar dados em O T G
T2_G_nsat = simplify( T3_0 * T0_G_nsat )

            

%% Teste �s solu��es da Cinem�tica Inversa:

q = [ pi/4 pi/3 pi/2 pi/3 ];

T0_G_ =  eval(subs(T0_G, [L1 L2 L3], [1 0.5 0.25]));

% Matriz de transforma��o de O T G dados os valores das juntas do rob�
T0_G_values = eval(subs(T0_G_, [theta1 d2 theta3 theta4 theta5], q));

% Juntas do Rob� dadas pela Cinem�tica Inversa do robot
q_byinv = inverse_kinematics(T0_G_values)

% Confirma��o usando a robotics toolbox
q_bytoolbox = robot.ikine(T0_G_values, 'mask', [0 1 1 1 1 1]); % [x y z roll pitch yaw]


























