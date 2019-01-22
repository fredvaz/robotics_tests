
%% Plot do esquemático dos elos do robô:

function Plot_Robot(T0, Ti, q, L, axis)

syms theta1 theta2 d3 theta4 theta5 theta6
% Offset/comprimentos dos elos (fixos)
syms a lg


T0_1 = eval(subs(Ti(:,:,1), theta1, q(1) ));
T1_2 = eval(subs(Ti(:,:,2), [theta2 a], [q(2) L(1)] ));
T2_3 = eval(subs(Ti(:,:,3), d3, q(3) ));
T3_4 = eval(subs(Ti(:,:,4), theta4, q(4) ));
T4_5 = eval(subs(Ti(:,:,5), theta5, q(5) ));
T5_G = eval(subs(Ti(:,:,6), [theta6 lg], [q(6) L(2)] ));
% ^ acrescentar aqui

% Representação dos Elos do workspace (mundo)
%T0_1 = T0_1;
T0_2 = T0_1 * T1_2;
T0_3 = T0_1 * T1_2 * T2_3;
T0_4 = T0_1 * T1_2 * T2_3 * T3_4;
T0_5 = T0_1 * T1_2 * T2_3 * T3_4 * T4_5;
T0_G = T0_1 * T1_2 * T2_3 * T3_4 * T4_5  * T5_G;
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
trplot(T0_G, 'axis', axis, 'color', 'k', 'frame', 'TG');
hold on
% ^ acrescentar aqui

end
