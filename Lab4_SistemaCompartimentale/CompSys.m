clear
clc
close all
%% 1.0-Inizializzazione
k1=1;
k2=0.5;
b1=0.5;
b2=1;

A=[-k1 0;k1 -k2];
B=[0 b2]';
C=[0 1];
D=0;

sys=ss(A,B,C,D);

%% 1.1-Raggiungibilità con solo con inezione in vena

% ctrb(sys)
rank(ctrb(sys))
%Rank(marice di raggiungibilita')<2 --> sistema non completamente
%raggiungibile, solo la x2 punto lo è
%% 1.2 solo in vene 
%% 1.2.1 continuo
uc=(0.5*k2/b2);
[YC,TC,XC]=step(sys*uc);

%% 1.2.2-Iniezioni ad intervalli regolari
%tra 0.45-0.55
% deltaImpulsi=(log((0.55/0.45))/(k2));
% ampiezzaImpulsi=(exp(k2*deltaImpulsi)*0.45/(5.5*b2));

%tra 0.49-0.53
deltaImpulsi=-(log((0.49/0.53))/(k2));
ampiezzaImpulsi=(exp(k2*deltaImpulsi)/(27*b2));
numeroImpulsi=100;

t = linspace(0,deltaImpulsi,10);

x = [0 0];
Y = [];
X = [];
T = [];
for i = 1:numeroImpulsi
    [yl,tl,xl] = initial(sys,x,t);
    [yf,tf,xf] = impulse(sys*ampiezzaImpulsi,t);
    Y = [Y; yl+yf];
    X = [X; xl+xf];
    T = [T t+deltaImpulsi*(i-1)];
    x = xf(end,:) + xl(end,:);
end

%% 1.2.3-Grafici e vincoli
figure(1)
subplot(2,1,1)
plot(T,Y)
hold on 
plot([0 T(length(T))],[0.55 0.55],'r')
hold on 
plot([0 T(length(T))],[0.45 0.45],'r')
grid on
title('Concentrazione nel sangue iniezione ad intervalli regolari')
legend('farmaco nel sangue','limite')

subplot(2,1,2)
plot(TC,YC)
hold on 
plot([0 TC(length(TC))],[0.55 0.55],'r')
hold on 
plot([0 TC(length(TC))],[0.45 0.45],'r')
grid on
title('Concentrazione nel sangue iniezione continua')
legend('farmaco nel sangue','limite')

%% pulisco
clear
clc
close all

%% 2.0-Inizializazzione
clc
k1=1;
k2=0.5;
b1=0.5;
b2=1;

A=[-k1 0;k1 -k2];
B=[b1 0]';
C=[0 1];
D=0;

sys=ss(A,B,C,D);
%% 2.1-raggiungibilità ingestione

% ctrb(sys)
rank(ctrb(sys))
%Rank(marice di raggiungibilita')=2 --> sistema  completamente
%raggiungibile
%% 2.2-determinazione sperimentale
deltaImpulsi=1.8220;
ampiezzaImpulsi=0.9381;
numeroImpulsi=100;

t = linspace(0,deltaImpulsi,10);

x = [0 0];
Y = [];
X = [];
T = [];
for i = 1:numeroImpulsi
    [yl,tl,xl] = initial(sys,x,t);
    [yf,tf,xf] = impulse(sys*ampiezzaImpulsi,t);
    Y = [Y; yl+yf];
    X = [X; xl+xf];
    T = [T t+deltaImpulsi*(i-1)];
    x = xf(end,:) + xl(end,:);
end

%% 2.3-Grafici e vincoli
figure(1)
plot(T,Y)
hold on 
plot([0 T(length(T))],[0.55 0.55],'r')
hold on 
plot([0 T(length(T))],[0.45 0.45],'r')
grid on
title('Concentrazione nel sangue pillole ad intervalli regolari')
legend('farmaco nel sangue','limite')

%% 2.4-Osservabilità del sistema
rank(obsv(sys))
%rango matrice osservabilità =2 ==> sistema completamente osservabile 
%% 2.5-osservabilità se cambia la trasformazione d'uscita 
%posso concludere che lo stato x1 diventerebbe osservabite mentre lo stato
%x2 non lo diventerebbe per il raggionamento iniziale che ha fatto il prof
%ragionamento (prima delle def di oss.tà):
%   ________________             ___________________ 
%  |     x1(dot)    |---x1----> |      x2(dot)      |
%   ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾    |        ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
%                       #--->y
%ragionamento senza fare calcoli. facendo quindi i calcoli dovremmo
%ottenere che il rango della matrice osservabilità deve fare 1 e non piu 2:
C=[1 0];
sys=ss(A,B,C,D);
rank(obsv(sys))
%% non ho capito cosa si intente per cosa si puo dedurre!
