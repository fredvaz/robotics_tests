
%% Plot do esquemático dos elos do robô:

function Plot_Robot(T0, Ti, q, L, axis)

syms theta1 theta2 theta3 theta4
% Offset/comprimentos dos elos (fixos)
syms L1 L2 L3 L4


T0_1 = eval(subs(Ti(:,:,1), L1, L(1) ));
T1_2 = eval(subs(Ti(:,:,2), [theta1 L2], [q(1,1) L(2)] ));
T2_3 = eval(subs(Ti(:,:,3), [theta2 L3], [q(1,2) L(3)] ));
T3_4 = eval(subs(Ti(:,:,4), theta3, q(1,3) ));
T4_5 = eval(subs(Ti(:,:,5), [theta4 L4], [q(1,4) L(4)] ));
% ^ acrescentar aqui

% Representação dos Elos do workspace (mundo)
%T0_1 = T0_1;
T0_2 = T0_1 * T1_2;
T0_3 = T0_1 * T1_2 * T2_3;
T0_4 = T0_1 * T1_2 * T2_3 * T3_4;
T0_5 = T0_1 * T1_2 * T2_3 * T3_4 * T4_5;
% ^ acrescentar aqui

% Visualização
%axis = [-8 8 -2 8 -2 8];

% Referencial Home
trplot(T0, 'axis', axis, 'color', 'r', 'frame', 'T0', 'view', [75 10]);
hold on
trplot(T0_1, 'axis', axis, 'color', 'g', 'frame', 'T1');
hold on
trplot(T0_2, 'axis', axis, 'color', 'b', 'frame', 'T2');
hold on
trplot(T0_3, 'axis', axis, 'color', 'm', 'frame', 'T3');
hold on
trplot(T0_4, 'axis', axis, 'color', 'k', 'frame', 'T4');
hold on
trplot(T0_5, 'axis', axis, 'color', 'k', 'frame', 'T5');
hold on
% ^ acrescentar aqui

end
