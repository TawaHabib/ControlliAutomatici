clear
clc
close all

%% Parametri per tutti
M = 1.0;
k = 0.33;
h = 1.1;
x0 = [0 0]';    

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;
%% 1+massamolla lineare
%parametri per il modello MassaMollaLineare.slx





open('MassaMollaLinearemdl')      

H=[1,0.1];

for i = 1:length(H)
    K1=H(i)
    sim('MassaMollaLinearemdl')       
    pause
end

%% 2-risposta scalino (di ampiezza 0.1) massa molla lineare

K1=0.1;
open('mm_nonlineare')
sim('mm_nonlineare')


%% 3-Sovrapposizione effetti

K1=0.1;
K2=0.05;
open('sovrapposizione_effetti')
sim('sovrapposizione_effetti')



