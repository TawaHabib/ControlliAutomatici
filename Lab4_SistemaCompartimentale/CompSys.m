clear
clc
close all

k1=1;
k2=0.5;
b1=0.5;
b2=1;
%% 0-Sistema completo


A=[-k1 0;k1 -k2];
B=[b1 b2]';
C=[0 1];

sys=ss(A,B,C,D);

%% 1.1-solo in vena matrice
A=[0 0;k1 -k2];
B=[0 b2]';
C=[0 1];
D=0;

sys=ss(A,B,C,D);

ctrb(sys)
rank(ctrb(sys))
%Rank(marice di raggiungibilita')<2 --> sistema non completamente
%raggiungibile