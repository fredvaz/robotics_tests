clear all
clc
close all

%% Homework #1 2017/2018

% Referencial Inicial
home = [ 1  0  0  0;
         0  1  0  0;
         0  0  1  0;
         0  0  0  1 ];
   
%% Ex1

% Eixo de Rotação em A
r = [0 0 1]';
phi = deg2rad(45);

% IMPORTANTE: a vectorRot já faz a normalização
ar_ = normVector(r);


%% ------------- Alinea a) -----------
disp(' '); disp(' ');
disp('------------- Alinea a) -----------');

% aTb aqui traduz a rotação de B sobre o eixo r em A de angulo de phi 
disp('Matriz transformação B->A')
% aTb = vectorRot(ar_, phi);
% disp(aTb);

% Confirmação c/ Robotics Toolbox
aTb = angvec2tr(phi, ar_);
disp(aTb);


% Angulos
disp('Angulos Roll-Pitch-Yaw')
[alpha, beta, gamma] = euler_inv(aTb);

% alpha = rad2deg(alpha) 
% beta = rad2deg(beta) 
% gamma = rad2deg(gamma)

% Confirmação c/ Robotics Toolbox
ang = tr2rpy(aTb, 'deg');
disp(ang);


%% Visualização e Animação 
axis = [-5 5 -5 5 -1 1];

figure('units','normalized','outerposition',[0 0 1 1]);
% Referencial Home 
trplot(home, 'axis', axis, 'color', 'b', 'frame', 'A', 'view', [60 25]);
hold on
% Eixo r em A
plot3([home(1,4) home(1,4)+r(1,1)], [home(2,4) home(2,4)+r(2,1)], [home(3,4) home(3,4)+r(3,1)], 'm-');
hold on
% Mover para B 
tranimate(home, aTb, 'axis', axis, 'color', 'r', 'frame', 'B');



%% ------------- Alinea b) -----------
disp(' '); disp(' ');
disp('------------- Alinea b) -----------');

% i) Rodar A pi/3 sobre A_r

% significa rodar pi/3 o novo A' em relação ao antigo A --> A T A'
aTal = angvec2tr(pi/3, ar_); % * I (aTa não mexe...)

% onde A' T A = inv(A T A') nota: trans_inverse é a nossa função <=> inv()
alTa = inv(aTal);

disp('Rotação sobre Ar:');
disp(alTa);

% A' é o referencial a mover - resultado final parcial
alTb = alTa * aTb; 
% ^ resultado para visualização


% ii) Deslocar B 4 unidades segundo A_r

% significa multiplicar 4 unidades pelos pontos do eixo --> B T B'
T4ar = transl(4 * ar_); 

disp('Translação:');
disp(T4ar);
% nota: ou a nossa trans(0, 0, 0, pos)

% onde B T B' = B T A * T 4 ar * A T B - É suprimido na forma final
% bTbl = inv(aTb) * T4ar * aTb;
%         ^ corta a rotação em A T B


% Resultado Final: A' T B ' = A' T A * A T B * B T B'
%                           = inv(A T A') * A T B * B T A * T 4 ar * A T B
%                                                 ^ = I 
%                           = inv(A T A') * T 4 ar * A T B

alTbl = inv(aTal) * T4ar * aTb;

disp('Transformação Al->Bl');
disp(alTbl)

% importante a sequência de mutiplicação de movimentos, não é igual a ordem
% em que se pede os movimentos!


%% ------------- Alinea c) -----------
disp(' '); disp(' ');
disp('------------- Alinea c) -----------');

[R, t] = tr2rt(alTbl);
disp('Deslocamento a efectuar segundo os eixos do referencial A:');
disp(t);

% A' T B' = T [-2.8284, 2.8284, 0] * inv(A T A') * A T B

alTbl_ = transl(t) * inv(aTal) * aTb;


%% ------------- Alinea d) -----------
disp(' '); disp(' ');
disp('------------- Alinea d) -----------');

[R, t] = tr2rt(aTb);
[Rn, tn] = tr2rt(alTbl);

tab = t+Rn*tn



%% Visualização e Animação 
axis = [-5 5 -5 5 -1 1];

figure('units','normalized','outerposition',[0 0 1 1]);
% Referencial Home 
trplot(home, 'axis', axis, 'color', 'b', 'frame', 'A', 'view', [70 10]);
hold on
% Eixo r em A
plot3([home(1,4) home(1,4)+r(1,1)], [home(2,4) home(2,4)+r(2,1)], [home(3,4) home(3,4)+r(3,1)], 'm-');
hold on
% Rodar novo A' -> A
tranimate(home, aTal, 'axis', axis, 'color', 'r', 'frame', 'An');
hold on

%% No entanto queremos o inverso pelo que se traduz rodar -pi/3

figure('units','normalized','outerposition',[0 0 1 1]);
% Referencial Home 
trplot(home, 'axis', axis, 'color', 'b', 'frame', 'A', 'view', [70 25]);
hold on
% Eixo r em A
plot3([home(1,4) home(1,4)+r(1,1)], [home(2,4) home(2,4)+r(2,1)], [home(3,4) home(3,4)+r(3,1)], 'm-');
hold on
% Rodar A' T A = (A T A')^-1
tranimate(home, alTa, 'axis', axis, 'color', 'r', 'frame', 'An');
hold on


%% Ao rodar A automaticamente B é rodado, pois B relaciona-se com A

figure('units','normalized','outerposition',[0 0 1 1]);
% A' rodado em relação a home (A inicial)
trplot(alTa, 'axis', axis,'color', 'b', 'frame', 'An', 'view', [70 25]);
hold on
% Transformação inicial aTb -> alTb  
tranimate(aTb, alTb, 'axis', axis, 'color', 'r', 'frame', 'Bn');
hold on

% Atenção! Eixo r em A fica no mesmo sítio - prova:
% Pois estamos apenas a rodar sobre o mesmo, não a deslocar
plot3([alTa(1,4) alTa(1,4)+r(1,1)], [alTa(2,4) alTa(2,4)+r(2,1)], [alTa(3,4) alTa(3,4)+r(3,1)], 'm-');
hold on
plot3([home(1,4) home(1,4)+r(1,1)], [home(2,4) home(2,4)+r(2,1)], [home(3,4) home(3,4)+r(3,1)], 'k-');


%% Ao deslocar B 4 unidades segundo o eixo A r 

figure('units','normalized','outerposition',[0 0 1 1]);
% A' rodado em relação a home (A inicial)
trplot(alTa, 'axis', axis, 'color', 'b', 'frame', 'An', 'view', [20 25]);
hold on
% Eixo r em A
plot3([alTa(1,4) alTa(1,4)+4*ar_(1,1)], [alTa(2,4) alTa(2,4)+4*ar_(2,1)], [alTa(3,4) alTa(3,4)+4*ar_(3,1)], 'm-');
hold on
% Transformação inicial alTb -> alTbl  
tranimate(alTb, alTbl, 'axis', axis, 'color', 'r', 'frame', 'Bn');
hold on


%% Ao deslocar B 4 unidades segundo o referencial A (eixos de A)

figure('units','normalized','outerposition',[0 0 1 1]);
% A' rodado em relação a home (A inicial)
trplot(alTa, 'axis', axis, 'color', 'b', 'frame', 'An', 'view', [20 25]);
hold on
% Eixo r em A
plot3([alTa(1,4) alTa(1,4)+4*ar_(1,1)], [alTa(2,4) alTa(2,4)+4*ar_(2,1)], [alTa(3,4) alTa(3,4)+4*ar_(3,1)], 'm-');
hold on
% Transformação inicial alTb -> alTbl  
tranimate(alTb, alTbl_, 'axis', axis, 'color', 'r', 'frame', 'Bn');
hold on





























