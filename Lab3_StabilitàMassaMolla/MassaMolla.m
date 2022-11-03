clear
clc
close all


M = 1.0;
k = 0.33;
h = 1.1;
%% 1-studio stabilità dei punti di equilibro del sistema non linerare


x=[0.5 0;1 0; 2 0];
for i=1:3
    x0=x(i,:)'
    [X,U] = trim('SF_MassaMolla',x0,[],[],1);
    [Al,~,~,~] = linmod('SF_MassaMolla',X,U);
    eig(Al) 
    pause
end
%Consclisioni
%1-ass stabile
%2-nan--> uno=0
%3.instabile

%% 2-3-confronto risposta all scalino
open("ConfrontoRispostaDelGradino.mdl")
c1=[1.1,0.95];
x=[0.5 0;1 0; 2 0];
for i=1:length(x(:,1))
    x0=x(i,:)'
    for j=1:length(c1)
        c=c1(1,j)
        [X,U,Y] = trim('SF_MassaMolla',x0,[],[],1);
        [Al,Bl,Cl,Dl] = linmod('SF_MassaMolla',X,U);
        sim("ConfrontoRispostaDelGradino");
        pause
    end
end
