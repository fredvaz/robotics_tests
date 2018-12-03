clear all
clc
close all

%% Homework #1 2017/2018

%% 3) 2 Referenciais A e B (Sistemas de coordenadas) 
% Sabemos ^Xb, ^Yb etc 

% e o ponto origem de B em A
AtBorig = [ 5 -3 1 ];

% Ver a folha de resolução
aRb = [  sqrt(2)/2  0  sqrt(2)/2;
         0          1  0;
        -sqrt(2)/2  0  sqrt(2)/2  ];
    
aTb = [ aRb AtBorig';
        0  0  0  1 ];

disp('Matriz transformação A T B:');
disp(aTb);

%% a) Recolocar B coicidente com A, i.e, aTb = I (indentidade)
disp(' '); disp(' ');
disp('------------- Alinea a) -----------');

% Encontrar os angulos de rotação:
disp('Angulos Roll-Pitch-Yaw:');
angles = tr2rpy(aTb); %, 'deg'
disp(angles);

% Inverter a sequência significa trocar os sinais dos movimentos e ângulo:

% I = Roy,-45º * Tox,-5 * Toy,3 * Toz,-1 * aTb
%     ^ em ultímo as rotações

disp('Indetidade:')
I =  rpy2tr(-angles) * transl(-5, 3, -1) * aTb;
disp(I);


%% b) Obter o quartinião Unitario e o vector de rotação e respectivo phi
disp(' '); disp(' ');
disp('------------- Alinea b) -----------');
  
[ r, phi, QU ] = quarternionByR(aRb);
disp([rad2deg(phi) r']);    
    
    
%% c) B T B' da rotação de B sobre o eixo Ar e o ângulo de rotação pi/3    
disp(' '); disp(' ');
disp('------------- Alinea c) -----------');    
    
% IMPORTANTE: a vectorRot já faz a normalização
ar_ = normVector(r);    
 
disp('Matriz que siginifica uma rotação de pi/3 segundo o eixo Ar:');    
Tar_phi = angvec2tr(pi/3, ar_); % B T B' 

aTbl = Tar_phi * aTb;
disp(aTbl);

% Acima é descrita a dedução final que vêm de:
% A T B' = A T B * B T B'
% onde B T B' = B T A * T ar * A T B
% A T B' = T ar * A T B

% Da mesma forma: B T B ' = B T A * A T B' 
%                         = B T A * T ar * A T B 
%                         = T ar
% Prova:
disp('B T A * T ar * A T B :');  
bTbl = inv(aTb) * angvec2tr(pi/3, ar_) * aTb; % que é igual a Tar_phi, aTb anulam-se
disp(bTbl);
disp('T ar');
disp(Tar_phi);
disp('B T B":');   
bTbl = inv(aTb) * aTbl;
disp(bTbl);


%% Visualização e Animação 
axis = [-8 8 -8 8 -6 6];

figure('units','normalized','outerposition',[0 0 1 1]);
% Referencial Home -> A
bTa = inv(aTb);
trplot(bTa, 'axis', axis, 'color', 'b', 'frame', 'A', 'view', [20 20]);
hold on
% Eixo r em A
plot3([bTa(1,4) bTa(1,4)+2*r(1,1)], [bTa(2,4) bTa(2,4)+2*r(2,1)], [bTa(3,4) bTa(3,4)+2*r(3,1)], 'm-');
hold on
% Referencial B
trplot(aTb, 'axis', axis, 'color', 'r', 'frame', 'B', 'view', [20 20]);
hold on
% Rodar novo B' segundo A r
tranimate(aTb, aTbl, 'axis', axis, 'color', 'g', 'frame', 'Bn');
hold on


%% d) B T B' da rotação de B sobre o eixo Ar e o ângulo de rotação pi/3    
disp(' '); disp(' ');
disp('------------- Alinea d) -----------');    
    
Av = [-3 4 1];
disp('A v:')
disp(Av);

Bv = inv(aTb) * [ Av 1 ]';

disp('B v:')
disp(Bv(1:3)');

% Nota: Não sei se está certo...


%% Visualização e Animação 
axis = [-8 8 -8 8 -6 6];

figure('units','normalized','outerposition',[0 0 1 1]);
% Referencial Home -> A
bTa = inv(aTb);
trplot(bTa, 'axis', axis, 'color', 'b', 'frame', 'A', 'view', [20 20]);
hold on
% Referencial B
trplot(aTb, 'axis', axis, 'color', 'r', 'frame', 'B', 'view', [20 20]);
hold on

% Ponto r em A
plot3([bTa(1,4) bTa(1,4)+Av(1,1)], [bTa(2,4) bTa(2,4)+Av(1,2)], [bTa(3,4) bTa(3,4)+Av(1,3)], 'k-');
hold on
% Ponto r em B
plot3([aTb(1,4) aTb(1,4)+Bv(1,1)], [aTb(2,4) aTb(2,4)+Bv(2,1)], [aTb(3,4) aTb(3,4)+Bv(3,1)], 'm-');
hold on














    
    
    
    
    
    
    