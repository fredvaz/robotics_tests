clear all
clc
close all

format short 

%% Test 2 - 2017
disp('----------------------- Test 2 Part II - 2017 ---------------------')
disp(' ')

% % Junta Rotacional ou Prismática:
% R = 1; P = 0;
% 
% syms th1 th2 d
% % Offset/comprimentos dos elos (fixos)
% syms a b
% 
% % T0_1
% Ti(:,:,1) = [ -sin(th1)  0 cos(th1) -a*cos(th1);
%                cos(th1)  0 sin(th1)  a*sin(th1);
%                       0  1        0           b; 
%                       0  0        0           1  ];
% % T1_2
% Ti(:,:,2) = [  cos(th2)   0 -sin(th2) 0;
%                sin(th2)   0  cos(th2) 0;
%                       0  -1         0 0; 
%                       0   0         0 1  ];
% % T2_E
% Ti(:,:,3) = [  0  1  0   0;
%               -1  0  0   0;
%                0  0  1   d; 
%                0  0  0   1  ];
% 
% % T0_G = T0_1 * T1_2 * T2_E
% T0_G = Ti(:,:,1) * Ti(:,:,2) * Ti(:,:,3);


%% a) Jacobiano Geometrico do manipulador E J 6x3:
% expressões para a velocidade de rotação das juntas 

% Juntas em symbolic p/ resolver o Jacobiano
q_aux = [ theta1 theta2 d3 theta4 theta5 theta6 ];

% Matriz Jacobiana (Jacobiano na base)
Jac_0 = Jacobian(T0_G, Ti, q_aux, [R R P R R R]);

% Jacobiano no end-effector E J 6x3 = G R 0 x 0 Jac
R0_G = T0_G(1:3,1:3);
RG_0 = [  inv(R0_G)  zeros(3,3);
         zeros(3,3)   inv(R0_G) ];
     
Jac_E = simplify( RG_0 * Jac_0 );

%NOTA: Para ir para qq ponto/elo basta mutiplicar pela respectiva rotação
% isto é, x R 0, onde x = 0, 1, 2, E neste exercício.


%% Extra: Velocidades nas juntas em função das velocidades cartesianas
% Componentes de velocidade de interesse [ Vx Vy Wx ]
% nota: Jmxn, onde m=6 nº de velocidades cartesianas máximas
%                  n = nº de velocidades por junta (infi)
Jac_ = [ Jac_0(1:2, 1:3); Jac_0(4,1:3) ];

% Restrição na velocidade Wx
%syms Vx Vy Wx 
Wx = pi;

% Inversa da Jacobiana x Velocidades em
qVelocidades = inv(Jac_)*[ 0 0 Wx ]';

% Valores numéricos:
qVelocidades_ = eval(subs(qVelocidades, q_aux, [ 1 1 pi/3 ] ));


%% d) Valores das juntas p/ que assegura o equilibrio estático aplicando 
% binários/forças nulos nas juntas do manipulador quando se aplica no
% end-effector o vector de forças 0 F E, App = [0 -fy 0 -wx 0 0]'

syms fy wx

% Força aplicada no end-effector
F0_Eapp = [0 -fy 0 -wx 0 0]';

% Equilibrio estático: Força a aplicar = força aplicada no end-effector
F0_E = -F0_Eapp;

Bin = simplify( Jac_E' * F0_Eapp )

% Resolve equações para th1, th2 e d
equation = 0 == Bin(1);
theta1_sol = simplify( solve(equation, th1) )

equation = 0 == Bin(1);
theta2_sol = simplify( solve(equation, th2) )

equation = 0 == Bin(2);
d_sol = simplify( solve(equation, d) )


%% e) 



%% b) Configurações singulares de velocidade linear 

% offset/comprimentos dos elos (fixos)
%a_ = 5; b_ = 1;

%R0_1 = eval(subs(Ti(1:3,1:3,1), [th1 a b], [0 a_ b_]);
R0_1 = Ti(1:3,1:3,1);


Jv_1 = simplify( inv(R0_1) * Jac_0(1:3,1:6) )

%Jv_1 = eval(subs(Jv_1, [th1 th2 d a], [0 0 0 a_] ))

% De outra forma
%D = simplify( det(Jv_1) ) 
%D = det(Jv_1)

syms dth1 dth2 dd3 dth5 dth6

% theta 4 não mexe
Jv_1 = eval(subs(Jv_1, theta4, 0));

V = Jv_1 * [dth1 dth1 dd3 0 dth5 dth6]' % [0 0 0 0 0 0] %


V = eval(subs(V, q_aux, [ 0 theta2 -lg 0 0 0]));

%%
equation_Vx = 0 == simplify( V(1) );
sing_sol = simplify( solve(equation_Vx, d3) )

equation_Vy = 0 == simplify( V(1) );
sing_sol = simplify( solve(equation_Vy, d3) )

equation_Vz = 0 == simplify( V(1) );
sing_sol = simplify( solve(equation_Vz, d3) )


%% Também podemos resolver o det = 0 e det. as juntas singulares)
equation = 0 == simplify( det(Jv_1) );

sing_sol = simplify( solve(equation, d) )

% Se houver colunas a zero ^
% Se não temos que Igualar as velocidades Vx, Vy, Vz igual a zero;
% linha 1, linha2, linha3 == 0; e det. para q as valores das juntas 


%% Plot do esquemático do Robô
figure;
Plot_Robot_pII(Ti, [0 0 5], [a_ b_], [-6 6 -6 6 -6 10])






















