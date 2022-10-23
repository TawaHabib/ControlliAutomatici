clear
clc
close all

%% 1+massamollalineare
%parametri per il modello MassaMollaLineare.slxc
M = 1.0;
k = 0.33;
h = 1.1;

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;
x0 = [0; 0];

