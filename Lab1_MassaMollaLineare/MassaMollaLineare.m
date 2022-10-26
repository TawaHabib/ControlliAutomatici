%% Questa è una sessione
%Questo è un commento
% puoi eseguire la sessione corrente con ctl+invio
%% Pulire

% cancella tutte le variabili in memoria
clear
% pulire CMD
clc
% close ALL  closes all figure windows whose handles are not hidden.
close all

%% 1-Creare il sistema massa-molla lineare descritto in variabili di stato
% ";" a fine riga serve per non visualizzare le variabili a cmd 
M = 1.0;
k = 0.33;
h = 1.1;


% ";"       ==> separatore di riga
% ","||" "  ==> separatore di colonna

A = [0 1; -k/M -h/M];
B = [0; 1/M];
C = [1 0];
D = 0;
% Creo il sistema con ss
sys = ss(A,B,C,D);

%% 2+4-Movimento libero del sistema massa-molla lineare.
% condizione iniziale
x0 = [1; 0];

%Plotto il movimento d'usita nella figura 
%NB in questo caso particolare di sistema massa molla lineare (per come
%abbiamo definito la matrice C e D) si plotta il movimento libero della x1
%ovvero la posizione
figure()
initial(sys,x0)

%% 2.1+4-Salvo poi plotto (movimento libero)

%MOVIMENTO LIBERO
%Y  matrice movimento d'uscita(in questo caso è un semplice vettore in
%   quanto le matrice C e D hanno una sola riga)
%X  matrice del movimento di stato (in qesto caso e una vera matrice 
%   fatta da 2 colonne ed n rigne 
%T  vettore dei tempi

[Y,T,X] = initial(sys,x0);

% plotto il movimento dl'uscita
figure()
plot(T,Y,'r')
title('Movimento di uscita','libero')
legend('posizione')
grid on


% plotto il movimento di stato
% Matrice(:,j) seleziona tutte le righe della colonna j
figure()
plot(T,X(:,1)) 
hold on 
plot(T,X(:,2))
title('Movimento di stato','libero')
legend('Posizione','Velocità')
grid on

%% 2.2+4: specificare l'istante di tempo finale (tf)

tf = 50;
[Y,T,X] = initial(sys,x0,tf);
figure()
plot(T,Y,'.')
title('Movimento d''uscita','libero')
legend('Posizione')
grid on 
figure()
plot(T,X(:,1),'r') 
hold on 
plot(T,X(:,2),'g')
title('Movimento di stato','libero')
legend('Posizione','Velocità')
grid on


%% 2.3+4-specificare tutto il vettore tempo 

% vettore tempo equispaziato fra 0 e 40 sec  di 1000 elementi.
t = linspace(0,40,1000);
[Y,T,X] = initial(sys,x0,t);

figure()
plot(T,Y,'.')
title('Movimento d''uscita','libero')
legend('Posizione')
grid on 

figure()
plot(T,X(:,1),'r') 

hold on 

plot(T,X(:,2),'g')
title('Movimento di stato','libero')
legend('Posizione','Velocità')
grid on



%% 3 + 4 - RISPOSTA AD IMPULSO (MOVIMENTO FORZATO)
tf=25;
[Y,T,X] = impulse(sys,tf);

figure()
plot(T,Y,'r')
title('Movimento di uscita','Risposta impulso di ampiezza unitaria')
legend('posizione')
grid on

figure()
plot(T,X(:,1)) 
hold on 
plot(T,X(:,2))
title('Movimento di stato','Risposta impulso di ampiezza unitaria')
legend('Posizione','Velocità')
grid on

%% 5-VARIARE SMORZAMENTO DEL SISTEMA

H = 0:0.25:2;

figure()
for i = 1:length(H)
    h = H(i);       
    A = [0 1; -k/M -h/M];
    sys = ss(A,B,C,D);
    [Y,T,X] = initial(sys,x0,t);
    plot(T,Y)           
    grid on
    hold on 
    %E vettore colonna che contiene gli autovalori di a
    E=eig(A)
end
legend('h=0','h=0.25','h=0.5','h=0.75','h=1','h=1.25','h=1.5','h=1.75','h=2')
title('Movimento libero (uscita)','Diversi coifficienti di smorsamento del pistone' )

figure()
for i = 1:length(H)
    h = H(i); 
    A = [0 1; -k/M -h/M];
    sys = ss(A,B,C,D);
    [Y,T,X] = impulse(sys,t);
    plot(T,Y)     
    grid on 
    hold on 
end
legend('h=0','h=0.25','h=0.5','h=0.75','h=1','h=1.25','h=1.5','h=1.75','h=2')
title('Risposta impulsiva(uscita)','Diversi coifficienti di smorsamento del pistone' )

%% 6-RISPOSTA ALLO SCALINO
h=1.1;
A = [0 1; -k/M -h/M];
sys = ss(A,B,C,D);

t = 0:0.02:20; 
[Y,T,X] = step(sys,t);

figure(1)

subplot(2,1,1)
plot(T,X)
title('Risposta a scalino dello stato') 
legend('Posizione','Velocita')
grid on

subplot(2,1,2)
plot(T,Y)
title('Risposta a scalino dell''uscita') 
grid on


%% 7-TRENO DI IMPULSI
%NB utilizziamo la sovrapposizione degli effetti
deltaImpulsi=1;
ampiezzaImpulsi=2;
numeroImpulsi=40;

%vettore dei tempi che va da 0 a 1 (di 20 elementi)
t = linspace(0,deltaImpulsi,20);

%stato iniziale; prima dell'esperimento è nella posizione di riposo con
%velocità zero
x = [0 0];
Y = [];
X = [];
T = [];
for i = 1:numeroImpulsi
    %movimento libero
    [yl,tl,xl] = initial(sys,x,t);
    %movimento dovuto all'impulso di ampiezza indicata prima
    [yf,tf,xf] = impulse(sys*ampiezzaImpulsi,t);
    %movimento d'uscita che è la sovrapposizione tra il movimento libero 
    %d'uscita e il movimento dovuto all'impulso dato
    Y = [Y; yl+yf];
    %movimento dello stato che è la sovrapposizione tra il movimento libero 
    %di stato e il movimento dovuto all'impulso dato
    X = [X; xl+xf];
    %aggiorno il vettore dei tempi che è dato dal vettore dei tempi e 
    T = [T t+deltaImpulsi*(i-1)];
    % lo stato iniziale del prossimo impulso è lo stato finale in cui si
    % trova il sistame dopo l'applicazione di questo impulso
    x = xf(end,:) + xl(end,:);
end

figure(1)
subplot(2,1,1)
plot(T,Y), grid on
title('Risposta dell''uscita al treno degli impulsi')
legend('posizione')
subplot(2,1,2)
plot(T,X), grid on
title('Risposta degli stati al treno degli impulsi')
legend('posizione','velocita')
