clear
clc
close all

M = 1.0;
k = 0.33;
h = 1.1;

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;
x0 = [0; 0];


sys = ss(A,B,C,D);
