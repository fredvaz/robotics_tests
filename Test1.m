clear all
clc
close all

%% Test 1

%% 1)

% Referencial Inicial
home = [ 1  0  0  0;
         0  1  0  0;
         0  0  1  0;
         0  0  0  1 ];

% Eixo de Rota��o em A
r = [-1 1 0]';
phi = deg2rad(45);

% IMPORTANTE: a vectorRot j� faz a normaliza��o
ar_ = normVector(r);


%% a)









