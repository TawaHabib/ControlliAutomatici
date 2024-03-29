%% Costanti di trasduttore e attuatore
clear
clc
close all
% Lookup table attuatore (pompa)
% Tensioni normalizzate
Tn_A=0:0.5:5;
% Portata volumetrica
Q_A=1e-6*[0 8.8 24.6 42.0 57.1 72.4 86.1 102.3 117.6 132.0 144.9];
% Lookup table trasduttore di livello
% livello vasca
L_T=0:0.01:0.2;
% Tensioni normalizzate
Tn_T=[4.5221 4.4452 4.2412 3.9653 3.7932 3.5179 3.2742 3.0624 2.8349 2.5936 2.3522 2.1423 1.9151 1.6591 1.4251 1.1892 0.9053 0.7329 0.4750 0.2664 0.0471];

Au=43*1e-6;
g=9.8;
Area=0.08;
hu=-0.095;

%% 1.0-Simulazione modello non linerare
%si noti che qui 0 significa 9.5cm
x0=0;
open("Vasca_1es.mdl")
sim("Vasca_1es.mdl")
%% 2.0-linearizazzione
bx=0.1;
[bx,bu,by,dx]=trim('Vasca_NL', bx,[],[],1);
[A,B,C,D]=linmod('Vasca_NL',bx,bu);
sys=ss(A,B,C,D);

%% 3.0-Confronto modello linearizzato vs non lineare
mol=0.01;
rit=10;
open("ConfrontoRispostaScalino.mdl")
sim("ConfrontoRispostaScalino.mdl")
pause
mol=0.1;
sim("ConfrontoRispostaScalino.mdl")
%nel primo caso e meglio del secondo perche siamo vicini al punto di
%equilibrio

%% 4 traccio bode e verifico
bode(sys)
tf(sys)