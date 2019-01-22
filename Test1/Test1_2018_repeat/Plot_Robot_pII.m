
%% Plot do esquemático dos elos do robô:

function Plot_Robot_pII(Ti, q, L, axis)

syms th1 th2 d
% Offset/comprimentos dos elos (fixos)
syms a b


T0_1 = eval(subs(Ti(:,:,1), [th1 a b], [q(1) L(1) L(2)] ));
T1_2 = eval(subs(Ti(:,:,2), th2, q(2) ));
T2_3 = eval(subs(Ti(:,:,3), d, q(3) ));
% ^ acrescentar aqui

% Representação dos Elos do workspace (mundo)
%T0_1 = T0_1;
T0_2 = T0_1 * T1_2;
T0_3 = T0_1 * T1_2 * T2_3;
% ^ acrescentar aqui

% Visualização
%axis = [-8 8 -2 8 -2 8];

% Referencial Inicial 0
T0 = [ 1  0  0  0;
       0  1  0  0;
       0  0  1  0
       0  0  0  1 ];
   
% Referencial Home
trplot(T0, 'axis', axis, 'color', 'r', 'frame', 'T0', 'view', [75 10]);
hold on
trplot(T0_1, 'axis', axis, 'color', 'g', 'frame', 'T1');
hold on
trplot(T0_2, 'axis', axis, 'color', 'b', 'frame', 'T2');
hold on
trplot(T0_3, 'axis', axis, 'color', 'm', 'frame', 'T3');
hold on
% ^ acrescentar aqui

end
