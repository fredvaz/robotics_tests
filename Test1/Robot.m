clear all
clc
close all

%% Robot 3-DOF: RRR-RR

syms d1 theta2 theta3 d4

% Referencial Inicial 0
T0 = [ 1  0  0  0;
       0  1  0  0;
       0  0  1  0
       0  0  0  1 ];

%T0 = rpy2tr([0 -pi/2 0]);

% Junta Rotacional ou Prismatica:
R = 1; P = 0;
%_________________________________________________________________
%          thetai  |  di  |  ai |  alfai | offseti | jointtypei     
%_________________________________________________________________
PJ_DH = [    pi/2     d1      0  pi/2+pi/4      5           P;      % Junta Rotacional
%_________________________________________________________________
           theta2      2      1     pi/2    -pi/2           R;      % Junta Rotacional
%_________________________________________________________________
           theta3      0      0    -pi/2        0           R;      % Junta Rotacional           
%_________________________________________________________________
                0     d4      0        0        2           P ];    % Junta Rotacional
%_________________________________________________________________
% A cinematica directa da base   at� ao Gripper: 
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
                                                   'Anima��o',...
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
    
    %% POSI��O HOME
    if select == 2
        disp('______________________________________________________________________')
        disp(' ')
        disp('Posi��o Home')
        disp('______________________________________________________________________')
        disp(' ')
        
        figure('units','normalized','outerposition',[0 0 1 1]);
        % Visualiza��o
        axis = [-5 8 -2 8 -2 5];
           
        q = [0 0 0 0]; % valor das juntas em "home"
    
        animateRobot(T0, Ti, q, axis);
        

    disp('#######################################################################') 
    end 
    
    %% Anima��o do Rob� da juntas Home para as juntas  objectivo
    if select == 3
        disp('______________________________________________________________________')
        disp(' ')
        disp('Anima��o')
        disp('______________________________________________________________________')
        disp(' ')
        
        k = pi/2;

        figure('units','normalized','outerposition',[0 0 1 1]);

        for i=0:0.1:k 

            hold off
            pause(0.0001)

            q = [ 0 i 0 0 ];

            animateRobot(T0, Ti, q, axis);

        end

    disp('#######################################################################') 
    end 


end % fim do menu/ fim do exercicio