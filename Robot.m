clear all
clc
close all

%% Robot 3-DOF: RRR-RR

syms theta1 theta2 theta3 theta4 theta5

% Referencial Inicial 0
T0 = [ 1  0  0  0;
       0  1  0  0;
       0  0  1  0;
       0  0  0  1 ];

% Junta Rotacional ou Prismatica:
R = 1; P = 0;
%______________________________________________________________________________________
%          thetai  |  di  |  ai |  alfai | offseti | jointtypei | range_min | range_max         
%______________________________________________________________________________________
PJ_DH = [  theta1      0      0     pi/2     pi/2           R       -pi/2       pi/2;   % Junta Rotacional
%______________________________________________________________________________________
           theta2      0      4        0        0           R       -pi/3       pi/4;   % Junta Rotacional
%______________________________________________________________________________________
           theta3      0      2        0        0           R       -pi/2       pi/2;   % Junta Rotacional
%______________________________________________________________________________________
           theta4      0      0    -pi/2    -pi/2           R       -pi/2       pi/2;   % Junta Rotacional
%______________________________________________________________________________________
           theta5      1      0        0        0           R       -pi         pi; ];  % Junta Rotacional
%______________________________________________________________________________________

% A cinematica directa da base   até ao Gripper: 
[ oTg, Ti ] = direct_kinematics(PJ_DH);       

oTg = simplify(oTg);
Ti  = simplify(Ti);

%% MENU ("main")

% Variaveis MENU
select = 0;
STOP = 4;

while(select ~= STOP)
    
    select = menu('Seleccione a acao a realizar:', 'Cinematica Directa',...
                                                   'Home',...
                                                   'Animação',...
                                                   'Quit');  
                                                
    %% Matriz dos parametros de Denavith-Hartenberg: PJ_DH
    if select == 1  
        disp('______________________________________________________________________')
        disp(' ')
        disp('PJ_DH: Matriz dos parametros de Denavith-Hartenberg:')
        disp('______________________________________________________________________')
        disp(' ')
        disp('______________________________________________________________________')
        disp(' ')
        disp('a) oTg: Cinematica Directa c/ variaveis simbolicas:')
        disp('______________________________________________________________________')
        disp(' ')
        disp(oTg)
        disp(' ')
        disp('______________________________________________________________________')
    disp('#######################################################################')   
    end  
    
    %% PLOTS DO ROBOT:
    
    %% POSIÇÃO HOME
    if select == 2
        disp('______________________________________________________________________')
        disp(' ')
        disp('Posição Home')
        disp('______________________________________________________________________')
        disp(' ')
        
        figure('units','normalized','outerposition',[0 0 1 1]);
        % Visualização
        axis = [-5 8 -2 8 -2 5];
           
        q = [0 0 0 0 0]; % valor das juntas em "home"
    
        animateRobot(T0, Ti, q, axis);
        

    disp('#######################################################################') 
    end 
    
    %% Animação do Robô da juntas Home para as juntas  objectivo
    if select == 3
        disp('______________________________________________________________________')
        disp(' ')
        disp('Animação')
        disp('______________________________________________________________________')
        disp(' ')
        
        k = pi/2;

        figure('units','normalized','outerposition',[0 0 1 1]);

        for i=0:0.1:k 

            hold off
            pause(0.0001)

            q = [ i -i -i i];

            animateRobot(T0, Ti, q, axis);

        end

    disp('#######################################################################') 
    end 


end % fim do menu/ fim do exercicio