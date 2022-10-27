clear
clc
close all

%% 1+massamollalineare
%parametri per il modello MassaMollaLineare.slx
M = 1.0;
k = 0.33;
h = 1.1;

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;

sys = ss(A,B,C,D);
x0 = [0 0]';    

open('MassaMollaLinearemdl')      % Apre un file .mdl, cioe' un file simulink

H=[1,0.1];

for i = 1:length(H)
    K1=H(i)
    sim('MassaMollaLinearemdl')       % Lancia una simulazione del file .mdl
    pause
end
%% TODO

% SISTEMI NON LINEARI
% ======================================================================
% Per i sistemi non lineari non possiamo utilizzare la definizione del
% sistema in forma matriciale. Dobbiamo utilizzare le funzioni che
% descrivono la trasformazione di stato e di uscita.
% Utilizziamo dunque il blocco S-function per 
% descrivere un sistema nella forma non-lineare.

% DEFINIZIONE DEL SISTEMA NON LINEARE
% Aprire un nuovo file simulink
% Inserire una S-function usando il template
% Salvare il modello matematico così creato per il
%   sistema non-lineare, con un input ed un output. Abbiamo un modello del
%   tutto generale che non dipende da precisi valori dei parametri del
%   sistemi.
open('mm_nonlineare')      % Apre un file .mdl, cioe' un file simulink
sim('mm_nonlineare')       % Lancia una simulazione del file .mdl
% Provare a cambiare K
% pause








% SOVRAPPOSIZIONE DEGLI EFFETTI
% ======================================================================
K2 = 0.05;
open('sovrapposizione_effetti')
sim('sovrapposizione_effetti')



