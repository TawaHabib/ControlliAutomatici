clear
clc
close all
%% 1.0-Modello
M = 1.0;
k = 0.33;
h = 1.1;

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;

%% 1.1-stabilità con autovalori
[E,V]=eig(A)
%CONCLUSIONI
%Parte reale di tutti gli autovalori negativa==> sistena ass. stabile
%Autovalori complessi e cognugati ==> Il movimento del sistema
%ha oscillazioni smorsate dato che i suai autovalori stanno nel secondo 
%e terzo quadrante

%% 1.2-stabilita con Lyapunov
 
P=lyap(A', diag(ones(2,1),0))
eig(P)
%p è definita positiva quindi concludo che il sistema è ass. stabile

%% 2.1 studio stabilita
x=[0.5 0;1 0; 2 0]
open("SF_MassaMolla.mdl");
for i=1:3
    x0=x(i,:)'
    sys=sim("SF_MassaMolla.mdl");
    
    pause
end