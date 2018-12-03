clear all
clc
close all

format short 

%% Test 2 - 2017
disp('----------------------- Test 2 Part II - 2017 ---------------------')
disp(' ')

% Junta Rotacional ou Prismática:
R = 1; P = 0;

syms th1 th2 d
% Offset/comprimentos dos elos (fixos)
syms a b

% T0_1
Ti(:,:,1) = [ -sin(th1)  0 cos(th1) -a*cos(th1);
               cos(th1)  0 sin(th1)  a*sin(th1);
                      0  1        0           b; 
                      0  0        0           1  ];
% T1_2
Ti(:,:,2) = [  cos(th2)   0 -sin(th2) 0;
               sin(th2)   0  cos(th2) 0;
                      0  -1         0 0; 
                      0   0         0 1  ];
% T2_E
Ti(:,:,3) = [  0  1  0   0;
              -1  0  0   0;
               0  0  1   d; 
               0  0  0   1  ];

% T0_G = T0_1 * T1_2 * T2_E
T0_G = Ti(:,:,1) * Ti(:,:,2) * Ti(:,:,3);


%% a) Jacobiano Geometrico do manipulador 
% expressões para a velocidade de rotação das juntas 

% Juntas em symbolic p/ resolver o Jacobiano
q_aux = [ th1 th2 d ];

% Construir jacobiana 2 partir dos parâmetros calculados na Cinemática inversa
Jac = Jacobian(T0_G, Ti, q_aux, [R R P]);

% Componentes de velocidade objectivo [ Vx Vy Wx ]
Jac_ = [ Jac(1:2, 1:3); Jac(4,1:3) ];

% Restrição na velocidade Wx
%syms Vx Vy Wx 
Wx = pi;

% Inversa da Jacobiana x Velocidades em
qVelocidades = inv(Jac_)*[ 0 0 Wx ]';

% Valores numéricos:
qVelocidades_ = eval(subs(qVelocidades, q_aux, [ 1 1 pi/3 ] ));


%% d) Valores das juntas p/ o equilibrio estático



%% e) 



%% Plot do esquemático dos elos:
syms L1 L2 L3 L4

figure;
Plot_Robot(T0, Ti, [0 0 0], [10 10 10 10], [-2 25 -2 15 -2 15]);
% ^ necessita de alterações p/ este exercício
























