clear
clc
close all

%% 1.0-Modello sistema lineare
M = 1.0;
k = 0.33;
h = 1.1;

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;

%% 1.1-stabilità del sistema con autovalori
[E,V]=eig(A)
%CONCLUSIONI

%Parte reale di tutti gli autovalori negativa==> sistena ass. stabile
%Autovalori complessi e cognugati ==> Il movimento del sistema
%ha oscillazioni smorsate dato che i suai autovalori stanno nel secondo 
%e terzo quadrante

%% 1.2-stabilita del sistema con Lyapunov
 
P=lyap(A', diag(ones(2,1),0))
eig(P)
%p esiste ed è definita positiva quindi concludo che il sistema è ass. stabile