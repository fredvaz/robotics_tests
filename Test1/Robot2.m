close all
clear all
clc


%% Robot 3-DOF: RRR-RR

syms d1 theta2 theta3 d4

% Comprimentos dos elos:


% Junta Rotacional ou Prismatica:
R = 1; P = 0;
%______________________________________________________________________________________
%          thetai  |  di  |  ai |  alfai | offseti | jointtypei | range_min | range_max         
%______________________________________________________________________________________
PJ_DH = [  pi/2     d1      0  pi/2+pi/4      5           P       0       10;   % Junta Rotacional
%______________________________________________________________________________________
           theta2      2      1     pi/2    -pi/2           R       -pi/3       pi/4;   % Junta Rotacional
%______________________________________________________________________________________
           theta3      0      0    -pi/2        0           R       -pi/2       pi/2;   % Junta Rotacional
%______________________________________________________________________________________
                0     d4      0        0        2           P       0         10; ];  % Junta Rotacional
%______________________________________________________________________________________

% A cinematica directa da base   até ao Gripper: 
[ oTg, Ti ] = direct_kinematics(PJ_DH);       

oTg = simplify(oTg);
Ti  = simplify(Ti) ;


%% INICIALIZAÇÃO DO ROBOT: CRIAR LINKS


for i = 1 : size(PJ_DH,1)
    
    if PJ_DH(i,6) == R              % Juntas Rotacionais
        
        L(i) = Link('d',eval(PJ_DH(i,2)),...
                    'a', eval(PJ_DH(i,3)),...
                    'alpha', eval(PJ_DH(i,4)),...
                    'offset', eval(PJ_DH(i,5)),...
                    'qlim', eval(PJ_DH(i,7:8)));
    end
    
    if PJ_DH(i,6) == P              % Junta Prismática
        
        L(i) = Link('theta',eval(PJ_DH(i,1)),...
                    'a', eval(PJ_DH(i,3)),...
                    'alpha', eval(PJ_DH(i,4)),...
                    'offset', eval(PJ_DH(i,5)),...
                    'qlim', [0 10]);
        
    end

end

robot = SerialLink(L, 'name', 'Robot Planar RRR');


%% VARIÁVEIS GLOBAIS 
 
q = [0 0 pi/2 pi/3]; %valor das juntas em "home"

q = [0 0 0 0];


%% MENU ("main")

% Variaveis MENU
select = 0;
STOP = 2;

while(select ~= STOP)
    
    select = menu('Seleccione a acao a realizar:', 'Cinematica Directa',...
                                                   'Plot do Robot',...
                                                   'Quit');  
                                                
    %% Matriz dos parametros de Denavith-Hartenberg: PJ_DH
    if select == 1  
        disp('______________________________________________________________________')
        disp(' ')
        disp('PJ_DH: Matriz dos parametros de Denavith-Hartenberg:')
        disp('______________________________________________________________________')
        disp(' ')
        PJ_DH_ = SerialLink(L, 'name', 'Robot Planar RRPRP')
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
    
    %% PLOT DO ROBOT:
    
    if select == 2
        figure('units','normalized','outerposition',[0 0 1 1]);
         % Prespectiva de lado do Robot  

        robot.teach(q, 'workspace', [-7 7 -7 7 -1 7], 'reach', ... 
                       1, 'scale', 1, 'zoom', 0.25); % 'view', 'top', 'trail', 'b.');

    disp('#######################################################################') 
    end  


end % fim do menu/ fim do exercicio